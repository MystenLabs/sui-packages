module 0xc6835d708edbf90af00935e683aaf87eaf4ea95e922a82b7c316c90225ff3cfd::gen {
    struct GEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEN>(arg0, 6, b"GEN", b"Genio", b"genio sui sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_removebg_preview_6485ec196f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

