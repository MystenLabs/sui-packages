module 0xfa9d10535801680ff8336fd6c948b14dff5f47c7116b4c2aff0eafcb3c4330b3::sicko {
    struct SICKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICKO>(arg0, 6, b"Sicko", b"sicko mode", b"its time to go sicko mode", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_7bfe488649.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SICKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

