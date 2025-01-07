module 0x51543f169b4d8ed6a85d07aea57545c42fca9c662359f7ad39d392d98a32197c::czpumps {
    struct CZPUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZPUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZPUMPS>(arg0, 6, b"CZPUMPS", b"CZ PUMPS", x"5468652050656f706c65277320536176696f7220697320636f6d696e67206261636b2066726f6d20707269736f6e20746f206869732063727970746f2070616c61636520616e642069732073657420746f2070756d7020746865206d61726b657420616e642070756d70206f757220626167732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CZ_980949cc3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZPUMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZPUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

