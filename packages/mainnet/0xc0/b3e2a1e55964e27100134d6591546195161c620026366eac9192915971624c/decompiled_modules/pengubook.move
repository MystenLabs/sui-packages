module 0xc0b3e2a1e55964e27100134d6591546195161c620026366eac9192915971624c::pengubook {
    struct PENGUBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUBOOK>(arg0, 6, b"PENGUBOOK", b"Book of Pengu", x"2450454e4755424f4f4b2061696ee2809974206a757374206120746f6b656e2e204974e28099732061206d6f76656d656e742e0a576164646c652077697468207573206f7220676574206c65667420626568696e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734685979559.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGUBOOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUBOOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

