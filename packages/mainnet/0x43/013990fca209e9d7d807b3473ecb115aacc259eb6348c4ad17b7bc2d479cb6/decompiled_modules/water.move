module 0x43013990fca209e9d7d807b3473ecb115aacc259eb6348c4ad17b7bc2d479cb6::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 9, b"WATER", b"Sui Water", b"Sui Water Meme LFG Sui Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1531094529520152576/9x3l15-j_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WATER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

