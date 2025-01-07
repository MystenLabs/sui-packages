module 0x8171955c25848aa973bba920c056434ff28e8fea91becbd19094383034072f5c::llihc {
    struct LLIHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLIHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLIHC>(arg0, 6, b"LLIHC", b"Just a llihc guy", b"Just a llihc guy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gcih1_YDWEA_Add_AA_c1926b3c78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLIHC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLIHC>>(v1);
    }

    // decompiled from Move bytecode v6
}

