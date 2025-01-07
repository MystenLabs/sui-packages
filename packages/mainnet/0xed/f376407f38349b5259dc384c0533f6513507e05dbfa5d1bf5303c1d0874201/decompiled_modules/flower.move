module 0xedf376407f38349b5259dc384c0533f6513507e05dbfa5d1bf5303c1d0874201::flower {
    struct FLOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWER>(arg0, 9, b"Flower", x"466c6f77657220f09f8c86", b"A Flower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiW58kzOcIrFufj5w7lEzXtr-Z3pTohJBTsA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOWER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

