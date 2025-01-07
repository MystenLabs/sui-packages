module 0x4af060d313f20b45e1e4a0af229fa8553333b1c0665f3a328b7bec6a2de0b9fe::rlf {
    struct RLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLF>(arg0, 6, b"RLF", b"Rainy lune forg", b"Forg puppets my beloved ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eaca45aed342e0f4803056231a759dd1_aa93ddc023.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

