module 0x8354ff3f4c8b195d41f5fbf1e5cc32f5c29cc1caac2e4c4dc3f80f12d1c2d0c9::phfrog {
    struct PHFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHFROG>(arg0, 6, b"PHFROG", b"Pink Hood Froglicker", b"SOMETIMES THIS ADORABLE FROG THEY CALLED IT PEPE'S SON.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FROG_8e5f15c9f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

