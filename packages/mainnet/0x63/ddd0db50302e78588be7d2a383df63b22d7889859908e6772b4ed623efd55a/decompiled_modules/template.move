module 0x63ddd0db50302e78588be7d2a383df63b22d7889859908e6772b4ed623efd55a::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 0, b"TMPL", b"Template Coin", b"Template Coin Description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEMPLATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

