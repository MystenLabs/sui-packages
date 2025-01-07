module 0x7a7b785fdbd8efae384e39c3d930ccfac705f80c1e59ee542d6e640a658a931e::hoe {
    struct HOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOE>(arg0, 6, b"HOE", b"HOE RETARDIO", b"call for free retardio s*x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_1_3700ed5e5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

