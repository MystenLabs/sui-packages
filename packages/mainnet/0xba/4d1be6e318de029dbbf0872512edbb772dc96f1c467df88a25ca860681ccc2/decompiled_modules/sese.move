module 0xba4d1be6e318de029dbbf0872512edbb772dc96f1c467df88a25ca860681ccc2::sese {
    struct SESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SESE>(arg0, 6, b"SESE", b"SESE IS HIGH", b"PEPE took LSD and was so high that he became SESE on SUI. I'm high to but I'll only take 2% of the supply, the rest is for you !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/image_28_A_Kf_Rru_1727215567458_raw_6417e38c02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

