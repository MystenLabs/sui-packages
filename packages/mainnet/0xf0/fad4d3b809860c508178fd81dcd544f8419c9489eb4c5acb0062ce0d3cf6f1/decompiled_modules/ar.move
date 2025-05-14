module 0xf0fad4d3b809860c508178fd81dcd544f8419c9489eb4c5acb0062ce0d3cf6f1::ar {
    struct AR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AR>(arg0, 9, b"AR", b"Engr AR", b"A well established project will explore more  future analysis related to crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1123df4ce367feb0cbec616a79b5c01bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

