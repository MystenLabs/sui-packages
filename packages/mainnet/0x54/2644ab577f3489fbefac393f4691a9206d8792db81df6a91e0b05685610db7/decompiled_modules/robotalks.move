module 0x542644ab577f3489fbefac393f4691a9206d8792db81df6a91e0b05685610db7::robotalks {
    struct ROBOTALKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTALKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTALKS>(arg0, 6, b"RoboTalks", b"Robotalks AI", b"Robotalks is your conversational AI buddy designed to provide quick, intelligent, and engaging responses to your queries.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738253460057.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOTALKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTALKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

