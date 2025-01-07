module 0xf4153134e2731ec5fc8ccb2e04eb7eaaba61e7bf38809727966346f946830311::reply {
    struct REPLY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REPLY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REPLY>>(0x2::coin::mint<REPLY>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: REPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPLY>(arg0, 9, b"REPLY", b"REPLY", b"Reply token is a meme responding to all those which we missed, a community based, driven and managed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1864350190133460992/6zZHqlV__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REPLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REPLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPLY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

