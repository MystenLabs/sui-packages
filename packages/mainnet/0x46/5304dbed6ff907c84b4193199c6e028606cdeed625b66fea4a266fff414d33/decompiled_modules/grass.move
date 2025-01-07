module 0x465304dbed6ff907c84b4193199c6e028606cdeed625b66fea4a266fff414d33::grass {
    struct GRASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRASS>(arg0, 9, b"GRASS", b"GRASS", b"Connecting communities through storytelling and innovation. Meme it, grow it, harvest it. Touch $GRASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1858556758844702720/XWqrLumk_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRASS>>(0x2::coin::mint<GRASS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRASS>>(v2);
    }

    // decompiled from Move bytecode v6
}

