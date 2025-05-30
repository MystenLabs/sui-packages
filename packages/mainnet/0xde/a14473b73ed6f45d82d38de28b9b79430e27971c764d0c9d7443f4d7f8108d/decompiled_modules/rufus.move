module 0xdea14473b73ed6f45d82d38de28b9b79430e27971c764d0c9d7443f4d7f8108d::rufus {
    struct RUFUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFUS>(arg0, 6, b"RUFUS", b"RUFUS the GOAT", b"The goat himself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidn4v4l2bgvh3w4scxk2fp7jyt32wvkqm4nyqohc2reqitynxutbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUFUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

