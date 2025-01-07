module 0xb7b9fdc0f1f08fa7ece9be92243074200d3e25552e74fec7a6466f43a9b878d::eva {
    struct EVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVA>(arg0, 9, b"EVA", b"EVA", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDNcHDk07OpXCO1Q1PhusMhnZTRBflChuAaw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

