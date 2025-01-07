module 0x1730a5f9b93d5bae80efba1e34d7266e90c1e6228ef2c5717cace6ac831cbf82::sui6900 {
    struct SUI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900>(arg0, 6, b"SUI6900", b"SUI 6900", b"$SUI6900: FLIPPING THE STOCK MARKET ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af8284e70a6abf864deb123ab05c8dc_aed1ed394a_0e1299829d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

