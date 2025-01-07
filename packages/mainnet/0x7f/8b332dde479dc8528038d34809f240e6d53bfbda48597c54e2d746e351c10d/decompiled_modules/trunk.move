module 0x7f8b332dde479dc8528038d34809f240e6d53bfbda48597c54e2d746e351c10d::trunk {
    struct TRUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUNK>(arg0, 6, b"Trunk", b"Elephant money", b"ELEPHANT.MONEY is the first global decentralized community bank of its kind. It is a permissionless system that accumulates wealth through stable coin backed deflationary assets and yield.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4839_13916ee4b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

