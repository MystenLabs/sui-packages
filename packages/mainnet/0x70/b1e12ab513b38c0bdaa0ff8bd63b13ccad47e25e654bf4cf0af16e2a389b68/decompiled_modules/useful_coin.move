module 0x70b1e12ab513b38c0bdaa0ff8bd63b13ccad47e25e654bf4cf0af16e2a389b68::useful_coin {
    struct USEFUL_COIN has drop {
        dummy_field: bool,
    }

    struct CapManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        manager: address,
    }

    public fun admin_burn(arg0: &mut CapManager<USEFUL_COIN>, arg1: 0x2::coin::Coin<USEFUL_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0);
        0x2::coin::burn<USEFUL_COIN>(&mut arg0.treasury_cap, arg1);
    }

    public fun admin_mint_to(arg0: &mut CapManager<USEFUL_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0);
        0x2::coin::mint_and_transfer<USEFUL_COIN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    fun init(arg0: USEFUL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USEFUL_COIN>(arg0, 0, b"Useful", b"Useful Coin", b"Super useful coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USEFUL_COIN>>(v1);
        0x2::coin::mint_and_transfer<USEFUL_COIN>(&mut v2, 100, 0x2::tx_context::sender(arg1), arg1);
        let v3 = CapManager<USEFUL_COIN>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
            manager      : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_share_object<CapManager<USEFUL_COIN>>(v3);
    }

    public fun update_manager(arg0: &mut CapManager<USEFUL_COIN>, arg1: address) {
        arg0.manager = arg1;
    }

    // decompiled from Move bytecode v6
}

