module 0xbf26508aa5474e038d4237917bb56727154812b90d2881ae62a42079e672b2fb::arca {
    struct ARCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCA>(arg0, 6, b"ARCA", b"ArcheriumAI", b"Flash Crashes, Fast Opportunities Navigating Crypto Volatility with Precision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735113740593.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

