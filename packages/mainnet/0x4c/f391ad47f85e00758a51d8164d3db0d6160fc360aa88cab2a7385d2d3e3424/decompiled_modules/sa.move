module 0x4cf391ad47f85e00758a51d8164d3db0d6160fc360aa88cab2a7385d2d3e3424::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 9, b"SA", b"HGJ", b"DF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7000e64a-1d0c-4212-b36d-e2c767d80ba8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA>>(v1);
    }

    // decompiled from Move bytecode v6
}

