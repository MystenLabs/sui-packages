module 0x6e2ccf987f7dd92fe88a3c648f8a68e101e7e4d55942cd064362f959ed7407f7::amsh {
    struct AMSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMSH>(arg0, 9, b"AMSH", b"Amsha", b"Symbol for love and Compassion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/601ad760-edf9-40ea-b38b-bbc64579d68b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

