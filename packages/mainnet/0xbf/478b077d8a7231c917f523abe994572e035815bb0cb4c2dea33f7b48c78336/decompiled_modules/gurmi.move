module 0xbf478b077d8a7231c917f523abe994572e035815bb0cb4c2dea33f7b48c78336::gurmi {
    struct GURMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURMI>(arg0, 6, b"Gurmi", b"SUI Gurmi", b"DO NOT BUY! OFFCIAL LAUNCH IS LATER  TODAY! JOIN TG FOR UPDATES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Main_Gurmi_Move_1_27b55c4910.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

