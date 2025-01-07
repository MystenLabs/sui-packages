module 0x28cfbf3de8d654aa8a860ccd45709ab1df7721bff98078764863f5d1e5335dc0::aisui {
    struct AISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUI>(arg0, 9, b"AISUI", b"AiSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AISUI>(&mut v2, 10000000000000000000, @0xaaee2c7ed242d13c52d1f998b745cc7f69611f85fef08a2dc8ba93bbddfbae4e, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

