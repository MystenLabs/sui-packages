module 0x757fa1336f8a9ce3dbed83f4c7b93763ca5f1b12bda810528f0013e3ff014739::bblb {
    struct BBLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLB>(arg0, 6, b"BBLB", b"BUBBLE BISON", b"Charging through the meme wild west, Bubble Bison is big, bold, and bouncy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_035147190_744dac40a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

