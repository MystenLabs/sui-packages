module 0xa8286a3801d5a26606b3ca290f1750f1af148e4e504dfba579038887cfc53bcd::butter {
    struct BUTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTER>(arg0, 9, b"Butter", b"Sui Butterfly", b"Butterfly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGKzfRT7F3a_uvHsQdrak4LFz_ra7WhA7TDa85XXfQ1gQXjNcXtKzwei8iBt8nnzGhKm037OIaY0Trec4CKBuF1BCcamr2vnBWaunpfRNDBQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUTTER>(&mut v2, 9999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

