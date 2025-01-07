module 0x5adca0b68b01a23498c0a786c16383ad87256b2b23bc96ec7cb15bd7fe4999f5::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 9, b"BUBL", b"BUBL", b"Bubbling on Sui  to make frens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838565175026171904/JKmSPN8W_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

