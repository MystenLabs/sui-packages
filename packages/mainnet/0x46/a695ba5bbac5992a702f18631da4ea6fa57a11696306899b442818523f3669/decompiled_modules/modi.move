module 0x46a695ba5bbac5992a702f18631da4ea6fa57a11696306899b442818523f3669::modi {
    struct MODI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MODI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODI>(arg0, 9, b"MODI", b"Modi Token", b"I am Modi all fand Modi ka B J P ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a6c5a03-b0ee-438a-b970-4bf5f8907ab2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MODI>>(v1);
    }

    // decompiled from Move bytecode v6
}

