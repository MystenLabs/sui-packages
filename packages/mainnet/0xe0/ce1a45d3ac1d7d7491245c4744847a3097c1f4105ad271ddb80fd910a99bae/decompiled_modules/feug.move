module 0xe0ce1a45d3ac1d7d7491245c4744847a3097c1f4105ad271ddb80fd910a99bae::feug {
    struct FEUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEUG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FEUG>(arg0, 6, b"FEUG", b"Feug on Sui by SuiAI", b"The Cutest Fug Around.Feug is an adorable, fun-loving character or token on the Sui network, designed to bring lighthearted joy and a sense of community to its users. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8018_20bb1e4cb5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FEUG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEUG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

