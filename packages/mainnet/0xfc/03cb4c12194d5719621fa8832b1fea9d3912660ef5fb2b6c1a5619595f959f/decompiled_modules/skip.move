module 0xfc03cb4c12194d5719621fa8832b1fea9d3912660ef5fb2b6c1a5619595f959f::skip {
    struct SKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIP>(arg0, 6, b"SKIP", b"Skip Cat Sui", b"a hop a skip and a jump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_08_at_21_56_01_a7bb7b04a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

