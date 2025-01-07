module 0x6eca686026f8634c684547cb49704911c5134ec50f3293b7f5bd0f75383d9f71::suitoro {
    struct SUITORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORO>(arg0, 6, b"SUITORO", b"TORO on SUI", x"48455920496d20546f726f20496e6f75652c20544845204d656d6520436f696e206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uhkx_Xi_UE_400x400_0805e44f6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

