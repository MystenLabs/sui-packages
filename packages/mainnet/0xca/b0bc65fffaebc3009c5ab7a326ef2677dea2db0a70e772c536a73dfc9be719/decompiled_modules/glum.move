module 0xcab0bc65fffaebc3009c5ab7a326ef2677dea2db0a70e772c536a73dfc9be719::glum {
    struct GLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUM>(arg0, 6, b"GLUM", b"GLUMM SUI", b"GLUM SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_00941eedd6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

