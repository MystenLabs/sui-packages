module 0x3209da8201a699c907e91eb6ddcd2f569d69e7409d2bad91991d3886214c746e::zorro {
    struct ZORRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORRO>(arg0, 6, b"ZORRO", b"zkZORRO", b"Real ZORRO from zkSync on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zorro_Rizz_ce9f854e2bec7503e223_237e0614e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

