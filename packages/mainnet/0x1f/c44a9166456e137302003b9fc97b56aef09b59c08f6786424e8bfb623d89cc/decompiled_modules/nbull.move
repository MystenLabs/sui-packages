module 0x1fc44a9166456e137302003b9fc97b56aef09b59c08f6786424e8bfb623d89cc::nbull {
    struct NBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBULL>(arg0, 9, b"NBULL", b"NOV BULL", b"\"This is just a meme in November.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7defc12c-643a-477d-bb42-2c19f82576ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

