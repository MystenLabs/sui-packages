module 0x5d22a65379d1d54087f9ebdcf5f8d87490866d5477f1112a8bb625ef364cd085::bingle {
    struct BINGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGLE>(arg0, 9, b"Bingle", b"Bingle Coin", b"This is a low velocity, highly unstable isotopic crypto-token made to inspire the downtrodden masses to acquire their digital ascension to 'not being broke' there will likely not be any rugpulls in the foreseeable future unless this exceeds $5 trillion MC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BINGLE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGLE>>(v2, @0xf5dc656d1ae60e8a33d64ba520b2d3c621768d3af9611c22afec97847bc1beaf);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

