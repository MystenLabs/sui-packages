module 0xd3e5592f6d8036ad509a33a185ecf512301ca942b19c92c27be7065313e289ea::waifu {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"WAIFU", b"MEIKO SHIRAKI", b"Meiko Shiraki ($MEIKO) is a meme coin launched on the Sui blockchain via moonbags.io, drawing inspiration from the confident and commanding anime character known for her sadistic charm and scanty outfits. This project combines the vibrant energy of anime culture with the scalability and speed of Sui Layer 1 blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieu2wubmceis3tvy2ui5lsdrvvmj4yqfk4txc2gnmg2pbackpds2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAIFU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

