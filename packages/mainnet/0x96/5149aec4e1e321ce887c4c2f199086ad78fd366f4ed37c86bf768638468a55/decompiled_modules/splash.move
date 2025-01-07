module 0x965149aec4e1e321ce887c4c2f199086ad78fd366f4ed37c86bf768638468a55::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPLASH>(arg0, 6, b"SPLASH", b"Splash AI", b"The @aixbt_agent on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Splash_AI_c05a24ae58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLASH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

