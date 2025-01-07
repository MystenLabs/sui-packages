module 0xbb38cd862519401378d72c119b7baab3f7bc9593689c5034b3c047691f04214c::tated {
    struct TATED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATED>(arg0, 6, b"TateD", b"DaddyTATE", b"Let's fucking go ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7243_1173a22c4c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATED>>(v1);
    }

    // decompiled from Move bytecode v6
}

