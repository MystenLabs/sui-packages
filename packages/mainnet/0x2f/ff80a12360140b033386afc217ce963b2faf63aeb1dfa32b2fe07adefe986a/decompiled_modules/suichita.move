module 0x2fff80a12360140b033386afc217ce963b2faf63aeb1dfa32b2fe07adefe986a::suichita {
    struct SUICHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHITA>(arg0, 6, b"SUICHITA", b"Suichita", b"The Pochita of SUI - $SUICHITA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_18_45_47_ba378f1cd3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

