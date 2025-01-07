module 0x4f7023a3ca04340ce2503ca84506f8fd5f8b3549c4bed225ffa09abf42f90b79::sui69 {
    struct SUI69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI69>(arg0, 6, b"SUI69", b"Sui69", b"Two Sui's taking care of each other's gooey's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030448_bca1708f88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI69>>(v1);
    }

    // decompiled from Move bytecode v6
}

