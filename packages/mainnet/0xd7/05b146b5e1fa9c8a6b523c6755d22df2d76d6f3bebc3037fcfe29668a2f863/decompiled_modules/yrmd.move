module 0xd705b146b5e1fa9c8a6b523c6755d22df2d76d6f3bebc3037fcfe29668a2f863::yrmd {
    struct YRMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YRMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YRMD>(arg0, 6, b"YRMD", b"SuiYramidCoin", b"yrmd is the pufferfish of the meme coin world, bringing fun and charm. Puffi has the cool factor AND unique style. Built on the Sui blockchain, yrmd is here to shake things up and spice up the meme coin game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070122_29bbe73d69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YRMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YRMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

