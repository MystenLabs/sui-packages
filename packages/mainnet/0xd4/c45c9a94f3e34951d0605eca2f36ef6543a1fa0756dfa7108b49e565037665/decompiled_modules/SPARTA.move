module 0xd4c45c9a94f3e34951d0605eca2f36ef6543a1fa0756dfa7108b49e565037665::SPARTA {
    struct SPARTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTA>(arg0, 6, b"Spartan", b"SPARTA", b"One out of 300", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

