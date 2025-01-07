module 0x83f4cca7b98ff3007e536ccd23f0188c55e1aa7680b9cdc898833c0b716c2189::fxc {
    struct FXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FXC>(arg0, 9, b"FXC", b"FOXCOIN", b"Little cold fox", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1491f930-fb39-4462-bbcf-b3ba90f541e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

