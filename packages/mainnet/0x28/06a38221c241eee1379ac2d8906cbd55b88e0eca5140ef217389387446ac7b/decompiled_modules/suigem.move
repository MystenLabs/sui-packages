module 0x2806a38221c241eee1379ac2d8906cbd55b88e0eca5140ef217389387446ac7b::suigem {
    struct SUIGEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGEM>(arg0, 6, b"SUIGEM", b"Sui Gem", b"The hidden treasure of the Sui network, waiting to be discovered. It's rare, it's powerful, and only a few will truly recognize its value. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_470d282f07.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

