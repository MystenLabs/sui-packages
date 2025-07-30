module 0xc96e45f673f51c463f2466f83ebf69c733f6f5c51c0bdd7829b93a78ec6525f5::FRIES {
    struct FRIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIES>(arg0, 6, b"McFriesCoin", b"FRIES", b"McFriesCoin is the unofficial meme coin for McDonald's lovers. Holders get 'virtual fries' rewards and exclusive access to meme-based McDonald's lore. Because why should burgers have all the fun?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/NXB40fgnJtyVBCu0iaUvHOWXchHq3TTc5Zh7no4YMi4U3fFVA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIES>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

