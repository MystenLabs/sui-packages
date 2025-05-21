module 0xf2b87ecbed436096e5c795aa9adcc02b3acfdfc22bfc0857cf39cdb9f0708f95::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 9, b"dawgcoin", b"dawg", b"dawg coin is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3417c434-e9b1-40d8-8215-6c0a0e3d2fee.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

