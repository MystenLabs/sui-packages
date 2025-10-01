module 0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        fee_recipient: address,
        native_fee_bp: u64,
        zro_fee: u64,
        zro_enabled: bool,
        fee_enabled: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeRecipientSetEvent has copy, drop {
        fee_recipient: address,
    }

    struct NativeFeeBpSetEvent has copy, drop {
        native_fee_bp: u64,
    }

    struct ZroFeeSetEvent has copy, drop {
        zro_fee: u64,
    }

    struct ZroEnabledSetEvent has copy, drop {
        zro_enabled: bool,
    }

    struct FeeEnabledSetEvent has copy, drop {
        fee_enabled: bool,
    }

    public fun fee_enabled(arg0: &Treasury) : bool {
        arg0.fee_enabled
    }

    public fun fee_recipient(arg0: &Treasury) : address {
        arg0.fee_recipient
    }

    public fun get_fee(arg0: &Treasury, arg1: u64, arg2: bool) : (u64, u64) {
        if (arg0.fee_enabled) {
            if (arg2) {
                assert!(arg0.zro_enabled, 3);
                (0, arg0.zro_fee)
            } else {
                (arg1 * arg0.native_fee_bp / 10000, 0)
            }
        } else {
            (0, 0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id            : 0x2::object::new(arg0),
            fee_recipient : @0x0,
            native_fee_bp : 0,
            zro_fee       : 0,
            zro_enabled   : false,
            fee_enabled   : false,
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun native_fee_bp(arg0: &Treasury) : u64 {
        arg0.native_fee_bp
    }

    public fun set_fee_enabled(arg0: &mut Treasury, arg1: &AdminCap, arg2: bool) {
        if (arg2) {
            assert!(arg0.fee_recipient != @0x0, 1);
        };
        arg0.fee_enabled = arg2;
        let v0 = FeeEnabledSetEvent{fee_enabled: arg2};
        0x2::event::emit<FeeEnabledSetEvent>(v0);
    }

    public fun set_fee_recipient(arg0: &mut Treasury, arg1: &AdminCap, arg2: address) {
        assert!(arg2 != @0x0, 1);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientSetEvent{fee_recipient: arg2};
        0x2::event::emit<FeeRecipientSetEvent>(v0);
    }

    public fun set_native_fee_bp(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 2);
        arg0.native_fee_bp = arg2;
        let v0 = NativeFeeBpSetEvent{native_fee_bp: arg2};
        0x2::event::emit<NativeFeeBpSetEvent>(v0);
    }

    public fun set_zro_enabled(arg0: &mut Treasury, arg1: &AdminCap, arg2: bool) {
        assert!(arg0.fee_recipient != @0x0, 1);
        arg0.zro_enabled = arg2;
        let v0 = ZroEnabledSetEvent{zro_enabled: arg2};
        0x2::event::emit<ZroEnabledSetEvent>(v0);
    }

    public fun set_zro_fee(arg0: &mut Treasury, arg1: &AdminCap, arg2: u64) {
        arg0.zro_fee = arg2;
        let v0 = ZroFeeSetEvent{zro_fee: arg2};
        0x2::event::emit<ZroFeeSetEvent>(v0);
    }

    public fun zro_enabled(arg0: &Treasury) : bool {
        arg0.zro_enabled
    }

    public fun zro_fee(arg0: &Treasury) : u64 {
        arg0.zro_fee
    }

    // decompiled from Move bytecode v6
}

