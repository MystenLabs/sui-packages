module 0x341ebed084ca1a0c4888ba8f4a143bd867684f8de283dbd39fc95c74406eb6a6::bluxi {
    struct BLUXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUXI>(arg0, 6, b"BLUXI", b"BLUXI CTO", b" I GONNA CREATE A TG AND A STICKERS SET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUX_c990e75d9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

