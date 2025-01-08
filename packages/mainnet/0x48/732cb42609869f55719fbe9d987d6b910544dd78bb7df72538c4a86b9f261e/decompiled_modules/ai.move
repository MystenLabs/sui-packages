module 0x48732cb42609869f55719fbe9d987d6b910544dd78bb7df72538c4a86b9f261e::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 9, b"AI", b"My Life AI", b"My life by AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffe6dcfb-1720-46f9-8381-43d2ab5cbad2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI>>(v1);
    }

    // decompiled from Move bytecode v6
}

