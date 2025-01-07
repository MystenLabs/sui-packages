module 0xb8202b09053c63c216329e0ad94836ac0d93fefb78f16a68037f5618224241c2::suidick {
    struct SUIDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDICK>(arg0, 6, b"SUIDICK", b"ADDICKTION", b"SUI ADDICKTION ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_addiction_211ad24e88.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

