module 0x8cafd6895a3c3e877624bf37c81c5b449d34a756e57db38722b22cfab6bab588::cpen {
    struct CPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPEN>(arg0, 9, b"CPEN", b"CUT PENIS", b"CUTTING PENIZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f1ab9fd-961a-44e3-bdc6-28d5ecc75824.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

