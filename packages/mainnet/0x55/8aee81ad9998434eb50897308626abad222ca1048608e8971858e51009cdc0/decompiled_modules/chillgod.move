module 0x558aee81ad9998434eb50897308626abad222ca1048608e8971858e51009cdc0::chillgod {
    struct CHILLGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGOD>(arg0, 6, b"CHILLGOD", b"Philips Banks", b"With a smirk as steady as Bitcoin's volatility, $CHILLGOD promises investors one thing: absolute vibes, no guarantees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732587916885.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

