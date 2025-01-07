module 0xa5da6db289adb51b19c4c0c47c078e3095fad501e3bb3e15fdf170d4cb3a5b31::donke {
    struct DONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKE>(arg0, 6, b"DONKE", b"DONKE on SUI", b"Donke, the carrot lovin', buck-wild degen, kickin' on SUI! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D13_Tvrjp_400x400_7031a08b09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

