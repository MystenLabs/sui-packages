module 0xb8e9f1063eb767a66049d511e3523d5261bc686dc53491b12d8d6110d9b7c87b::njc {
    struct NJC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJC>(arg0, 9, b"NJC", b"REAY", b"VM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3ba5625-5ac4-4da7-88d9-b909efea40f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJC>>(v1);
    }

    // decompiled from Move bytecode v6
}

