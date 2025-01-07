module 0x43768628e58cc2524122c4fe6457e2a8802db40bddb3b549ca0d4ad88cf79a09::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 9, b"SuiDoge", b"Sui Doge", b"Sui Doge is a meme token on the Sui blockchain, inspired by the Doge meme character. It offers a fun, community-driven experience with fast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843648011429425152/8w42EBoX.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDOGE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

