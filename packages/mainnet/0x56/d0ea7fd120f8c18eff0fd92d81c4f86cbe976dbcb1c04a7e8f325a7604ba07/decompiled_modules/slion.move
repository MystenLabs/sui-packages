module 0x56d0ea7fd120f8c18eff0fd92d81c4f86cbe976dbcb1c04a7e8f325a7604ba07::slion {
    struct SLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLION>(arg0, 6, b"SLION", b"SUILION", b"Colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-protestant-falcon-171.mypinata.cloud/ipfs/QmRX29qNxA4XgiqQV7V54tATTwsyy3gmM2LYRgJ9jGZJJz")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SLION>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLION>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLION>>(v1);
    }

    // decompiled from Move bytecode v6
}

