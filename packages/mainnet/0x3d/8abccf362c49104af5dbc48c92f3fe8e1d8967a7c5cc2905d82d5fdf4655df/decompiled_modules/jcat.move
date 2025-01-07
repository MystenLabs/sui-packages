module 0x3d8abccf362c49104af5dbc48c92f3fe8e1d8967a7c5cc2905d82d5fdf4655df::jcat {
    struct JCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JCAT>(arg0, 6, b"JCAT", b"Stimpson J. Cat", b"Simpson J. Cat is a clever feline with a knack for getting into and out of tricky situations, all while maintaining a cool, laid-back demeanor. His curious nature often leads him on unexpected adventures, but he always lands on his feet, ready for whatever comes next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_7160f73e0d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

