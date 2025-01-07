module 0x36333a969ba63a18b7f213bf29480b6156f265d5edbeb22842d5d21d50d0fc3e::mx {
    struct MX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MX>(arg0, 9, b"MX", b"Mex", b"Liquid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67126cd5-1446-4d30-beb4-29ab9e05ad58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MX>>(v1);
    }

    // decompiled from Move bytecode v6
}

