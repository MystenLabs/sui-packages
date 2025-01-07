module 0xdef28517bb5d73502495471bc512051f9cf685848b29b431335a1b117d2855d2::kimjongpepe {
    struct KIMJONGPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMJONGPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMJONGPEPE>(arg0, 6, b"KIMJONGPEPE", b"KIMJONGPEPE ON SUI", b"KIMJONGPEPE ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_14_23_21_28_ad92bfe154.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMJONGPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMJONGPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

