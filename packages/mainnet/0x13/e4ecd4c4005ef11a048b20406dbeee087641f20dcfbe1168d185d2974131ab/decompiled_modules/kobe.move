module 0x13e4ecd4c4005ef11a048b20406dbeee087641f20dcfbe1168d185d2974131ab::kobe {
    struct KOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBE>(arg0, 6, b"KOBE", b"KOBESUI", b"KOBE even has his own Instagram account, created by the owner of $SHIBA INU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KOBE_3_750x1024_f8b1d7acd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

