module 0x1f9cfb336c72d5e354a4fae54e5060d04db1de50b56583d4f03361cb3ec0eee2::ksh {
    struct KSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSH>(arg0, 9, b"KSH", b"kushvaha b", b"Tradeble on all plateform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e294cc5e-b3bb-4a26-852d-e78d8b40ba6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

