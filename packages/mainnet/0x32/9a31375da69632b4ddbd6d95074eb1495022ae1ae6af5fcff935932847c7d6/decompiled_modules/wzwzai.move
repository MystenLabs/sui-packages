module 0x329a31375da69632b4ddbd6d95074eb1495022ae1ae6af5fcff935932847c7d6::wzwzai {
    struct WZWZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WZWZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WZWZAI>(arg0, 9, b"WZWZAI", b"WZWZ", b"WZWZAI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab13c976-2fac-4402-909f-c18f56978d82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WZWZAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WZWZAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

