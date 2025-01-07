module 0x4706012b3f8a1599c2fb41c4806266cd167614978d3c320045e4eaf284fe9e27::ploktus {
    struct PLOKTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOKTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOKTUS>(arg0, 6, b"PLOKTUS", b"Ploktus", b"#PLOKTUS is gearing up for the launch on Solana this Winter! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/354235_06b2513c03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOKTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOKTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

