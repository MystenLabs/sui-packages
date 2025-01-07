module 0xba16ec3816dd24504162fd4c3763762563092a1a56b069be20145b6940cde5d3::kinky {
    struct KINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINKY>(arg0, 6, b"KINKY", b"KINKY the GAY FISH", b"I'm KINKYYY and I'm GayYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_25_23_25_09_c3e1d7c9a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

