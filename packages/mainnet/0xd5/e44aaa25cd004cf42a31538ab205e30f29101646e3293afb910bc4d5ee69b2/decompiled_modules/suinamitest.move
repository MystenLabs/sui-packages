module 0xd5e44aaa25cd004cf42a31538ab205e30f29101646e3293afb910bc4d5ee69b2::suinamitest {
    struct SUINAMITEST has drop {
        field: bool,
    }

    struct SUIMAN has drop {
        dummy_field: bool,
    }

    public fun initialize(arg0: SUINAMITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMITEST>(arg0, 6, b"suiman", b"Suiman", b"Suiman is a meme token on the Sui, combining the fun of superhero vibes with the power of the Sui blockchain. Powered by the community, it's a lighthearted tribute to crypto culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/4Ff8v5f/ava.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINAMITEST>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMITEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAMITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

