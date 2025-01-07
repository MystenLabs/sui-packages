module 0xadd4ea65f9b1134dd38614bcbb6082b31c9c02dbfbe86ebfe572b9ce0c2ad14a::think {
    struct THINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THINK>(arg0, 9, b"THINK", b"Think", b"Use Your Brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2847d704-c8dd-44e6-b155-af6638594ffd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

