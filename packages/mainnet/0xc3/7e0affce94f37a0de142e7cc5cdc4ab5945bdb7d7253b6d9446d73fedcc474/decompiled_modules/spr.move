module 0xc37e0affce94f37a0de142e7cc5cdc4ab5945bdb7d7253b6d9446d73fedcc474::spr {
    struct SPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPR>(arg0, 9, b"SPR", b"Spring", b"SPRING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3bb54e87-b327-4e97-b31a-e29ad89730fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

