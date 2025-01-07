module 0xdbb1c7f3bd78354511c8c0eec2388ed7877a33d71d5e287e2c40dc0a1bac1d92::suicubadog {
    struct SUICUBADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUBADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUBADOG>(arg0, 6, b"SUICUBADOG", b"SCUBA DOG", b"The cutest scuba diving pooch has landed on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_15_001953714_81b5f2ea18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUBADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUBADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

