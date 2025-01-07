module 0x55fc66bc39a001c9f5b59126a6ce045039072c93f809457b2da369a86c91c446::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 6, b"DAM", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://staticsui.s3.us-east-1.amazonaws.com/suibever_sui.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAM>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DAM>>(v2);
    }

    // decompiled from Move bytecode v6
}

