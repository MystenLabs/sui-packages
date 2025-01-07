module 0x98f679a9bf023410b940b063cfa222964e19418ca40de65853b1bf824a651a7d::PureSeraphWings {
    struct PURESERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURESERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURESERAPHWINGS>(arg0, 0, b"COS", b"Pure Seraph Wings", b"Take flight in this godly oasis... Behold our great wonders here from above...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Pure_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PURESERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURESERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

