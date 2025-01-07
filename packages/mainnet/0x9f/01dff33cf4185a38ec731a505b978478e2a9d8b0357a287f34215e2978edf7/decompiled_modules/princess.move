module 0x9f01dff33cf4185a38ec731a505b978478e2a9d8b0357a287f34215e2978edf7::princess {
    struct PRINCESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINCESS>(arg0, 9, b"princess", b"Elf Princess", b"Sui Elf Princess", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/404/826/large/daniel-moudatsos-close.jpg?1727466335")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRINCESS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINCESS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRINCESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

