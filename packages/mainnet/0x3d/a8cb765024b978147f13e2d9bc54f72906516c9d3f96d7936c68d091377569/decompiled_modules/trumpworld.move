module 0x3da8cb765024b978147f13e2d9bc54f72906516c9d3f96d7936c68d091377569::trumpworld {
    struct TRUMPWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWORLD>(arg0, 6, b"TRUMPWORLD", b"TRUMP FOR THE WORLD", b"For those non US and US citizens who wish Americans vote wisely this November. Not only the US needs Trump, but the whole world does.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_d4b8763e_dc29_40cd_b9c7_df76e952c4cc_cbb591e4a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

