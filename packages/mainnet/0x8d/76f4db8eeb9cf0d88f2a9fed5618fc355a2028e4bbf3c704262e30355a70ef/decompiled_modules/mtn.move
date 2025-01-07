module 0x8d76f4db8eeb9cf0d88f2a9fed5618fc355a2028e4bbf3c704262e30355a70ef::mtn {
    struct MTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTN>(arg0, 9, b"MTN", b"Irancell", b"MTN irancell gozo gozo hast.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0462a6d5-8b46-4039-95ef-ed691f883dd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

