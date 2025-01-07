module 0xf3cace1056d48a5819869e9b7052d8100ff21d2ec83c42317a01c25199a4326d::hoot {
    struct HOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOT>(arg0, 6, b"HOOT", b"HOOT CTUE ON SUI", b"FIRST HOOT CTUE ON SUI: https://www.hootcuteonsui.lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_29_19_15_36_af75de1982.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

