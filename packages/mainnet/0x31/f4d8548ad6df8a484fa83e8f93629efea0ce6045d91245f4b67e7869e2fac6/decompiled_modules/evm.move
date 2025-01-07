module 0x31f4d8548ad6df8a484fa83e8f93629efea0ce6045d91245f4b67e7869e2fac6::evm {
    struct EVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVM>(arg0, 9, b"EVM", b"Everymatte", b"Public  token from everymatte.com ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/462bfe65-09f1-46f9-a158-62566c69bc56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVM>>(v1);
    }

    // decompiled from Move bytecode v6
}

