module 0x5ebfc2442dc3d49a4afd9ef6cba865aaaa8e3c85c06b8e50a6e71317541915a8::nelly {
    struct NELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELLY>(arg0, 6, b"NELLY", b"NellyOnSui", b"$NELLY The robot hamster on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_083606_5e00364a40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

