module 0x4d31a6ec89d3af7fba2eebb884d34f3078a4fdf6f1d084943bff01be67cbdee4::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"Gud Mornin", b"Pepe has been loving his time with frens, turning every morning into a truly gud mornin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_186cd67e6e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

