module 0xa56c821885bb551e6bd4537cb0c3e595508878db64e36e2b39addb67717cbf10::za_zu {
    struct ZA_ZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZA_ZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZA_ZU>(arg0, 9, b"ZA_ZU", b"ZAZU", x"5374726f6e6720f09f92aa207761766520f09f8c8a20696e20616e206f6365616e20f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9787e31-a79b-4754-a7d4-4c05bc2b71b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZA_ZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZA_ZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

