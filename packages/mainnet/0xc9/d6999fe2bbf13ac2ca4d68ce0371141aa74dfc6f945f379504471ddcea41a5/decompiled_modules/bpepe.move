module 0xc9d6999fe2bbf13ac2ca4d68ce0371141aa74dfc6f945f379504471ddcea41a5::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 9, b"BPEPE", b"Black Pepe", b"Black Pepe token on the Sui blockchain is a meme-inspired cryptocurrency that leverages Sui's fast, low-cost transactions. Focused on community engagement and viral appeal, it aims to capture the spirit of meme culture within the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823343670969634816/4BLWM4Xh.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BPEPE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

