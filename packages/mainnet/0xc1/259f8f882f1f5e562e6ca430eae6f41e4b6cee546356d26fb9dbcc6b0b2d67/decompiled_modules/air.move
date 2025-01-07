module 0xc1259f8f882f1f5e562e6ca430eae6f41e4b6cee546356d26fb9dbcc6b0b2d67::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR>(arg0, 6, b"AIR", b"Airdrop", b"Sui drop, no probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_nh1_03c5c40208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

