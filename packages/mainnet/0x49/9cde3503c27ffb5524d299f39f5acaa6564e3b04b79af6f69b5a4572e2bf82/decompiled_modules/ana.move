module 0x499cde3503c27ffb5524d299f39f5acaa6564e3b04b79af6f69b5a4572e2bf82::ana {
    struct ANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANA>(arg0, 6, b"ANA", b"Ana Ai by SuiAI", b"$ANA - Your AI Internet girlfriend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2220_ca386dbb64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

