module 0x9d8a50716d2bd5b70d970fb91274efae06a2a896a2242a96bd9ccec3354e9a8e::pinata {
    struct PINATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINATA>(arg0, 9, b"PINATA", x"5069c3b16174614f6e537569", b"https://x.com/PinataBotOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1783116097245614080/26TmHqvJ_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINATA>(&mut v2, 8888888888000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINATA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

