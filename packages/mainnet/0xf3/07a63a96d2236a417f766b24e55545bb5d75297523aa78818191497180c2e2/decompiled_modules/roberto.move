module 0xf307a63a96d2236a417f766b24e55545bb5d75297523aa78818191497180c2e2::roberto {
    struct ROBERTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBERTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBERTO>(arg0, 6, b"ROBERTO", b"Roberto Sucks", b"become higher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031118_cf96b63d09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBERTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBERTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

