module 0xfc3340fb83fe5b3388ba81c090ddef11e30328258059a0dc7957a3bbb18854ac::lola {
    struct LOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLA>(arg0, 9, b"LOLA", b"Lola Cat", b"LOLA is a beloved cat by Matt Furie. The most impressive character of his comic editions! She loves to purr and sharpen her claws on jeets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841531116546883584/5sJJ-QMY_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOLA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

