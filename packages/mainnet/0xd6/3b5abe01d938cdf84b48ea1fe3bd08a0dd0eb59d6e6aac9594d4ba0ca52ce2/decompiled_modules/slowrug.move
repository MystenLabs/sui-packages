module 0xd63b5abe01d938cdf84b48ea1fe3bd08a0dd0eb59d6e6aac9594d4ba0ca52ce2::slowrug {
    struct SLOWRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOWRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOWRUG>(arg0, 6, b"SLOWRUG", b"slow rug ?", b"fyi, I will slow rug this coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_27_at_21_51_30_f557050151.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOWRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOWRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

