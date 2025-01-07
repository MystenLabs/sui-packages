module 0x60ac1593509b1ade4d733f67014c4b8abf11c773a05fb960f33fcf67abaa9d20::pepeelf {
    struct PEPEELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEELF>(arg0, 6, b"PepeElf", b"PEPE ELF", b"On the other side of the mountain, across the sea, lived a group of Pepe elves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Pd_Ppz_ZK_400x400_056113f64d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

