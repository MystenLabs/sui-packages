module 0xcfbda885304699a0bd9c9e6366952830abd034163e73ad97c19ce55ca8f0790b::voucher {
    struct VOUCHER has drop {
        dummy_field: bool,
    }

    struct UnihouseVoucher<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        value: u64,
        expiration_ms: u64,
        usage_state: u8,
    }

    struct VoucherBank<phantom T0> has store, key {
        id: 0x2::object::UID,
        voucher_pool: 0x2::balance::Balance<T0>,
    }

    struct VoucherConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VoucherConfig has store, key {
        id: 0x2::object::UID,
        rules: vector<u64>,
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

    public fun value<T0, T1>(arg0: &UnihouseVoucher<T0, T1>) : u64 {
        arg0.value
    }

    fun assert_enough_value<T0, T1>(arg0: &UnihouseVoucher<T0, T1>, arg1: u64) {
        assert!(value<T0, T1>(arg0) >= arg1, 1);
    }

    fun assert_not_expired<T0, T1>(arg0: &UnihouseVoucher<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= expiration_ms<T0, T1>(arg0), 0);
    }

    fun assert_valid_voucher_value<T0, T1>(arg0: &VoucherBank<T0>, arg1: &UnihouseVoucher<T0, T1>) {
        let v0 = voucher_max_value<T0>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        assert!(value<T0, T1>(arg1) <= 0x1::option::destroy_some<u64>(v0), 3);
    }

    public fun bank_balance<T0>(arg0: &VoucherBank<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.voucher_pool)
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

    public fun buy_voucher<T0, T1>(arg0: &mut VoucherBank<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : UnihouseVoucher<T0, T1> {
        voucher_deposit<T0>(arg0, arg1);
        mint<T0, T1>(0x2::coin::value<T0>(&arg1), 0x2::clock::timestamp_ms(arg2) + 7776000000, arg3)
    }

    fun deduct<T0, T1>(arg0: &mut UnihouseVoucher<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) {
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

    fun mint<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UnihouseVoucher<T0, T1> {
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

    public fun new_voucher_bank<T0>(arg0: &VoucherCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherBank<T0>{
            id           : 0x2::object::new(arg1),
            voucher_pool : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<VoucherBank<T0>>(v0);
    }

    public fun redeem_voucher<T0, T1>(arg0: &mut VoucherBank<T0>, arg1: &mut UnihouseVoucher<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_voucher_value<T0, T1>(arg0, arg1);
        deduct<T0, T1>(arg1, arg2, arg3);
        0x2::coin::from_balance<T0>(split_for_voucher<T0>(arg0, arg3), arg4)
    }

    public fun set_voucher_config<T0>(arg0: &VoucherCap, arg1: &mut VoucherBank<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherConfigKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VoucherConfigKey<T0>, VoucherConfig>(&arg1.id, v0)) {
            0x2::dynamic_object_field::borrow_mut<VoucherConfigKey<T0>, VoucherConfig>(&mut arg1.id, v0).rules = arg2;
        } else {
            let v1 = VoucherConfig{
                id    : 0x2::object::new(arg3),
                rules : arg2,
            };
            0x2::dynamic_object_field::add<VoucherConfigKey<T0>, VoucherConfig>(&mut arg1.id, v0, v1);
        };
    }

    fun split_for_voucher<T0>(arg0: &mut VoucherBank<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.voucher_pool, arg1)
    }

    fun voucher_deposit<T0>(arg0: &mut VoucherBank<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.voucher_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun voucher_max_value<T0>(arg0: &VoucherBank<T0>) : 0x1::option::Option<u64> {
        let v0 = VoucherConfigKey<T0>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_with_type<VoucherConfigKey<T0>, VoucherConfig>(&arg0.id, v0)) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&0x2::dynamic_object_field::borrow<VoucherConfigKey<T0>, VoucherConfig>(&arg0.id, v0).rules, 0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun withdraw_voucher_bank<T0>(arg0: &VoucherCap, arg1: &mut VoucherBank<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(bank_balance<T0>(arg1) >= arg2, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.voucher_pool, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

