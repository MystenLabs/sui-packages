module 0x947a141f824b0d4184c805615ee67338cbb9a2bd88063d472235522a4b40d42c::fishio {
    struct FISHIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHIO>(arg0, 9, b"FISHIO", x"46697368696f54686546697368f09f8ea3f09f8ea3", b"HOW MUCH IS THE FISH ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836182784945131520/9Qwyc56L_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHIO>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHIO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

