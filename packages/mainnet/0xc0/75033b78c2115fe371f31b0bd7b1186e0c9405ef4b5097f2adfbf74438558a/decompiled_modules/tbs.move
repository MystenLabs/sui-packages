module 0xc075033b78c2115fe371f31b0bd7b1186e0c9405ef4b5097f2adfbf74438558a::tbs {
    struct TBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBS>(arg0, 9, b"TBS", b"Tobas", b"Gamefi with full potential ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce354a38-d74c-41e0-bbd0-8df61a8d5288.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

