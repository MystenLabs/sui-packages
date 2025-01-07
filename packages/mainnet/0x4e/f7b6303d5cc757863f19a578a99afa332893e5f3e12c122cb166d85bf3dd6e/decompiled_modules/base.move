module 0x4ef7b6303d5cc757863f19a578a99afa332893e5f3e12c122cb166d85bf3dd6e::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE>(arg0, 6, b"BASE", b"CONBASE on SUI", x"546865206d6f737420617761697465642061697264726f70207468697320736561736f6e206973206865726521200a0a4e4f542041205343414d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zrzut_ekranu_2024_10_11_163436_3c26e29f37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASE>>(v1);
    }

    // decompiled from Move bytecode v6
}

