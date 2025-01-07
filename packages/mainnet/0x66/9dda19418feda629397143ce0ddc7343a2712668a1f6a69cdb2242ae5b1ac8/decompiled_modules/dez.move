module 0x669dda19418feda629397143ce0ddc7343a2712668a1f6a69cdb2242ae5b1ac8::dez {
    struct DEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEZ>(arg0, 9, b"DEZ", b"DEXZONE", b"New CRYPTO AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEZ>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

