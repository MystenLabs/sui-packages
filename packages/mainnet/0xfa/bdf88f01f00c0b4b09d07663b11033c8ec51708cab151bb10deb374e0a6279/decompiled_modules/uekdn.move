module 0xfabdf88f01f00c0b4b09d07663b11033c8ec51708cab151bb10deb374e0a6279::uekdn {
    struct UEKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UEKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UEKDN>(arg0, 9, b"UEKDN", b"osown", b"nsnen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ef4c96c9-b186-4bd0-86ad-64218cbb45d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UEKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UEKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

