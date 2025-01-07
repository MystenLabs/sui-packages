module 0x1746238233cd87f0ed17b04dc4bb9c3b815bf45a7343df98054ef8f8b78c3870::shepherd {
    struct SHEPHERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEPHERD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEPHERD>(arg0, 6, b"SHEPHERD", b"The Shepherd", x"205468652053686570686572642c20616e6420492068617665206120647265616d20746f20756e69746520657665727920446567656e2066726f6d20616c6c20636f726e657273206f66207468652045617274682e0a0a446563656e7472616c697a6174696f6e21212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_013529_439_9eff01a2c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEPHERD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEPHERD>>(v1);
    }

    // decompiled from Move bytecode v6
}

