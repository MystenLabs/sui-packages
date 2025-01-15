module 0xca1c314b2616ef9dfbcfa2ab31cffae21a9aeca9a3db615ef2a8d3d369623a07::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORO>(arg0, 9, b"TORO", b"Toro", b"Unleash the power of Toro, the Charging Bull. A symbol of unstoppable momentum, resilience, and community-driven growth in the world of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcdfMy6QpizihsWtnBnWMkwengFMah5wKhFGMFMHU3R2M")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TORO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

