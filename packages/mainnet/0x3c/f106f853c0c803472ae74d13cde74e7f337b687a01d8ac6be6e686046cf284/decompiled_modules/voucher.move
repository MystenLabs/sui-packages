module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::voucher {
    struct VOUCHER has drop {
        dummy_field: bool,
    }

    struct UniVoucher<phantom T0> has store, key {
        id: 0x2::object::UID,
        value: u64,
        expiration_ms: u64,
        usage_state: u8,
    }

    struct VoucherCap has store, key {
        id: 0x2::object::UID,
    }

    fun assert_enough_value<T0>(arg0: &UniVoucher<T0>, arg1: u64) {
        assert!(value<T0>(arg0) >= arg1, 1);
    }

    fun assert_not_expired<T0>(arg0: &UniVoucher<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= expiration_ms<T0>(arg0), 0);
    }

    public fun burn<T0>(arg0: UniVoucher<T0>) {
        let UniVoucher {
            id            : v0,
            value         : _,
            expiration_ms : _,
            usage_state   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun deduct<T0>(arg0: &mut UniVoucher<T0>, arg1: &0x2::clock::Clock, arg2: u64) {
        assert_not_expired<T0>(arg0, arg1);
        assert_enough_value<T0>(arg0, arg2);
        arg0.value = arg0.value - arg2;
        if (arg0.usage_state == 0) {
            arg0.usage_state = 1;
        };
    }

    public fun expiration_ms<T0>(arg0: &UniVoucher<T0>) : u64 {
        arg0.expiration_ms
    }

    fun init(arg0: VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VOUCHER>(arg0, arg1);
        let v0 = VoucherCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VoucherCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_used<T0>(arg0: &UniVoucher<T0>) : bool {
        arg0.usage_state == 1
    }

    public(friend) fun mint<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UniVoucher<T0> {
        UniVoucher<T0>{
            id            : 0x2::object::new(arg2),
            value         : arg0,
            expiration_ms : arg1,
            usage_state   : 0,
        }
    }

    public fun mint_by_cap<T0>(arg0: &VoucherCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : UniVoucher<T0> {
        mint<T0>(arg1, arg2, arg3)
    }

    public fun value<T0>(arg0: &UniVoucher<T0>) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

