module 0x5f3c7aba5a98b9d1c3935e735742b5c03237be22b2f2507761f3708e86c06910::sgoblin {
    struct SGOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOBLIN>(arg0, 6, b"SGOBLIN", b"Sui Goblin Town", b"AAAAAAAUUUUUGGGHHHHH gobblins goblinns GOBLINNNNNNNNns wekm ta goblintown yoo sniksnakr DEJEN RATS oooooh rats are yummmz dis a NEFTEEE O GOBBLINGS on da BLOKCHIN wat?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_ff0f235890.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOBLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

