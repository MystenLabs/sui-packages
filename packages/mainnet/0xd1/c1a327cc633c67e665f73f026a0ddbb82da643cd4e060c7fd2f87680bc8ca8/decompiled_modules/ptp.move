module 0xd1c1a327cc633c67e665f73f026a0ddbb82da643cd4e060c7fd2f87680bc8ca8::ptp {
    struct PTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTP>(arg0, 9, b"PTP", b"P2P", b"Person to Person", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PTP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

