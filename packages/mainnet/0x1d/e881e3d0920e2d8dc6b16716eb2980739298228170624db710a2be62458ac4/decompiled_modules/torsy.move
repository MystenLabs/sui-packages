module 0x1de881e3d0920e2d8dc6b16716eb2980739298228170624db710a2be62458ac4::torsy {
    struct TORSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORSY>(arg0, 6, b"TORSY", b"TORSY TORSY", b"Torsy Meme Token is a community-driven cryptocurrency that merges the playful and viral nature of meme culture with practical blockchain functionality. Built on the high-performance Solana blockchain, Torsy aims to provide fast, low-cost transactions, making it not just a fun token to hold but also practical for everyday use. The token is designed to engage its community with regular contests, meme creation events, and interactive social media campaigns, fostering a vibrant and active ecosystem. This token strategy aims to leverage the intrinsic fun and community engagement of meme culture while providing real, tangible value to its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c6jy1_Eh8_400x400_da62494d91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

