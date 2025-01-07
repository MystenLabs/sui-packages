module 0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::payment {
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
    }

    struct PoolBalance<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    struct UserArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce: 0x2::table::Table<0x1::type_name::TypeName, u128>,
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
        };
        0x2::transfer::share_object<PaymentPool>(v3);
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::utils::createVault<PaymentAdminCap>(arg1);
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::utils::createVault<PaymentTreasureCap>(arg1);
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::utils::createVault<0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVerAdminCap>(arg1);
    }

    public fun pay<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut PaymentPool, arg3: 0x2::coin::Coin<T0>, arg4: &mut UserArchieve, arg5: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg6: &mut 0x2::tx_context::TxContext) {
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::checkVersion(arg5, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 1);
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::utils::verifySignature(&arg0, &arg1, 0x1::option::borrow<vector<u8>>(&arg2.validator));
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        let v4 = userNonceMut<T0>(arg4);
        assert!(v3 > *v4, 3);
        assert!(v1 == 0x2::tx_context::sender(arg6), 5);
        assert!(0x2::coin::value<T0>(&arg3) >= v2 && v2 > 0, 6);
        *v4 = v3;
        0x2::balance::join<T0>(&mut poolBalanceMut<T0>(arg2).balance, 0x2::coin::into_balance<T0>(arg3));
        let v5 = PaymentExecuted{
            owner     : v1,
            amount    : v2,
            req_id    : 0x2::bcs::peel_u128(&mut v0),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PaymentExecuted>(v5);
    }

    fun poolBalanceMut<T0>(arg0: &mut PaymentPool) : &mut PoolBalance<T0> {
        let v0 = 0x1::type_name::get<PoolBalance<T0>>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            let v1 = PoolBalance<T0>{balance: 0x2::balance::zero<T0>()};
            0x2::dynamic_field::add<0x1::type_name::TypeName, PoolBalance<T0>>(&mut arg0.id, v0, v1);
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, PoolBalance<T0>>(&mut arg0.id, v0)
    }

    public fun register(arg0: &mut UserReg, arg1: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg2: &mut 0x2::tx_context::TxContext) : UserArchieve {
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::checkVersion(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.regs, v0), 7);
        0x2::table::add<address, bool>(&mut arg0.regs, v0, true);
        UserArchieve{
            id    : 0x2::object::new(arg2),
            owner : v0,
            nonce : 0x2::table::new<0x1::type_name::TypeName, u128>(arg2),
        }
    }

    public fun update_validator(arg0: &PaymentAdminCap, arg1: vector<u8>, arg2: &mut PaymentPool, arg3: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion) {
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::checkVersion(arg3, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    fun userNonceMut<T0>(arg0: &mut UserArchieve) : &mut u128 {
        let v0 = 0x1::type_name::get<PoolBalance<T0>>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u128>(&arg0.nonce, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u128>(&mut arg0.nonce, v0, 0);
        };
        0x2::table::borrow_mut<0x1::type_name::TypeName, u128>(&mut arg0.nonce, v0)
    }

    public fun withdrawFund<T0>(arg0: &PaymentTreasureCap, arg1: &mut PaymentPool, arg2: &0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::PaymentVersion, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8e371cb19ee0222a4789e515656e81bbf568a61917346b6a99062754d762468b::version::checkVersion(arg2, 1);
        let v0 = poolBalanceMut<T0>(arg1);
        let v1 = PaymentWithdrawn{
            owner     : 0x2::tx_context::sender(arg3),
            amount    : 0x2::balance::value<T0>(&v0.balance),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PaymentWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, 0x2::balance::value<T0>(&v0.balance)), arg3)
    }

    // decompiled from Move bytecode v6
}

