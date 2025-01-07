module 0xd392364c745a71d3e670a30b52acd007093a6876329ae4925829e897cf6dbe6e::suik {
    struct SUIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIK>(arg0, 9, b"SUIK", b"SuiWukong", b"I m elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1832400978512859136/3sgG8IrR_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIK>(&mut v2, 30000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

