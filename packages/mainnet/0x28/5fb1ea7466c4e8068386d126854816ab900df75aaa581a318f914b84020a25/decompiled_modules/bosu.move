module 0x285fb1ea7466c4e8068386d126854816ab900df75aaa581a318f914b84020a25::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book of SUI", b"The book of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Dise_A_o_sin_t_A_tulo_7_removebg_preview_a9702f2768.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

