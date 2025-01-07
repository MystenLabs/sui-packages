module 0xa01efcb412d5fefd74e4bf405812a4f2703a522ee46b7b6dfe54726478cab09f::slide {
    struct SLIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIDE>(arg0, 6, b"Slide", b"Zenguin", b"Emperor of Titan in multiverse 420690888", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_C6_C86_B4_2_F11_40_B7_AADA_8_D974_FA_1_FC_4_F_4c6aa0e48f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

