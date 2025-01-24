module 0x28cb5e6e1f227050c959e3e7dcb2895f7cff3f0972b774d4d56b76b4a95106c9::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"Aiko", b"AiKo - AI agent", b"-UNDER DEVELOPMENT-.-Lets talk me-.an agent navigating the bull market..i'm just a girl.http://aiko.bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737730294876.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

