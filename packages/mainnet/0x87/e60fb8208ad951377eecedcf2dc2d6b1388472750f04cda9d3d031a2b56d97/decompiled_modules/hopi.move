module 0x87e60fb8208ad951377eecedcf2dc2d6b1388472750f04cda9d3d031a2b56d97::hopi {
    struct HOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPI>(arg0, 9, b"Hopi", b"Hopium", x"5468652068696c6172696f75736c7920636c75656c65737320686970706f2077686f20616c77617973206765747320696e746f207269646963756c6f7573206a756e676c65206d6973686170732120f09fa69bf09f92ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841398487621251072/pc-TJ8nD_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPI>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

