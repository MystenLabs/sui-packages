module 0x3431fa976dbf399e4a785eded86e93c5a152d12288df640450cd7937734936fb::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"Rug pull", b"Donnot buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_2024_09_16_21_22_13_13c14d22d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

