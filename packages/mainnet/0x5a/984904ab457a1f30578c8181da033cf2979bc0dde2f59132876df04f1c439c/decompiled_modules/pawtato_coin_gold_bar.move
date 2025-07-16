module 0x5a984904ab457a1f30578c8181da033cf2979bc0dde2f59132876df04f1c439c::pawtato_coin_gold_bar {
    struct PAWTATO_COIN_GOLD_BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_GOLD_BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_GOLD_BAR>(arg0, 9, b"GOLD_BAR", b"Pawtato Gold Bar", b"Refined gold bars processed from raw gold ore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/gold-bar.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_GOLD_BAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_GOLD_BAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_gold_bar(arg0: 0x2::coin::Coin<PAWTATO_COIN_GOLD_BAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_GOLD_BAR>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

