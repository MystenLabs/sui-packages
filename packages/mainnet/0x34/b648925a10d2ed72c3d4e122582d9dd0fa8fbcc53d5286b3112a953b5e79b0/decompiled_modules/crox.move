module 0x34b648925a10d2ed72c3d4e122582d9dd0fa8fbcc53d5286b3112a953b5e79b0::crox {
    struct CROX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROX>(arg0, 6, b"CROX", b"Crox", b"Legend has it that deep in the meme-verse swamps, a group of mischievous crocodiles got tired of seeing PEPE rule the roost.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crox_d700632cb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROX>>(v1);
    }

    // decompiled from Move bytecode v6
}

