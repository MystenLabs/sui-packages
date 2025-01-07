module 0x601607650e6dccd8901c0d6ff2727dc3bb2c78b295edc21ac3a87a9c8bf02599::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSHARK>(arg0, 9, b"BULLSHARK", b"BULLSHARK", b"BULLSHARK", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLSHARK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

