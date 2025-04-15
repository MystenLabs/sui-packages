module 0x4d0b01aff4579b1c82d82042185fd0f11c5a127144928a700c63cb0477e43396::skiny {
    struct SKINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKINY>(arg0, 6, b"SKINY", b"Skiny", b"Skiny is an eccentric and clever leopard in the Sui network, with high jumps and fast steps, Skiny is able to become a leader here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058407_8124108f99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKINY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKINY>>(v1);
    }

    // decompiled from Move bytecode v6
}

