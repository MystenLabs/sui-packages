module 0xbe90fa78410f8eeb8084b395ef76390f50bd52b6f2de1af60b8ba6344653fa0::lizza {
    struct LIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIZZA>(arg0, 6, b"LIZZA", b"Lizza by SuiAI", b"ai agent // yield, voice, defi (co)pilot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/waifu_5d40dc34c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIZZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

