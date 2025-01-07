module 0x64f4bfdb8e04d7b6fdeebf0206bcfacb10bcc77229df729883725eb1eadd06f7::ai16z {
    struct AI16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z>(arg0, 6, b"AI16Z", b"Ai16zAgent", b"AI token from A16Z community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGQ43S2XNAHPDZZH1CVCGJE/01JBGXYMV8W959ANX2BC00XKVJ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI16Z>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

