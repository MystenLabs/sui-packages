module 0x112640fa5a2fbaa6c0e930453fc4d40734fc1a38681bbe7e0b2170a1b7ddad68::ahgfhgfjh {
    struct AHGFHGFJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHGFHGFJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHGFHGFJH>(arg0, 9, b"AHGFHGFJH", b"fghgfjhgfj", b"fhgfjhgfjhgfjhgfjhgfj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eede73d3-c10c-4734-994a-941566001652.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHGFHGFJH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHGFHGFJH>>(v1);
    }

    // decompiled from Move bytecode v6
}

