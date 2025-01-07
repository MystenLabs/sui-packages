module 0xd310d67352d4e6a62b4a40f32070b7e878e5cb0b4c1fa47fceb23d3a6c200c77::flowy {
    struct FLOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWY>(arg0, 9, b"Flowy", b"Flowsuito", b"The flow finance meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1426562705784295429/t6TjPtii_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOWY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

