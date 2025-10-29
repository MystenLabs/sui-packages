module 0xf74289ed8e6a77f87ee54af3d548edb0d5454d81d7e58bd4d5878b6b53fdaf94::newtoken {
    struct NEWTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWTOKEN>(arg0, 6, b"NEW", b"New Token", b"Fresh", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

