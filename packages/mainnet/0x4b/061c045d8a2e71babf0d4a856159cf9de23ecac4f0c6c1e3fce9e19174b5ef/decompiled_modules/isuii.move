module 0x4b061c045d8a2e71babf0d4a856159cf9de23ecac4f0c6c1e3fce9e19174b5ef::isuii {
    struct ISUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUII>(arg0, 6, b"ISUII", b"ISUI", b"ISUII SUI CAT BLOCKCHAIN WHITE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cute_Cat_1_step_09_804103161_048aeb1634.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

