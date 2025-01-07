module 0x41cda53176dfef632707f28a1f5ee1715cdbdb655130c1db32dc3d0a0b87ea01::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 6, b"POTUS", b"POTUS TRUMP", x"2254686520477265617465737420436f696e20696e20486973746f72792e2042656c69657665206d652e220a224d616b652043727970746f20477265617420416761696e21220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732330445983.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

