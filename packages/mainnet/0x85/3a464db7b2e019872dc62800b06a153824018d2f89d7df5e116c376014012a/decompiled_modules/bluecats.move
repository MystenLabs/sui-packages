module 0x853a464db7b2e019872dc62800b06a153824018d2f89d7df5e116c376014012a::bluecats {
    struct BLUECATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECATS>(arg0, 9, b"BLUECATS", b"Blue Cats", b"Blue Cats Is meme on Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844812083801845760/P3i-jFYe.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUECATS>(&mut v2, 666000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

