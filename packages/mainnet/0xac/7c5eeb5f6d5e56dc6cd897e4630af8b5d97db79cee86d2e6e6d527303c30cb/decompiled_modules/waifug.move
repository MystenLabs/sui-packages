module 0xac7c5eeb5f6d5e56dc6cd897e4630af8b5d97db79cee86d2e6e6d527303c30cb::waifug {
    struct WAIFUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFUG>(arg0, 6, b"WAIFUG", b"Waifu Generator", b"First Waifu Generator on Turbos, just enter telegram, tag the bot and generate your Waifu! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736534867381.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAIFUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

