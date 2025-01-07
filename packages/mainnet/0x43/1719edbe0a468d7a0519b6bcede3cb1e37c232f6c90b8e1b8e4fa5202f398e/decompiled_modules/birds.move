module 0x431719edbe0a468d7a0519b6bcede3cb1e37c232f6c90b8e1b8e4fa5202f398e::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 9, b"BIRDS", b"Sparrow ", b"This coin is created by serve the injured birds to protect the environment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7ce4941-b084-4085-a4f3-53a92e582060.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

