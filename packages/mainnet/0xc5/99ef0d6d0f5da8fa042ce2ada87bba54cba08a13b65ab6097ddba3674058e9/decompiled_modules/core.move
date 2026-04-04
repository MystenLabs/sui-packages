module 0xc599ef0d6d0f5da8fa042ce2ada87bba54cba08a13b65ab6097ddba3674058e9::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 6, b"CORE", b"Meme Core", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CORE>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CORE>>(v2);
    }

    // decompiled from Move bytecode v6
}

