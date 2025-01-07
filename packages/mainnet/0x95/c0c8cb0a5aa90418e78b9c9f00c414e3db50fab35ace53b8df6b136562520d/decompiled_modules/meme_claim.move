module 0x95c0c8cb0a5aa90418e78b9c9f00c414e3db50fab35ace53b8df6b136562520d::meme_claim {
    struct App has key {
        id: 0x2::object::UID,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct TokenClaimed has copy, drop, store {
        receiver: address,
        coin_type: 0x1::string::String,
        id: u64,
        amount: u64,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    entry fun admin_deposit<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: 0x2::coin::Coin<T0>) {
        let v0 = type_to_bytes<T0>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), 0x2::coin::into_balance<T0>(arg2));
    }

    entry fun admin_withdraw<T0>(arg0: &OwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = type_to_bytes<T0>();
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0)) {
            abort 4
        };
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun claim<T0>(arg0: &mut App, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = type_to_bytes<T0>();
        let v2 = 0x1::string::utf8(b"MEME_CLAIM:");
        let v3 = 0x2::bcs::to_bytes<0x1::string::String>(&v2);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v0));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg1));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v3, v1);
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v3) == true, 1);
        let v7 = 0x1::string::utf8(b"MEME_CLAIM:");
        let v8 = 0x2::bcs::to_bytes<0x1::string::String>(&v7);
        0x1::vector::append<u8>(&mut v8, 0x2::bcs::to_bytes<u64>(&arg1));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v8), 5);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v8, true);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            abort 4
        };
        let v9 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T0>(v9) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, arg2), arg4), v0);
        let v10 = TokenClaimed{
            receiver  : v0,
            coin_type : 0x1::string::utf8(v1),
            id        : arg1,
            amount    : arg2,
        };
        0x2::event::emit<TokenClaimed>(v10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id          : 0x2::object::new(arg0),
            operator_pk : 0x2::bcs::to_bytes<address>(&v0),
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

    fun type_to_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    entry fun update_operator(arg0: &OwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    // decompiled from Move bytecode v6
}

