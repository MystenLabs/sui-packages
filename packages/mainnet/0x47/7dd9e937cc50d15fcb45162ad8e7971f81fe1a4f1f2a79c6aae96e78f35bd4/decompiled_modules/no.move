module 0x477dd9e937cc50d15fcb45162ad8e7971f81fe1a4f1f2a79c6aae96e78f35bd4::no {
    struct NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO>(arg0, 6, b"NO", b"No More 925", b"No More 9 to 5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nomore925_0ba1b884d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NO>>(v1);
    }

    // decompiled from Move bytecode v6
}

