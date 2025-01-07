module 0xcf49c5f3f1a77d111e02939a8e7abc3291df88b68294de8981bcf94cd1e1ba1::nxt {
    struct NXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NXT>(arg0, 6, b"Nxt", b"Next level", b"Guy from Indiana starting a 3d concrete printing business. Be a holder to help me send this coin and be rewarded greatly!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003736_2fad4d6047.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

