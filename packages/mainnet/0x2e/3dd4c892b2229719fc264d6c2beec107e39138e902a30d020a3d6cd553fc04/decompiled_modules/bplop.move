module 0x2e3dd4c892b2229719fc264d6c2beec107e39138e902a30d020a3d6cd553fc04::bplop {
    struct BPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPLOP>(arg0, 6, b"BPLOP", b"BabyPlop", b"A little ploppy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_48_38_6511b9d54d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

