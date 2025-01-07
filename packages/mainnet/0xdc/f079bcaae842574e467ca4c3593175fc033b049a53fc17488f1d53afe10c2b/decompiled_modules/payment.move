module 0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::payment {
    struct PAYMENT has drop {
        dummy_field: bool,
    }

    struct PaymentAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentTreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentExecuted has copy, drop {
        owner: address,
        amount: u64,
        req_id: u128,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PaymentWithdrawn has copy, drop {
        owner: address,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PaymentPool has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
        active: bool,
        fund: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct UserArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce: u128,
    }

    struct UserReg has store, key {
        id: 0x2::object::UID,
        regs: 0x2::table::Table<address, bool>,
    }

    fun init(arg0: PAYMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PaymentAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = PaymentTreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PaymentTreasureCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = UserReg{
            id   : 0x2::object::new(arg1),
            regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<UserReg>(v2);
        let v3 = PaymentPool{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
            active    : true,
            fund      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PaymentPool>(v3);
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::utils::createVault<PaymentAdminCap>(arg1);
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::utils::createVault<PaymentTreasureCap>(arg1);
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::utils::createVault<0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVerAdminCap>(arg1);
    }

    public fun pay(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut PaymentPool, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut UserArchieve, arg5: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 1);
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::utils::verifySignature(&arg0, &arg1, 0x1::option::borrow<vector<u8>>(&arg2.validator));
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        assert!(v3 > arg4.nonce, 3);
        assert!(v1 == 0x2::tx_context::sender(arg6), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v2 && v2 > 0, 6);
        arg4.nonce = v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.fund, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, v2, arg6)));
        let v4 = PaymentExecuted{
            owner     : v1,
            amount    : v2,
            req_id    : 0x2::bcs::peel_u128(&mut v0),
            coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
        };
        0x2::event::emit<PaymentExecuted>(v4);
    }

    public fun register(arg0: &mut UserReg, arg1: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) : UserArchieve {
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::checkVersion(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.regs, v0), 7);
        0x2::table::add<address, bool>(&mut arg0.regs, v0, true);
        UserArchieve{
            id    : 0x2::object::new(arg2),
            owner : v0,
            nonce : 0,
        }
    }

    public fun update_validator(arg0: &PaymentAdminCap, arg1: vector<u8>, arg2: &mut PaymentPool, arg3: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion) {
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::checkVersion(arg3, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public fun withdrawFund(arg0: &PaymentTreasureCap, arg1: &mut PaymentPool, arg2: &0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xdcf079bcaae842574e467ca4c3593175fc033b049a53fc17488f1d53afe10c2b::version::checkVersion(arg2, 1);
        let v0 = PaymentWithdrawn{
            owner     : 0x2::tx_context::sender(arg3),
            amount    : 0x2::balance::value<0x2::sui::SUI>(&arg1.fund),
            coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
        };
        0x2::event::emit<PaymentWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fund, 0x2::balance::value<0x2::sui::SUI>(&arg1.fund)), arg3)
    }

    // decompiled from Move bytecode v6
}

