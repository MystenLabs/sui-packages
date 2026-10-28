module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::sale_kiosk {
    struct KioskOrder<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        rev: u64,
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        maker: address,
        ask: u64,
        bps: u16,
        cap: 0x1::option::Option<0x2::kiosk::PurchaseCap<T0>>,
    }

    public fun kiosk<T0: store + key>(arg0: &KioskOrder<T0>) : 0x2::object::ID {
        arg0.kiosk
    }

    fun announce<T0: store + key>(arg0: &KioskOrder<T0>, arg1: bool) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::ask_posted(0x2::object::id<KioskOrder<T0>>(arg0), arg0.maker, arg0.item, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x2::object::ID>(arg0.kiosk), arg0.ask, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0.ask, arg0.bps), arg1);
    }

    public fun ask<T0: store + key>(arg0: &KioskOrder<T0>) : u64 {
        arg0.ask
    }

    public fun buy<T0: store + key>(arg0: KioskOrder<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let (v0, v1) = sell<T0>(arg0, arg1, arg2, arg6, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg3)), 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::clearing::royalty_due<T0>(arg5, net_of(arg0.ask, arg0.bps)), arg7);
        let v2 = v1;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::clearing::settle_into<T0>(arg5, &mut v2, v0, arg3, arg4, arg6, arg7);
        v2
    }

    public fun cut<T0: store + key>(arg0: &KioskOrder<T0>) : u64 {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0.ask, arg0.bps)
    }

    public fun item<T0: store + key>(arg0: &KioskOrder<T0>) : 0x2::object::ID {
        arg0.item
    }

    public fun maker<T0: store + key>(arg0: &KioskOrder<T0>) : address {
        arg0.maker
    }

    fun net_of(arg0: u64, arg1: u16) : u64 {
        arg0 - 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0, arg1)
    }

    fun owns<T0: store + key>(arg0: &KioskOrder<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap) {
        assert!(arg0.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 11);
        assert!(0x2::kiosk::has_access(arg1, arg2), 12);
    }

    public fun post<T0: store + key>(arg0: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg0);
        assert!(arg4 != 0, 40);
        let v0 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::listing_bps(arg0);
        let v1 = KioskOrder<T0>{
            id    : 0x2::object::new(arg5),
            rev   : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::rev(),
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item  : arg3,
            maker : 0x2::tx_context::sender(arg5),
            ask   : arg4,
            bps   : v0,
            cap   : 0x1::option::some<0x2::kiosk::PurchaseCap<T0>>(0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, net_of(arg4, v0), arg5)),
        };
        announce<T0>(&v1, false);
        0x2::transfer::share_object<KioskOrder<T0>>(v1);
        0x2::object::id<KioskOrder<T0>>(&v1)
    }

    public fun pull<T0: store + key>(arg0: KioskOrder<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap) {
        owns<T0>(&arg0, arg1, arg2);
        let KioskOrder {
            id    : v0,
            rev   : _,
            kiosk : v2,
            item  : v3,
            maker : v4,
            ask   : v5,
            bps   : _,
            cap   : v7,
        } = arg0;
        let v8 = v7;
        0x2::object::delete(v0);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x1::option::extract<0x2::kiosk::PurchaseCap<T0>>(&mut v8));
        0x1::option::destroy_none<0x2::kiosk::PurchaseCap<T0>>(v8);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::ask_withdrawn(0x2::object::id<KioskOrder<T0>>(&arg0), v4, v3, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x2::object::ID>(v2), v5);
    }

    public fun reprice<T0: store + key>(arg0: &mut KioskOrder<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        owns<T0>(arg0, arg2, arg3);
        assert!(arg4 != 0, 40);
        0x2::kiosk::return_purchase_cap<T0>(arg2, 0x1::option::extract<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.cap));
        let v0 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::listing_bps(arg1);
        0x1::option::fill<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.cap, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg0.item, net_of(arg4, v0), arg5));
        arg0.ask = arg4;
        arg0.bps = v0;
        arg0.maker = 0x2::tx_context::sender(arg5);
        announce<T0>(arg0, true);
    }

    fun sell<T0: store + key>(arg0: KioskOrder<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg0.kiosk, 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg0.ask, 30);
        let KioskOrder {
            id    : v0,
            rev   : _,
            kiosk : v2,
            item  : v3,
            maker : v4,
            ask   : v5,
            bps   : v6,
            cap   : v7,
        } = arg0;
        let v8 = v7;
        0x2::object::delete(v0);
        let v9 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(v5, v6);
        let v10 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), v5);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(0x2::balance::split<0x2::sui::SUI>(&mut v10, v9), 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::treasury(arg1), arg6);
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x1::option::extract<0x2::kiosk::PurchaseCap<T0>>(&mut v8), 0x2::coin::from_balance<0x2::sui::SUI>(v10, arg6));
        0x1::option::destroy_none<0x2::kiosk::PurchaseCap<T0>>(v8);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::ask_filled(0x2::object::id<KioskOrder<T0>>(&arg0), v4, 0x2::tx_context::sender(arg6), v3, 0x1::type_name::with_defining_ids<T0>(), 0x1::option::some<0x2::object::ID>(v2), arg4, v5, v9, arg5);
        (v11, v12)
    }

    public fun take<T0: store + key>(arg0: KioskOrder<T0>, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        sell<T0>(arg0, arg1, arg2, arg3, 0x1::option::none<0x2::object::ID>(), 0, arg4)
    }

    // decompiled from Move bytecode v7
}

