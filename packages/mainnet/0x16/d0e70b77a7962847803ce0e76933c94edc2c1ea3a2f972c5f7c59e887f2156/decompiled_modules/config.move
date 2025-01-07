module 0x16d0e70b77a7962847803ce0e76933c94edc2c1ea3a2f972c5f7c59e887f2156::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        enable: bool,
        fee_rate: u64,
        balances: 0x2::bag::Bag,
    }

    struct ReceiveFeeEvent has copy, drop {
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct UpdateFeeStatus has copy, drop {
        old_status: bool,
        new_status: bool,
    }

    struct ClaimFeeEvent has copy, drop {
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    public fun claim_fee<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0), 101);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), 0x2::tx_context::sender(arg2));
        let v2 = ClaimFeeEvent{
            amount    : 0x2::balance::value<T0>(&v1),
            type_name : v0,
        };
        0x2::event::emit<ClaimFeeEvent>(v2);
    }

    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id       : 0x2::object::new(arg1),
            enable   : true,
            fee_rate : 10000,
            balances : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((full_mul(arg0, arg1) / (arg2 as u128)) as u64)
    }

    public fun pay_fee<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        if (!arg0.enable) {
            return (arg1, 0)
        };
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        let v2 = mul_div_floor(0x2::balance::value<T0>(&v1), arg0.fee_rate, 10000000);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::balance::split<T0>(&mut v1, v2));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::split<T0>(&mut v1, v2));
        };
        let v3 = ReceiveFeeEvent{
            amount    : v2,
            type_name : v0,
        };
        0x2::event::emit<ReceiveFeeEvent>(v3);
        (0x2::coin::from_balance<T0>(v1, arg2), v2)
    }

    public fun update_fee_rate(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 < 1000, 100);
        arg1.fee_rate = arg2;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg1.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun update_fee_status(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.enable = arg2;
        let v0 = UpdateFeeStatus{
            old_status : arg1.enable,
            new_status : arg2,
        };
        0x2::event::emit<UpdateFeeStatus>(v0);
    }

    // decompiled from Move bytecode v6
}

