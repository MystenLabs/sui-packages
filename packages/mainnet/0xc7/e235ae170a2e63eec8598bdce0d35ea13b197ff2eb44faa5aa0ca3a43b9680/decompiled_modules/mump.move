module 0xc7e235ae170a2e63eec8598bdce0d35ea13b197ff2eb44faa5aa0ca3a43b9680::mump {
    struct MUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMP>(arg0, 6, b"MUMP", b"dONALd tRUMp eLOn mUSk aka MUMP", b"tRUMp & mUSk TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_16_160800_a6a1be9d1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

