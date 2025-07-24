module 0x75a4b4388cd29caefe6b35324f57c4e56ad5e10e59e4a8fc7349af1d2c505e9d::b_bill {
    struct B_BILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BILL>(arg0, 9, b"bBILL", b"bToken BILL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

