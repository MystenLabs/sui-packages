module 0x61d623e70603b89c86e7afb3b55772b15cae27c660b72c9fa0619d4738369a76::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"Bubbly The Cat", b"Join me for the epic adventure of \"BUBBLY THE CAT\". New animated episodes dropping each week. Follow the BUBBLY socials and prepare for the adventure of a lifetime with $BTC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958682614.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

