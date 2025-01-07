module 0xa231be5ba0998e7373cbc389e774459158888248363816b87e869c7c9b1a7c6::poshi {
    struct POSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSHI>(arg0, 6, b"POSHI", b"PoshitokenSui", b"Meet Poshi, a meme inspired by Yoshi and Pepe. Born from the last egg after the Super Happy Tree vanishes, Poshi embarks on a fruit-filled quest to restore his world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nwjvj1_5_400x400_7ba63e3023.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

