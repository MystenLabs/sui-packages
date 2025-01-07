module 0x995a46263cda44af8387d0ab1e796885570de52e2bc6e09ef43fdadbdad06466::one0000000 {
    struct ONE0000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE0000000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE0000000>(arg0, 9, b"ONE0000000", b"Pig", b"Cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c2710b3-d75e-48eb-942b-7d9360c165a1-1000009178.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE0000000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE0000000>>(v1);
    }

    // decompiled from Move bytecode v6
}

