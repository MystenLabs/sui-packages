module 0x8af2c622e9275c27579a80768b3c7dfedf805f4c59c6fb95b657cf2607bfa9d2::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 9, b"ROCK", b"ROCK", b"Majestic lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/AKGbbjKfKEc/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AGoCYAC0AWKAgwIABABGGUgZShlMA8=&amp;rs=AOn4CLBSjUTQraYkZ1Ujos3j3APXZaHAhQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROCK>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

