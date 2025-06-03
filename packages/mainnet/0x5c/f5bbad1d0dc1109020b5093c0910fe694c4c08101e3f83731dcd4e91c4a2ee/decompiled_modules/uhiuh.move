module 0x5cf5bbad1d0dc1109020b5093c0910fe694c4c08101e3f83731dcd4e91c4a2ee::uhiuh {
    struct UHIUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHIUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHIUH>(arg0, 6, b"UHIUH", b"Dont Buy (test launch next 48 hours join telegram )", b"Join telegram for ofc launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifz3wuykkraadpydzdgyvjmzlnoyjyy7y5yhvdix2tof33hnbfedy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHIUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UHIUH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

