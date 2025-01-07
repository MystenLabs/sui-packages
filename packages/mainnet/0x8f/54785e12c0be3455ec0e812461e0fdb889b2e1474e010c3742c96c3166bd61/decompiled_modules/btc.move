module 0x8f54785e12c0be3455ec0e812461e0fdb889b2e1474e010c3742c96c3166bd61::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BITCOIN", b"A PEER TO PEER ELECTRONIC CASH SYSTEM WITHOUT A TRUSTED THIRD PARTY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bitcoin_Logo_700x394_ae4709388c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

