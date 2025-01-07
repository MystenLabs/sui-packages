module 0x702b5ca1a0ec57779c7069dc5ab07407637c1e3422164cd9bd48e1aec805690e::cocow {
    struct COCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCOW>(arg0, 6, b"COCOW", b"Coco thr cow", b"why stake when you can graze?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048499_d0adf81e62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

