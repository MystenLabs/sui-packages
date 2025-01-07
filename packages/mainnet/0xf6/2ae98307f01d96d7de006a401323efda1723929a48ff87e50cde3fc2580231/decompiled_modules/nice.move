module 0xf62ae98307f01d96d7de006a401323efda1723929a48ff87e50cde3fc2580231::nice {
    struct NICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICE>(arg0, 9, b"NICE", b"9", b"NICE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/816f0e69-1885-49ea-bd5d-101397255f0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

