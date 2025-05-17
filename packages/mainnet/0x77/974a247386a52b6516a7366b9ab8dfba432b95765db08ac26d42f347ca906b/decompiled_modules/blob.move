module 0x77974a247386a52b6516a7366b9ab8dfba432b95765db08ac26d42f347ca906b::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 9, b"BLOB", b"blob", b"just a blob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9900/kappa/coins/e32e1887-a0ba-4d16-b245-1cfe178f290c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

