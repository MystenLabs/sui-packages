module 0x65872726a784265be0f70b103bf4f089af3458f28967e3f928bc314c84c9c5c7::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWI>(arg0, 9, b"WIWI", b"WIWI AI", b"WIWI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/399ce6bd-11a7-4c46-addd-90c792ec890d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

