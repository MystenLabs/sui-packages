module 0xd2015ac817f02ed74eedf3aaa37b8a3e6623d72d9cdd76c609f3b9fd8de3d6da::moonbarak {
    struct MOONBARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBARAK>(arg0, 6, b"MOONBARAK", b"Moonbarak CTO", b"The Richest King on SUI, ready to moon from Dubai to the stars!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicsaiyfasopsxdiyu7dtmvjdxle6amr3ascbygkjhtixnm66c6uki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONBARAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

