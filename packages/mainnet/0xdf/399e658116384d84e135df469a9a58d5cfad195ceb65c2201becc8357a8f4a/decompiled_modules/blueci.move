module 0xdf399e658116384d84e135df469a9a58d5cfad195ceb65c2201becc8357a8f4a::blueci {
    struct BLUECI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECI>(arg0, 6, b"BLUECI", b"BlueiIceCan", b"$BLUECI The first Can on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Ice_24_Cans_330m_L_30d135746d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECI>>(v1);
    }

    // decompiled from Move bytecode v6
}

