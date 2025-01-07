module 0x9f5a598dd8395c75b40e8977e6c7e4a9a1670b03e48ec319bd1bab8f332fa78a::cld {
    struct CLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLD>(arg0, 6, b"CLD", b"Cloudycoin", b"TRUST Cloudy Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241225_WA_0040_b83c1664df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

