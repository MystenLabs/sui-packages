module 0x1015beaf458dd175b7d2c83b21ea7b372baf4f5158b0c6d3bba8db9468cb0502::suifellas {
    struct SUIFELLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFELLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFELLAS>(arg0, 6, b"SUIFELLAS", b"SuiFellas", b"Dive into the world of SUIFELLAS! This meme coin project combines the power of SUI with the camaraderie of the coolest crypto crew. Join our community for blockchain banter, crypto capers, and a unique blend of finance and fun. Embrace the fast transactions and faster laughs with Solanafellas, where every coin is a ticket to the future and every moment is a ride with the ultimate gang!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Fellas2_9bf7db9e14.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFELLAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFELLAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

