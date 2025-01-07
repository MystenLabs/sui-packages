module 0xf41ce6fe00114d95e6f377b1b405efe75dd0fcc77c3fd68945769c80fb8b3d68::ca {
    struct CA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CA>(arg0, 6, b"CA", b"Contract Address", b"The only CA you'll actually want to pay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capng_ad0ebb8a84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CA>>(v1);
    }

    // decompiled from Move bytecode v6
}

