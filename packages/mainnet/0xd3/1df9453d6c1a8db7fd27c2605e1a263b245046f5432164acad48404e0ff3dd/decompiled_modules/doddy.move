module 0xd31df9453d6c1a8db7fd27c2605e1a263b245046f5432164acad48404e0ff3dd::doddy {
    struct DODDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODDY>(arg0, 6, b"DODDY", b"DoddyTheBabyOil", x"49276d20796f75722064616464792c206272696e67206d6520426f64656e20616e64205472656d702e20492077696c6c206c6574207468656d207461737465206d7920446f646479206f696c210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zn_WS_3sb_YAAGDWD_a6204fea34.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

