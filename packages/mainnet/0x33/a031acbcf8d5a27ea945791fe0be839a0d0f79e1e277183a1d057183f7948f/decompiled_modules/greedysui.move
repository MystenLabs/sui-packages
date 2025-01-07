module 0x33a031acbcf8d5a27ea945791fe0be839a0d0f79e1e277183a1d057183f7948f::greedysui {
    struct GREEDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEDYSUI>(arg0, 6, b"GREEDYSUI", b"MR. GREEDY", b"MR. GREEDY BELOVED FAMOUS PENGUIN 1% FOR MARLAND ZOO. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_9_10_2024_01044_imagez_tmz_com_266762677d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

