module 0x7e83ea488324f50fd83ef957c64ff402cb03ff7f0f6e11f86bd449ddec23b5ee::wewe_claim {
    struct App has key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        operator_pk: vector<u8>,
        balance: 0x2::balance::Balance<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>,
        version: u8,
    }

    struct WeweClaimed has copy, drop, store {
        receiver: address,
        id: u64,
        amount: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_deposit(arg0: &OwnerCap, arg1: &mut App, arg2: 0x2::coin::Coin<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>) {
        0x2::balance::join<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(&mut arg1.balance, 0x2::coin::into_balance<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(arg2));
    }

    entry fun admin_withdraw(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(&arg1.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>>(0x2::coin::from_balance<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(0x2::balance::split<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun claim(arg0: &mut App, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg0.start_time == 0 || v0 >= arg0.start_time, 6);
        assert!(arg0.end_time == 0 || v0 <= arg0.end_time, 7);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x1::string::utf8(b"WEWE_CLAIM:");
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(&v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v1));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v3) == true, 1);
        assert!(!0x2::dynamic_field::exists_<u64>(&arg0.id, arg1), 5);
        0x2::dynamic_field::add<u64, bool>(&mut arg0.id, arg1, true);
        assert!(0x2::balance::value<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(&arg0.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>>(0x2::coin::from_balance<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(0x2::balance::split<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(&mut arg0.balance, arg2), arg5), v1);
        let v6 = WeweClaimed{
            receiver : v1,
            id       : arg1,
            amount   : arg2,
        };
        0x2::event::emit<WeweClaimed>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x0;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            start_time  : 0,
            end_time    : 0,
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
            balance     : 0x2::balance::zero<0x869c83de0c9dc07fb8c16b8efe53018da016173c6b9847efa2168b27b1d32318::cleo::CLEO>(),
            version     : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    entry fun update_operator(arg0: &OwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    entry fun update_time(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: u64) {
        arg1.start_time = arg2;
        arg1.end_time = arg3;
    }

    // decompiled from Move bytecode v6
}

