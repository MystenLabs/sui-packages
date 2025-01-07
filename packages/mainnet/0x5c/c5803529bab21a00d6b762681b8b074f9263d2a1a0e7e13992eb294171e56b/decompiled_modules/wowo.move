module 0x5cc5803529bab21a00d6b762681b8b074f9263d2a1a0e7e13992eb294171e56b::wowo {
    struct WOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWO>(arg0, 9, b"WOWO", b"WOWO MEMES", b"Memes of Wowo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e2a2941-2af6-4e84-b230-a2e9e4e7c672.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

