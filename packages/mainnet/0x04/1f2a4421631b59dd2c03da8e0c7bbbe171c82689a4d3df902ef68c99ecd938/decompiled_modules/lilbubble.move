module 0x41f2a4421631b59dd2c03da8e0c7bbbe171c82689a4d3df902ef68c99ecd938::lilbubble {
    struct LILBUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILBUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILBUBBLE>(arg0, 6, b"LILBUBBLE", b"lilbubblecoin", b"an official community memecoin launched in the name of Lil Bubble, designed to unite the community and bring vibes and prosperity to crypto. Lil Bubble is an OG crypto meme artist with millions of views on his music videos across X and Youtube and loads of IRL and digital high-fives from the biggest names in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34534_297387ed45.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILBUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILBUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

