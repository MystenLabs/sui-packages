module 0xf0591459c8b92e37b92d7a8bd0ad595e1497db93aa07847caafe49df8d659ef2::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BTC", b"BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUAI_logo_png_10_4e8e72afd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

