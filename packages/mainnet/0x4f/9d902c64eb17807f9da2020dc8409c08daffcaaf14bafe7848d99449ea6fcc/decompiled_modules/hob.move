module 0x4f9d902c64eb17807f9da2020dc8409c08daffcaaf14bafe7848d99449ea6fcc::hob {
    struct HOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOB>(arg0, 9, b"HOB", b"Hostb", x"49e280996d206a75737420676f696e67207468726f756768206d79206f6c642062", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6dcfe47-f18a-462f-8ff8-837c5974fe02.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

