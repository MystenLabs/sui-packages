module 0x3ba86b9f761c365920d9effc8c2ae8e83fa2896e0cc6e2511219022acad924b5::lelet {
    struct LELET has drop {
        dummy_field: bool,
    }

    fun init(arg0: LELET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LELET>(arg0, 9, b"LELET", b"LALAYT", b"THAT THIS THEY GO THEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de93bc4d-ea5f-4c47-8c71-2935d801a960.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LELET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LELET>>(v1);
    }

    // decompiled from Move bytecode v6
}

