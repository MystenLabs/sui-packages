module 0x100201b82e8843314ffdac63e320b7a956636a5bf37acad571b9dce9f4146d18::rope {
    struct ROPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROPE>(arg0, 6, b"Rope", b"Rope Coin", b"Idk.. might help with todays market. Time for a rope cult? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1789_6ea0eb2e2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

