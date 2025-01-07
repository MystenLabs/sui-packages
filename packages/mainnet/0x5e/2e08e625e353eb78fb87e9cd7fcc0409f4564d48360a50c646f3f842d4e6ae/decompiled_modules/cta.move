module 0x5e2e08e625e353eb78fb87e9cd7fcc0409f4564d48360a50c646f3f842d4e6ae::cta {
    struct CTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTA>(arg0, 6, b"CTA", b"Camelot", b"Camelot is a coin of honor! All liquidity received from the coin will be multiplied in various instruments. Each holder will receive drops from the profit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732616906286.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

