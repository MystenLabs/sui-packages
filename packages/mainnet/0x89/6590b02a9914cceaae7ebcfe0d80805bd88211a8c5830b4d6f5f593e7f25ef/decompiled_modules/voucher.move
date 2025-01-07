module 0x896590b02a9914cceaae7ebcfe0d80805bd88211a8c5830b4d6f5f593e7f25ef::voucher {
    struct VOUCHER has drop {
        dummy_field: bool,
    }

    struct UnihouseVoucher<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        value: u64,
        expiration_ms: u64,
        usage_state: u8,
    }

    struct VoucherCap has store, key {
        id: 0x2::object::UID,
    }

    struct RedeemedVoucher<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        value: u64,
        value_spent: u64,
        expiration_ms: u64,
    }

    struct MintedVoucher<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        value: u64,
        expiration_ms: u64,
    }

    fun assert_enough_value<T0, T1>(arg0: &UnihouseVoucher<T0, T1>, arg1: u64) {
        assert!(value<T0, T1>(arg0) >= arg1, 1);
    }

    fun assert_not_expired<T0, T1>(arg0: &UnihouseVoucher<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= expiration_ms<T0, T1>(arg0), 0);
    }

    public fun burn<T0, T1>(arg0: UnihouseVoucher<T0, T1>) {
        let UnihouseVoucher {
            id            : v0,
            value         : _,
            expiration_ms : _,
            usage_state   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun deduct<T0, T1>(arg0: &mut UnihouseVoucher<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) {
        assert_not_expired<T0, T1>(arg0, arg1);
        assert_enough_value<T0, T1>(arg0, arg2);
        arg0.value = arg0.value - arg2;
        let v0 = RedeemedVoucher<T0>{
            id            : 0x2::object::id<UnihouseVoucher<T0, T1>>(arg0),
            value         : value<T0, T1>(arg0),
            value_spent   : arg2,
            expiration_ms : expiration_ms<T0, T1>(arg0),
        };
        0x2::event::emit<RedeemedVoucher<T0>>(v0);
        if (arg0.usage_state == 0) {
            arg0.usage_state = 1;
        };
    }

    public fun expiration_ms<T0, T1>(arg0: &UnihouseVoucher<T0, T1>) : u64 {
        arg0.expiration_ms
    }

    fun init(arg0: VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VOUCHER>(arg0, arg1);
        let v0 = VoucherCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VoucherCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_used<T0, T1>(arg0: &UnihouseVoucher<T0, T1>) : bool {
        arg0.usage_state == 1
    }

    public(friend) fun mint<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UnihouseVoucher<T0, T1> {
        let v0 = UnihouseVoucher<T0, T1>{
            id            : 0x2::object::new(arg2),
            value         : arg0,
            expiration_ms : arg1,
            usage_state   : 0,
        };
        let v1 = MintedVoucher<T0>{
            id            : 0x2::object::id<UnihouseVoucher<T0, T1>>(&v0),
            value         : value<T0, T1>(&v0),
            expiration_ms : expiration_ms<T0, T1>(&v0),
        };
        0x2::event::emit<MintedVoucher<T0>>(v1);
        v0
    }

    public fun value<T0, T1>(arg0: &UnihouseVoucher<T0, T1>) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

