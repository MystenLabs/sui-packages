module 0xe8e5a9535c9497acdb6ff1c1c3aed3c591ec3aca232cd38495267665f7e58db2::suikull {
    struct SUIKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKULL>(arg0, 9, b"SUIKULL", b"Sui skull girl", b"The girl on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/038/316/310/large/hugo-lucas-skullgirl-01.jpg?1622745484")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIKULL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

