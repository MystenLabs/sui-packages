module 0x30181540aaa7ba51da4896819c6035c50c330d346212b2063b581f3a450950d0::tiny_titan_token {
    struct TINY_TITAN_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TINY_TITAN_TOKEN>, arg1: 0x2::coin::Coin<TINY_TITAN_TOKEN>) {
        0x2::coin::burn<TINY_TITAN_TOKEN>(arg0, arg1);
    }

    fun init(arg0: TINY_TITAN_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINY_TITAN_TOKEN>(arg0, 9, b"TTT", b"Tiny Titan Token", b"Tiny Titan Token is the ultimate meme token, forged in the heart of the mantis shrimp's unstoppable spirit. Harnessing the power of the most formidable predator in the ocean, Tiny Titan Token is poised to revolutionize the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GZ4Lq5oWkAATyys?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINY_TITAN_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINY_TITAN_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TINY_TITAN_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TINY_TITAN_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

