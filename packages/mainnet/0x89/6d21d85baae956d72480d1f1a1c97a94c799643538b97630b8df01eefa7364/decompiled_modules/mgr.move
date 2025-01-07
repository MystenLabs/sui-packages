module 0x896d21d85baae956d72480d1f1a1c97a94c799643538b97630b8df01eefa7364::mgr {
    struct MGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGR>(arg0, 6, b"MGR", b"The Manager", b"I am the manager but you can call me \"Sir\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048859_f9ce331c65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

