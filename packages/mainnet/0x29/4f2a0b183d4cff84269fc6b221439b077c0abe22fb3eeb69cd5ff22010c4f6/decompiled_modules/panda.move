module 0x294f2a0b183d4cff84269fc6b221439b077c0abe22fb3eeb69cd5ff22010c4f6::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 9, b"PANDA", b"Sui Panda", b"The first panda meme token of the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1830542886473240576/vctYSY5w_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PANDA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

