module 0xbc9f3140b202a4841ee4c8c0d854a80abb203fb45a1abcb0676f8dd387b108a3::brosui {
    struct BROSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROSUI>(arg0, 6, b"BROSUI", b"BRO'S SUI", b"BROSUI here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yid_Zi_Hak_AALO_Ht_a0af3d13fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

