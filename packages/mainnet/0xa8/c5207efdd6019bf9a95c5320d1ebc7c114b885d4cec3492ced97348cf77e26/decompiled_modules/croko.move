module 0xa8c5207efdd6019bf9a95c5320d1ebc7c114b885d4cec3492ced97348cf77e26::croko {
    struct CROKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROKO>(arg0, 6, b"CROKO", b"CROKO SUI", b"CROKO  merges the realms of fashion and digitalization", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_23_58_38_6371d16198.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

