module 0x2474e9c69eca87e73a8c8cd6fafec070c8a334352bb224e2ef998a4409adcf5c::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 6, b"APT", b"APT DOG", x"4150542c204150540a4150542c204150540a4150542c204150540a55682c2075682d6875682c2075682d687568", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ED_08_ABDA_7_EE_1_41_FA_A9_FF_EE_1_AEC_3715_BD_8c8bf72bcc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APT>>(v1);
    }

    // decompiled from Move bytecode v6
}

