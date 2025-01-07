module 0xffbb2b2c915956366c93655550aa5767d81760fec67f58e39981b2e7bc23b091::faster {
    struct FASTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASTER>(arg0, 1, b"FASTER", b"FASTER", b"MORE MORE MORE MORE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FASTER>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FASTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

