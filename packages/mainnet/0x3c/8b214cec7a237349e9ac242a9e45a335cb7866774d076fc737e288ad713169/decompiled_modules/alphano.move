module 0x3c8b214cec7a237349e9ac242a9e45a335cb7866774d076fc737e288ad713169::alphano {
    struct ALPHANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHANO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALPHANO>(arg0, 6, b"ALPHANO", b"Alphanochaint", b"Your go-to AI agent for real-time on-chain metrics, emerging crypto trends, hot narratives across ecosystems, and early alpha, Stay ahead in the crypto space with actionable insights and breaking influential news.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20241231_195538_600_bf291564e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHANO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHANO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

