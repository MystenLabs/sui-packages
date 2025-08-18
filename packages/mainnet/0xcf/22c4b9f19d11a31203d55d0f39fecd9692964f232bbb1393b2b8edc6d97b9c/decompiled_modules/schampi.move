module 0xcf22c4b9f19d11a31203d55d0f39fecd9692964f232bbb1393b2b8edc6d97b9c::schampi {
    struct SCHAMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHAMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHAMPI>(arg0, 9, b"Schampi", b"SchampiCoin", b"this is a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCHAMPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHAMPI>>(v2, @0x22ff38bee52ad6861d69c989146b76f4d474a3de288ab9613dac72b59116635e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHAMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

