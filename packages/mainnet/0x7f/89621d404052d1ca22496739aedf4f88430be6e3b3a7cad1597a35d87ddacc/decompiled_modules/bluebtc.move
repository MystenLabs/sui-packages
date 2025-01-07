module 0x7f89621d404052d1ca22496739aedf4f88430be6e3b3a7cad1597a35d87ddacc::bluebtc {
    struct BLUEBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBTC>(arg0, 6, b"BlueBTC", b"Blue Bitcoin", b"BlueBitcoin to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0330_22d6256411.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

