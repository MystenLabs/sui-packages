module 0xd3802a53f43b78b138332cc5e064877d8e9709ddf7a537fdfd0d76bf186f6b60::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", b"DeeznutonSui", b"Official account for Turbos, the first meme token standard on SUI. Home to Deez $NUTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731027471930.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

