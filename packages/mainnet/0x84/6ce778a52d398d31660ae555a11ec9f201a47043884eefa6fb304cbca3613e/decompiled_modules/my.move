module 0x846ce778a52d398d31660ae555a11ec9f201a47043884eefa6fb304cbca3613e::my {
    struct MY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY>(arg0, 9, b"MY", b"maser", b"Master Yi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/808c3edb-21a0-4327-84a0-c27cba7bb5b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY>>(v1);
    }

    // decompiled from Move bytecode v6
}

