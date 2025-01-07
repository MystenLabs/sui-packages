module 0x4dd95a00651cbaffcefa885ecf553d93a0e318da831827eefac01f4bfc78c6e::aoc {
    struct AOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOC>(arg0, 6, b"AOC", b"AOC on SUI", b"This  is satire and is not affiliated to any political figure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_VJ_Qj9e_Y_400x400_ab32a4ac05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

