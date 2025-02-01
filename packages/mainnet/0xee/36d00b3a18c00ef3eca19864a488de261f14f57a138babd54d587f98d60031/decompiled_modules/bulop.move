module 0xee36d00b3a18c00ef3eca19864a488de261f14f57a138babd54d587f98d60031::bulop {
    struct BULOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULOP>(arg0, 9, b"BULOP", b"uiop", b"the new meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8383f03-a701-4a65-8b02-e1a54336e446.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

