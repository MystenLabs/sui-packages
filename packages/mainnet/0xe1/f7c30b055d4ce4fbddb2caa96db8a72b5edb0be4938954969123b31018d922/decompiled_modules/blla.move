module 0xe1f7c30b055d4ce4fbddb2caa96db8a72b5edb0be4938954969123b31018d922::blla {
    struct BLLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLLA>(arg0, 6, b"BLLA", b"BUBBLY LLAMA", b"Spitting memes and bubbly vibes, Bubbly Llama is here to spread laughter and gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_023833030_09c35dd4cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

