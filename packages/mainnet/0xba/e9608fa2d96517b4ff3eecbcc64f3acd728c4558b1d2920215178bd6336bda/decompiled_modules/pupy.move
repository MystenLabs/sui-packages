module 0xbae9608fa2d96517b4ff3eecbcc64f3acd728c4558b1d2920215178bd6336bda::pupy {
    struct PUPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPY>(arg0, 6, b"PUPY", b"Pupy on Sui", b"The $pupy is so cute that at first you cringe, and then you look at the chart and yell with happiness. He's not here to bark, he's here to pummel! And your portfolio will be grateful for this encounter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734430774641.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

