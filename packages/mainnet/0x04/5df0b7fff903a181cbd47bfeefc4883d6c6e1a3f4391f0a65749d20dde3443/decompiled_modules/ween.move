module 0x45df0b7fff903a181cbd47bfeefc4883d6c6e1a3f4391f0a65749d20dde3443::ween {
    struct WEEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WEEN>>(0x2::coin::mint<WEEN>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: WEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEN>(arg0, 9, b"WEEN", b"WEEN", b"WEEN the Ai girl autonomous a sweetheart, but yet a tough blue chick going into amazing ammount of data giving you real Alpha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1437210953867673602/4HpOtbfK_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

