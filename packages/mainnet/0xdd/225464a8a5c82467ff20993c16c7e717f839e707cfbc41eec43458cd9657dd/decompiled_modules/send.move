module 0xdd225464a8a5c82467ff20993c16c7e717f839e707cfbc41eec43458cd9657dd::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEND>(arg0, 9, b"SEND", b"Suilend Protocol", x"5375696c656e6420697320537569e280997320446546692073756974652c206f66666572696e67206c656e64696e672c206c6971756964207374616b696e672c20616e64207377617070696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1757887744280563712/0Z5Uxq5i_400x400.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEND>>(0x2::coin::mint<SEND>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SEND>>(v2);
    }

    // decompiled from Move bytecode v6
}

