module 0x6056dc08dfab712d0d8278e6fb7f275addad25ce89e9f2f3ce64b6f9f11d5812::bbtc {
    struct BBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBTC>(arg0, 6, b"BBTC", b"BlueBTC", b"The BTC of sui, wayyyy better!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3101_13c8ea2283.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

