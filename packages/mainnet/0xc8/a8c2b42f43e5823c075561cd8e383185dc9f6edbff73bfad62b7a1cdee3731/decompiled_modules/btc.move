module 0xc8a8c2b42f43e5823c075561cd8e383185dc9f6edbff73bfad62b7a1cdee3731::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"BTC SUI", b"The primary initiative at Bitcoin on SUI is to help facilitate the Coinbase mission of onboarding the next billion users onchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x0c41f1fc9022feb69af6dc666abfe73c9ffda7ce_4e0ce68fcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

