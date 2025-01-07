module 0xe2af5287a683f8cfe4474f2d3fb7ecdcd04adedadb59cd53a0afea37e103084e::guppy {
    struct GUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUPPY>(arg0, 6, b"Guppy", b"Guppy Sui", b"Luckiest Fish On Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_The_Sui_Guppy_is_a_sleek_blueandwhite_fish_sy_3_c78fd138f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

