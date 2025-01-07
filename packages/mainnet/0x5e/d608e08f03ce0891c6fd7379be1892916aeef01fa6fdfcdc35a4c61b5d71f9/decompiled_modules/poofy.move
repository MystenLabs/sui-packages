module 0x5ed608e08f03ce0891c6fd7379be1892916aeef01fa6fdfcdc35a4c61b5d71f9::poofy {
    struct POOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOFY>(arg0, 9, b"POOFY", b"POOFY", b"puff that shit to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOFY>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

