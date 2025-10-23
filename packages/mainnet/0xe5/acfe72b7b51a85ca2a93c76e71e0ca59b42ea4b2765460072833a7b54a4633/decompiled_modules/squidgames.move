module 0xe5acfe72b7b51a85ca2a93c76e71e0ca59b42ea4b2765460072833a7b54a4633::squidgames {
    struct SQUIDGAMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDGAMES>(arg0, 9, b"sQUiDGAMES", b"SQUIDGAMES", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761224609/sui_tokens/p2revpn0cudckvhbauxl.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDGAMES>>(0x2::coin::mint<SQUIDGAMES>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SQUIDGAMES>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUIDGAMES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

