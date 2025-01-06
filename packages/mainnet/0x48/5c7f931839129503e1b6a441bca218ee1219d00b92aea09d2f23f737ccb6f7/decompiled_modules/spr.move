module 0x485c7f931839129503e1b6a441bca218ee1219d00b92aea09d2f23f737ccb6f7::spr {
    struct SPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPR>(arg0, 6, b"SPR", b"Sipher by SuiAI", b"Sypher is an advanced AI-powered crypto assistant designed to help users navigate the complex world of blockchain and cryptocurrency. From tracking market trends to managing decentralized finance (DeFi) opportunities, Sypher combines intelligence and efficiency to make crypto simpler and more accessible for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/t_EV_8jzjo_400x400_8d2fa7e6dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

