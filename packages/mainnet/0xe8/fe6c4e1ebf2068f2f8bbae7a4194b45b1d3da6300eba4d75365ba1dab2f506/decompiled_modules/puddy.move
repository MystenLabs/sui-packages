module 0xe8fe6c4e1ebf2068f2f8bbae7a4194b45b1d3da6300eba4d75365ba1dab2f506::puddy {
    struct PUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDY>(arg0, 6, b"PUDDY", b"YUMMY PUDDY", b"DESSERT IS SERVED, WOBBLE AND GOBBLE $PUDDY!! WE ARE ALL ABOUT GOOD VIBES, FUN MEMES AND MAKING PUDDY SOMETHING SPECIAL HERE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/abba_e1aad2898e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

