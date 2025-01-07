module 0x1cf1e843922465bce4694eca8df693230b79dc4daa9c65700cb6511efd9b11de::horny {
    struct HORNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORNY>(arg0, 6, b"HORNY", b"HORNY DEGEN", x"4120e2809c686f726e7920646567656ee2809d20696e2063727970746f63757272656e63792072656665727320746f20616e20696d70756c736976652c20686967682d7269736b207472616465722064726976656e206279206578636974656d656e742c20687970652c206f7220464f4d4f202866656172206f66206d697373696e67206f7574292c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732026657972.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

