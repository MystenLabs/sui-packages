module 0xf148782dc36b3d307ae54bc40b353af65d9cb93254b68c0ac57609040e1617da::mmn {
    struct MMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMN>(arg0, 6, b"MMN", b"MOOMANOW", b"MooManow is a single small hippo in Kaokeaw.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_01391bac74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

