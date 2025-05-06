module 0x30307f65ec8d89d5bfab10326effdea25de328c009b867ceec701050f4e51caf::ramid {
    struct RAMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMID>(arg0, 6, b"Ramid", b"Yramid", b"Join the $RAMID movement, Blue means resistance but still relaxed, that's the spirit shown by $RAMID", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiet4ljtrvruj5shu6dqpxqi25rms4wfnxq3nywhp4rrggpkl3ftdi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAMID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

