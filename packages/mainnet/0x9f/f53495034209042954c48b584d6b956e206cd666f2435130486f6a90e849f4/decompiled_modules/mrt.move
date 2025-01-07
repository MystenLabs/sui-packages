module 0x9ff53495034209042954c48b584d6b956e206cd666f2435130486f6a90e849f4::mrt {
    struct MRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRT>(arg0, 6, b"MRT", b"this is mrt's token", b"https://dex.bluemove.net/static/media/sui-token.8cd39475a2cf46c2486c.png", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRT>>(v1);
        0x2::coin::mint_and_transfer<MRT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

