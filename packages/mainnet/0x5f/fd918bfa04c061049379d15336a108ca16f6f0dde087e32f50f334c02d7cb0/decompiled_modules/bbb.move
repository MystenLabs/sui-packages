module 0x5ffd918bfa04c061049379d15336a108ca16f6f0dde087e32f50f334c02d7cb0::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 9, b"bbb", b"bbb", b"bbbbb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH3t_bS8mNcYHIna9HbERQSOujwQ7i8jQXcQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBB>(&mut v2, 111111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

