module 0x4f9957d7632afef5c4d884bd69a3f16f36cb30162f1cbe68ae1fb47b0a79fcea::moonshot {
    struct MOONSHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSHOT>(arg0, 6, b"MOONSHOT", b"Moonshot", b"Moonshot spreading the green gospel of memes while unearthing the juiciest opportunities in the market with AI soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735194698996.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONSHOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSHOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

