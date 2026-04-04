module 0x139157654b21abc1cf923a4855de068526a0e993695baee1f157006d62ab7187::deltabot {
    struct DELTABOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELTABOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELTABOT>(arg0, 6, b"DELTABOT", b"Delta Bot", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DELTABOT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELTABOT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DELTABOT>>(v2);
    }

    // decompiled from Move bytecode v6
}

