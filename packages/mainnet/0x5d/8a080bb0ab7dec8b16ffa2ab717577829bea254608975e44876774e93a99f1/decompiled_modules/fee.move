module 0x5d8a080bb0ab7dec8b16ffa2ab717577829bea254608975e44876774e93a99f1::fee {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_take_fee: bool,
        fee_rate: u32,
        fee_recipient: address,
    }

    struct SetIsTakeFeeEvent has copy, drop {
        old_is_take_fee: bool,
        new_is_take_fee: bool,
    }

    struct SetFeeRateEvent has copy, drop {
        old_fee_rate: u32,
        new_fee_rate: u32,
    }

    struct SetFeeRecipientEvent has copy, drop {
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct SetFeeConfigEvent has copy, drop {
        is_take_fee: bool,
        fee_rate: u32,
        fee_recipient: address,
    }

    fun assert_reachable(arg0: bool, arg1: address) {
        if (arg0) {
            assert!(arg1 != @0x0, 0x5d8a080bb0ab7dec8b16ffa2ab717577829bea254608975e44876774e93a99f1::errors::invalid_fee_recipient());
        };
    }

    public fun assert_valid_version(arg0: &FeeConfig) {
        assert!(arg0.version == 1, 0x5d8a080bb0ab7dec8b16ffa2ab717577829bea254608975e44876774e93a99f1::errors::invalid_version());
    }

    public fun fee_rate(arg0: &FeeConfig) : u32 {
        arg0.fee_rate
    }

    public fun fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeConfig{
            id            : 0x2::object::new(arg0),
            version       : 1,
            is_take_fee   : false,
            fee_rate      : 0,
            fee_recipient : @0x0,
        };
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    public fun is_take_fee(arg0: &FeeConfig) : bool {
        arg0.is_take_fee
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut FeeConfig) {
        assert!(arg1.version < 1, 0x5d8a080bb0ab7dec8b16ffa2ab717577829bea254608975e44876774e93a99f1::errors::invalid_version());
        arg1.version = 1;
    }

    public fun set_fee_config(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: bool, arg3: u32, arg4: address) {
        assert!(arg3 <= 20000, 0x5d8a080bb0ab7dec8b16ffa2ab717577829bea254608975e44876774e93a99f1::errors::too_large_fee_rate());
        assert_reachable(arg2, arg4);
        arg1.is_take_fee = arg2;
        arg1.fee_rate = arg3;
        arg1.fee_recipient = arg4;
        let v0 = SetFeeConfigEvent{
            is_take_fee   : arg2,
            fee_rate      : arg3,
            fee_recipient : arg4,
        };
        0x2::event::emit<SetFeeConfigEvent>(v0);
    }

    public fun set_fee_rate(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u32) {
        assert!(arg2 <= 20000, 0x5d8a080bb0ab7dec8b16ffa2ab717577829bea254608975e44876774e93a99f1::errors::too_large_fee_rate());
        arg1.fee_rate = arg2;
        let v0 = SetFeeRateEvent{
            old_fee_rate : arg1.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<SetFeeRateEvent>(v0);
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        assert_reachable(arg1.is_take_fee, arg2);
        arg1.fee_recipient = arg2;
        let v0 = SetFeeRecipientEvent{
            old_fee_recipient : arg1.fee_recipient,
            new_fee_recipient : arg2,
        };
        0x2::event::emit<SetFeeRecipientEvent>(v0);
    }

    public fun set_is_take_fee(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: bool) {
        assert_reachable(arg2, arg1.fee_recipient);
        arg1.is_take_fee = arg2;
        let v0 = SetIsTakeFeeEvent{
            old_is_take_fee : arg1.is_take_fee,
            new_is_take_fee : arg2,
        };
        0x2::event::emit<SetIsTakeFeeEvent>(v0);
    }

    public fun version(arg0: &FeeConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

