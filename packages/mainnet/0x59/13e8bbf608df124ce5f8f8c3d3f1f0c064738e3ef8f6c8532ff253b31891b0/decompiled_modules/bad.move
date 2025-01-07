module 0x5913e8bbf608df124ce5f8f8c3d3f1f0c064738e3ef8f6c8532ff253b31891b0::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 9, b"BAD", b"Low", b"Not", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4223dad2-104e-4a0c-9bed-7268471b4424.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

