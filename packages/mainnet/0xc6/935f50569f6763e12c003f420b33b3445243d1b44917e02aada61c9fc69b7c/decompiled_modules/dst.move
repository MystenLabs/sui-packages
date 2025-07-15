module 0xc6935f50569f6763e12c003f420b33b3445243d1b44917e02aada61c9fc69b7c::dst {
    struct DST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DST>(arg0, 6, b"DST", b"Desteny", b"Its your desteny!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidr67nid7irr5gew24sc6q3agvuwsqgne27nsymxqwmk7npp7uvpm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

