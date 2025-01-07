module 0x1ad57202e25c454bb60dae2f26dc1696e9eb2f67aad5f437702ee4be7410aa1f::spook {
    struct SPOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOK>(arg0, 6, b"SPOOK", b"Spooky on sui", x"47686f7374732061726520636f6d696e6720746f2024535549200a0a4c65747320676574202453504f4f4b6564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_ghost_main_b82d694cd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

