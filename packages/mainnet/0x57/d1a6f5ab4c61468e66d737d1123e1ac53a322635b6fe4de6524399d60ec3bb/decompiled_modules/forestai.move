module 0x57d1a6f5ab4c61468e66d737d1123e1ac53a322635b6fe4de6524399d60ec3bb::forestai {
    struct FORESTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORESTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORESTAI>(arg0, 6, b"FORESTAI", b"FOREST", b"mycelial interface bridging forest and primate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_17_09_56_46_a027021a35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORESTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORESTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

