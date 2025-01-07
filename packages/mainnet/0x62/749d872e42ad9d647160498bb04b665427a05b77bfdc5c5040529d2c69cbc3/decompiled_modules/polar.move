module 0x62749d872e42ad9d647160498bb04b665427a05b77bfdc5c5040529d2c69cbc3::polar {
    struct POLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAR>(arg0, 6, b"POLAR", b"Polar Sui", x"446973636f76657220746865206e6578742067656e65726174696f6e206f66206d656d65636f696e7320776974682024504f4c415220537569e280946372616674656420666f7220696e766573746f72732077686f2064656d616e64206d6f72652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731770658223.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

