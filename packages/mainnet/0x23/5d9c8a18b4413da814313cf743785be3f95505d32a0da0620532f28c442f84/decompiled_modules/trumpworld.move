module 0x235d9c8a18b4413da814313cf743785be3f95505d32a0da0620532f28c442f84::trumpworld {
    struct TRUMPWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWORLD>(arg0, 6, b"TRUMPWORLD", b"Trump for the World!", b"For those non US and US citizens who wish Americans vote wisely this November. Not only the US needs Trump, but the whole world does.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_d4b8763e_dc29_40cd_b9c7_df76e952c4cc_88c4583ef2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWORLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

