module 0x668069609f02a35f81ffb0435122848eba727356666ffe398d3abbeaf86b15cd::unknown {
    struct UNKNOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNKNOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNKNOWN>(arg0, 9, b"UNKNOWN", b"Unknown", b"Unknown's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e5c9c32-1417-40d2-a64a-92536ce39806.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNKNOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNKNOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

