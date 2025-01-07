module 0x4b7fb101a9d516db3bfbe46cfaf614029baa6bfe89909059caffd1735af810ce::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"SUI_FISH", b"A Fish in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240912_182539_b88d4c7340.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

