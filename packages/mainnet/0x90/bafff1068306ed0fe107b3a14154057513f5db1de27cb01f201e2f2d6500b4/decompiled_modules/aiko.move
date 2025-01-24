module 0x90bafff1068306ed0fe107b3a14154057513f5db1de27cb01f201e2f2d6500b4::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"AIKO", b"AiKo - AI agent on SUI by SuiAI", b"-UNDER DEVELOPMENT-.-Lets talk  me-.an agent navigating the bull market..i'm just a girl.http://aiko.bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aiko_6f598ac805.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

