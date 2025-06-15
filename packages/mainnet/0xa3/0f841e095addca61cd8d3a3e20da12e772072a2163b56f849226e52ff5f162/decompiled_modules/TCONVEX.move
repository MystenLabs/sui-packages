module 0xa30f841e095addca61cd8d3a3e20da12e772072a2163b56f849226e52ff5f162::TCONVEX {
    struct TCONVEX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TCONVEX>, arg1: 0x2::coin::Coin<TCONVEX>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<TCONVEX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TCONVEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TCONVEX>>(0x2::coin::mint<TCONVEX>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<TCONVEX>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TCONVEX>>(arg0);
    }

    fun init(arg0: TCONVEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCONVEX>(arg0, 9, b"TCONVEX", b"Test CONVEX", b"Test Convex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cheery-rhinoceros-823.convex.cloud/api/storage/421670d1-5ced-4605-bc90-fd98d36f3402")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCONVEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCONVEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

