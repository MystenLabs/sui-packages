module 0x461d260539d4a0b95e065606289577c21ffbd98f3d2f908ab9efdd9d89876deb::kaeru {
    struct KAERU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAERU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAERU>(arg0, 6, b"KAERU", b"Kaeru Relaunch", b"You have entered the realm of Kaeru born of rain, risen by grit. This is not just a project. It is a path. A movement for those who train in silence, strike with purpose, and believe when no one else does.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhr2wierk4vi26to7egl6l52gs2ouko25z3ixbxvdmzfhipsq5we")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAERU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAERU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

