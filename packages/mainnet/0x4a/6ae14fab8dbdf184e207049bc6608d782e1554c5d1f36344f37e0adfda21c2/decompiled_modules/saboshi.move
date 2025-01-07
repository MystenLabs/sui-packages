module 0x4a6ae14fab8dbdf184e207049bc6608d782e1554c5d1f36344f37e0adfda21c2::saboshi {
    struct SABOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SABOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SABOSHI>(arg0, 6, b"SABOSHI", b"SABOSHI is AI CATS", b"JUST FIRST MEME CATS in Turbo. TWITTER, TELEGRAM and WEBSITE will build after bonding Curve. Fair lounch Dev not Buy. Just Celebrate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972442285.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SABOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SABOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

