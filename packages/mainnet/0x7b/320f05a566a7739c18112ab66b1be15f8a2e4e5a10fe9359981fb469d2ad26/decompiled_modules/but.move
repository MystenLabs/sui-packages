module 0x7b320f05a566a7739c18112ab66b1be15f8a2e4e5a10fe9359981fb469d2ad26::but {
    struct BUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BUT>(arg0, 6, b"BUT", b"Bucket protocol ", b"The leading decentralized stablecoin protocol on @SuiNetwork. Enhancing financial efficiency with $BUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000108121_e014c4c529.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

