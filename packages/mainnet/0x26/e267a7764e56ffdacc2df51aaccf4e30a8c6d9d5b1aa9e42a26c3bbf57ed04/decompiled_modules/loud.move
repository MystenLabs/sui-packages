module 0x26e267a7764e56ffdacc2df51aaccf4e30a8c6d9d5b1aa9e42a26c3bbf57ed04::loud {
    struct LOUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOUD>(arg0, 6, b"Loud", b"The Loud House", b" Im Lincoln Loud  master planner, middle child, and the guy who somehow survives ten sisters worth of chaos every single day. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S6_W_On_L_Mc_400x400_19b95accde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

