module 0x73998a9eb5bef39c8b40878c92452728156ea028dec220a27e12e15361b47415::earn_casual {
    struct EARN_CASUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARN_CASUAL, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 663 || 0x2::tx_context::epoch(arg1) == 664, 1);
        let (v0, v1) = 0x2::coin::create_currency<EARN_CASUAL>(arg0, 9, b"ECS", b"Earn Casual", x"4561726e2043617375616c20697320612077656233206170702077686572652075736572732063616e206561726e206d6f6e657920627920706c6179696e672063617375616c2062726f777365722067616d65732e200a0a4f6666696369616c20776562736974653a2068747470733a2f2f7777772e6561726e63617375616c2e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/sDbNBsNN/Logo-Round.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EARN_CASUAL>(&mut v2, 100000000000000000, @0x54a36cef57bce164c897c59012db703087617125b1258718fa28256fac63eee2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARN_CASUAL>>(v2, @0x54a36cef57bce164c897c59012db703087617125b1258718fa28256fac63eee2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARN_CASUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

