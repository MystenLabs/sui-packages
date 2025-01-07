module 0x9a148031e05141565e33f7bd527e8dee2182cb83a7006f53de5e186b75e051f9::mft {
    struct MFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFT>(arg0, 9, b"MFT", b"MIFTAKYA", b"sempak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c25021d-5298-4a7a-88a3-0fa0643b4c64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

