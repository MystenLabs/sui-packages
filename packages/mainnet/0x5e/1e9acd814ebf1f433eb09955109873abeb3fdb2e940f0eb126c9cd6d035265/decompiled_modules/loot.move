module 0x5e1e9acd814ebf1f433eb09955109873abeb3fdb2e940f0eb126c9cd6d035265::loot {
    struct LOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOT>(arg0, 9, b"LOOT", b"Loot", b"Be rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e8aa72a-adef-411d-892f-a79836738058.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

