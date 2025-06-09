module 0xccda60754f83b436e27212020c33a96f2c22d9cdd2ce1e05dd6f163259df2590::pol_pol {
    struct POL_POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL_POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL_POL>(arg0, 9, b"pol", b"pol pol", b"polly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/813cf00f-5d46-4a72-872c-0670f68ca5c1.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POL_POL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL_POL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

