module 0x1082987ae503e437e8380e5740465083e29184f8088a9d6108eb5dd23ff0f376::cathulhu {
    struct CATHULHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATHULHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATHULHU>(arg0, 6, b"CATHULHU", b"CATHULHU SUI", b"Meet Cathulhu, the cosmic overlord of nightmares and cuteness. Exposure to Cathulhu can drive people to love, madness and horror.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_12_57_52_d3023a4281.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATHULHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATHULHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

