module 0xc3f9b390e34d0c830ae1150adceccc2a141035959fa107678c6d15733f133431::wowdog {
    struct WOWDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWDOG>(arg0, 6, b"WOWDOG", b"WOWDOG ON SUI", b"WOWDOG on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WOWDOG_969b78b119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOWDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

