module 0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd {
    struct YOSOUSD has drop {
        dummy_field: bool,
    }

    struct DenyCap has store, key {
        id: 0x2::object::UID,
        inner: 0x2::coin::DenyCapV2<YOSOUSD>,
    }

    struct YosoUSDCreated has copy, drop {
        treasury_cap_id: 0x2::object::ID,
        deny_cap_id: 0x2::object::ID,
        admin: address,
    }

    struct DenyListUpdated has copy, drop {
        account: address,
        denied: bool,
    }

    struct GlobalPauseUpdated has copy, drop {
        paused: bool,
    }

    struct DenyCapTransferred has copy, drop {
        deny_cap_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
    }

    fun create_currency(arg0: YOSOUSD, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<YOSOUSD>, 0x2::coin::DenyCapV2<YOSOUSD>, 0x2::coin::CoinMetadata<YOSOUSD>) {
        0x2::coin::create_regulated_currency_v2<YOSOUSD>(arg0, 6, b"yosoUSD", b"yosoUSD", b"USDC-pegged synthetic dollar for Yoso on Sui.", 0x1::option::none<0x2::url::Url>(), true, arg1)
    }

    public fun deny_cap_id(arg0: &DenyCap) : 0x2::object::ID {
        0x2::object::id<DenyCap>(arg0)
    }

    public fun disable_global_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<YOSOUSD>(arg0, &mut arg1.inner, arg2);
        let v0 = GlobalPauseUpdated{paused: false};
        0x2::event::emit<GlobalPauseUpdated>(v0);
    }

    public fun enable_global_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<YOSOUSD>(arg0, &mut arg1.inner, arg2);
        let v0 = GlobalPauseUpdated{paused: true};
        0x2::event::emit<GlobalPauseUpdated>(v0);
    }

    fun init(arg0: YOSOUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3) = create_currency(arg0, arg1);
        let v4 = v1;
        let v5 = DenyCap{
            id    : 0x2::object::new(arg1),
            inner : v2,
        };
        let v6 = YosoUSDCreated{
            treasury_cap_id : 0x2::object::id<0x2::coin::TreasuryCap<YOSOUSD>>(&v4),
            deny_cap_id     : 0x2::object::id<DenyCap>(&v5),
            admin           : v0,
        };
        0x2::event::emit<YosoUSDCreated>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOSOUSD>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOSOUSD>>(v4, v0);
        0x2::transfer::public_transfer<DenyCap>(v5, v0);
    }

    public fun set_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            0x2::coin::deny_list_v2_add<YOSOUSD>(arg0, &mut arg1.inner, arg2, arg4);
        } else {
            0x2::coin::deny_list_v2_remove<YOSOUSD>(arg0, &mut arg1.inner, arg2, arg4);
        };
        let v0 = DenyListUpdated{
            account : arg2,
            denied  : arg3,
        };
        0x2::event::emit<DenyListUpdated>(v0);
    }

    public fun transfer_deny_cap(arg0: DenyCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DenyCapTransferred{
            deny_cap_id    : 0x2::object::id<DenyCap>(&arg0),
            previous_owner : 0x2::tx_context::sender(arg2),
            new_owner      : arg1,
        };
        0x2::event::emit<DenyCapTransferred>(v0);
        0x2::transfer::public_transfer<DenyCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

