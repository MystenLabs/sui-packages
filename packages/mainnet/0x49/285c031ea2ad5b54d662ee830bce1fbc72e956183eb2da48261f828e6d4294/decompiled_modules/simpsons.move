module 0x49285c031ea2ad5b54d662ee830bce1fbc72e956183eb2da48261f828e6d4294::simpsons {
    struct SIMPSONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPSONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSONS>(arg0, 9, b"SIMPSONS", b"Sui Simpsons", b"Simpsons Is meme Famous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845821285349421056/CqLqr-39.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMPSONS>(&mut v2, 455000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSONS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPSONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

