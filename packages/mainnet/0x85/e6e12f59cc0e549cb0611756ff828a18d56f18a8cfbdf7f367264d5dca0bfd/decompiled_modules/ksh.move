module 0x85e6e12f59cc0e549cb0611756ff828a18d56f18a8cfbdf7f367264d5dca0bfd::ksh {
    struct KSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSH>(arg0, 9, b"KSH", b"kushvaha b", b"Tradeble on all plateform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d587cd0-33fc-4259-9b5d-0f38f5876343.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

