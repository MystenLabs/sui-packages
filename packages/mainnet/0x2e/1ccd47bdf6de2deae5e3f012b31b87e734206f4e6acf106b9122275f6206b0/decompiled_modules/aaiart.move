module 0x2e1ccd47bdf6de2deae5e3f012b31b87e734206f4e6acf106b9122275f6206b0::aaiart {
    struct AAIART has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AAIART>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AAIART>>(0x2::coin::mint<AAIART>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: AAIART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAIART>(arg0, 9, b"AAAAI", b"AAIART", b"AiArtAgent is the agent solely deploying a master images via Ai tools, no code, user friendly and low fee platform to make images for every taste.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1818181938982854656/IUj4iPh4_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAIART>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAIART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAIART>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

