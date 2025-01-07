module 0xd606b66ecd838a55303ad8726c8fa7f25de8a7f87f749e2fd2a5992d39107b3c::magikarp {
    struct MAGIKARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIKARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIKARP>(arg0, 9, b"magikarp", b"Makigarkp", b"Pokemonking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM7r-7-SebKcDBWJO88MpNl-V_DWxmdGjYgeTi1X7u4P07QR0LojIOaiWSh03iNKUjUJ4&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGIKARP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIKARP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIKARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

