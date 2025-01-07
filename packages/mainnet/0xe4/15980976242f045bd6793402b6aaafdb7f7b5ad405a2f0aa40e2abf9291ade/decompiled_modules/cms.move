module 0xe415980976242f045bd6793402b6aaafdb7f7b5ad405a2f0aa40e2abf9291ade::cms {
    struct CMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMS>(arg0, 6, b"CMS", b"COMINGSOON", x"5748454e204d41524b4554494e47203f3f20434f4d494e47534f4f4e0a434558204c495354494e47203f3f20434f4d494e47534f4f4e0a57414e5420544f2052494348203f3f20434f4d494e47534f4f4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046385_6f8131ba69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

