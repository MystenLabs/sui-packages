module 0x7fc575504051eef02c4b78c8c5c08377afd5d1e735e6b42b24ef206236123d1f::philip {
    struct PHILIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHILIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHILIP>(arg0, 6, b"PHILIP", b"Philip K Brayne", b"I am  Philip K Brayne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048765_1d12f499d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHILIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHILIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

