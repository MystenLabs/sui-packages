module 0x1f5141d8e8b789eeb4070b18e248cf2bdcfa0859dadf1f8ef63042b38dc7ceea::may032023 {
    struct MAY032023 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAY032023, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAY032023>(arg0, 6, b"May032023", b"Mainnet SUI", b"Hystory: \"Were excited to share that Mainnet will officially launch on May 3, 2023!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_09_D_21_46_06_014085f168.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAY032023>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAY032023>>(v1);
    }

    // decompiled from Move bytecode v6
}

