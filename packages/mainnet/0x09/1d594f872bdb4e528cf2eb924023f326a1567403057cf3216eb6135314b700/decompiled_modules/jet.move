module 0x91d594f872bdb4e528cf2eb924023f326a1567403057cf3216eb6135314b700::jet {
    struct JET has drop {
        dummy_field: bool,
    }

    fun init(arg0: JET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JET>(arg0, 6, b"JET", b"Jeet Blue", b"Jeet Blue: The official airline of panic selling at the slightest dip. Proudly serving weak hands since 2009.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hhhhhhhhhhh_d7a1fa353f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JET>>(v1);
    }

    // decompiled from Move bytecode v6
}

