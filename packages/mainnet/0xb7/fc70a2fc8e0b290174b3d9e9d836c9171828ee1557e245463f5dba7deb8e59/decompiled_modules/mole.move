module 0xb7fc70a2fc8e0b290174b3d9e9d836c9171828ee1557e245463f5dba7deb8e59::mole {
    struct MOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLE>(arg0, 9, b"MOLE", b"Mole dot gg", b"The Top AI Co-Pilot for Molecular Research", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme59iBhTThCFi2baLXhFDst7BRGLnJrjjw9JF3DNb2L4q")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

