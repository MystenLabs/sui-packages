module 0xf1d916bc37c7ab3da8ee793d20c0bb07d42d07e5bd0a984931d5865282bd0bce::wave_payment {
    struct App has key {
        id: 0x2::object::UID,
        balance_ocean: 0x2::balance::Balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        ocean_deposit_enable: bool,
        sui_deposit_enable: bool,
        operator_pk: vector<u8>,
        version: u8,
    }

    struct PaymentOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Deposit has copy, drop {
        sender: address,
        coin_type: u8,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        id: u64,
        sender: address,
        coin_type: u8,
        amount: u64,
    }

    entry fun deposit_ocean(arg0: &mut App, arg1: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1);
        assert!(arg0.ocean_deposit_enable, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg1);
        assert!(v1 > 0, 2);
        validate_signature(arg0, v0, 1, v1, arg2, arg3, arg4);
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance_ocean, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg1));
        let v2 = Deposit{
            sender    : v0,
            coin_type : 1,
            amount    : v1,
        };
        0x2::event::emit<Deposit>(v2);
    }

    entry fun deposit_sui(arg0: &mut App, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1);
        assert!(arg0.sui_deposit_enable, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 2);
        validate_signature(arg0, v0, 0, v1, arg2, arg3, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = Deposit{
            sender    : v0,
            coin_type : 0,
            amount    : v1,
        };
        0x2::event::emit<Deposit>(v2);
    }

    entry fun enable_deposit(arg0: &PaymentOwnerCap, arg1: &mut App, arg2: bool, arg3: bool) {
        arg1.ocean_deposit_enable = arg2;
        arg1.sui_deposit_enable = arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = App{
            id                   : 0x2::object::new(arg0),
            balance_ocean        : 0x2::balance::zero<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(),
            balance_sui          : 0x2::balance::zero<0x2::sui::SUI>(),
            ocean_deposit_enable : true,
            sui_deposit_enable   : false,
            operator_pk          : 0x2::bcs::to_bytes<address>(&v0),
            version              : 1,
        };
        0x2::transfer::share_object<App>(v1);
        let v2 = PaymentOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PaymentOwnerCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun inner_withdraw(arg0: &mut App, arg1: u8, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 1) {
            assert!(0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg0.balance_ocean) >= arg2, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance_ocean, arg2), arg4), arg3);
        } else {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance_sui) >= arg2, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_sui, arg2), arg4), arg3);
        };
    }

    entry fun migrate(arg0: &PaymentOwnerCap, arg1: &mut App) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    entry fun system_withdraw(arg0: &PaymentOwnerCap, arg1: &mut App, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        inner_withdraw(arg1, arg2, arg3, v0, arg4);
    }

    entry fun update_operator(arg0: &PaymentOwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    fun validate_signature(arg0: &App, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"PAYMENT_DEPOSIT:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u8>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.operator_pk, &v1) == true, 3);
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 9);
    }

    entry fun withdraw(arg0: &mut App, arg1: u8, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 1);
        assert!(arg1 == 1 || arg1 == 0, 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::string::utf8(b"PAYMENT_WITHDRAW:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u8>(&arg1));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg2));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v2) == true, 3);
        let v6 = 0x1::string::utf8(b"PW");
        let v7 = 0x2::bcs::to_bytes<0x1::string::String>(&v6);
        let v8 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<0x1::string::String>(&v8));
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<u64>(&arg2));
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v7), 4);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, v7, true);
        inner_withdraw(arg0, arg1, arg3, v0, arg5);
        let v9 = Withdraw{
            id        : arg2,
            sender    : v0,
            coin_type : arg1,
            amount    : arg3,
        };
        0x2::event::emit<Withdraw>(v9);
    }

    // decompiled from Move bytecode v6
}

