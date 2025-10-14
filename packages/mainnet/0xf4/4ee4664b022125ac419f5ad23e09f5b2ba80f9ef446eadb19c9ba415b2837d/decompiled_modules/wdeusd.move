module 0xf44ee4664b022125ac419f5ad23e09f5b2ba80f9ef446eadb19c9ba415b2837d::wdeusd {
    struct WDEUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDEUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDEUSD>(arg0, 6, b"wdeUSD", b"Wrapped deUSD", b"Wrapped deUSD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDEUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDEUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

