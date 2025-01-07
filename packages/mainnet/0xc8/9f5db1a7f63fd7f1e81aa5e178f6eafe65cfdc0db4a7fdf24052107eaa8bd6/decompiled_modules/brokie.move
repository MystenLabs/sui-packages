module 0xc89f5db1a7f63fd7f1e81aa5e178f6eafe65cfdc0db4a7fdf24052107eaa8bd6::brokie {
    struct BROKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKIE>(arg0, 6, b"BROKIE", b"Brokie Sui", b"Brokie on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_12_36_47_5fd403e594.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

