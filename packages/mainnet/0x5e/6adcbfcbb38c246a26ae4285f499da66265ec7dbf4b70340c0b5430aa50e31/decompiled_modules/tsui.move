module 0x5e6adcbfcbb38c246a26ae4285f499da66265ec7dbf4b70340c0b5430aa50e31::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"Tsui", b"Tinder Suindler", b"The Tinder Suindler is a about Suimon Leviev, who used dating apps to con women into believing he was a wealthy businessman, ultimately swindling them out of hundreds of thousands of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiiski_0ff12d1cc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

