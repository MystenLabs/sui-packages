module 0xfab23059d4c9174caa03fcc3979025b11bfbc3d4fea74f3f02e1302b74daff0b::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"SIUUU", b"AAA SIUUU", b"Can't stop won't stop (thinking about SIUUU) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015772_89e79bf866.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

