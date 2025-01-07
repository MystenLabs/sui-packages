module 0x1db45e999e63d527db4c3c46c1ef9557f9b620d731535c0de3575691affbd436::miacat {
    struct MIACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIACAT>(arg0, 9, b"MIACAT", b"MiaCat", b"Sui Mia Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844365125005856772/VhP5G8nA_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIACAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIACAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

