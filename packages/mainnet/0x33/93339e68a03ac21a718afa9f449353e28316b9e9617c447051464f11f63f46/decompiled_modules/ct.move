module 0x3393339e68a03ac21a718afa9f449353e28316b9e9617c447051464f11f63f46::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 9, b"CT", b"CCATS", x"4d7920646561722049e280996d2061206361742065766572797468696e67204920736565206973206d696e652c20636f6d6d756e697479206d656d6520636f696e73206c6574207269646520f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9bb8f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9886301e-5b79-40da-b795-6714fd6c2234.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT>>(v1);
    }

    // decompiled from Move bytecode v6
}

