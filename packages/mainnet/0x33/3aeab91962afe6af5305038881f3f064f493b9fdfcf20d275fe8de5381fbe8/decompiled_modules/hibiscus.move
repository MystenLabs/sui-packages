module 0x333aeab91962afe6af5305038881f3f064f493b9fdfcf20d275fe8de5381fbe8::hibiscus {
    struct HIBISCUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIBISCUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIBISCUS>(arg0, 6, b"HIBISCUS", b"Hibiscus Flower", b"First flower  on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000350325_cbc97b0b27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIBISCUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIBISCUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

