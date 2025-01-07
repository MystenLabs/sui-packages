module 0x9af3d6facdfc198b361a446f4c9995eca4f5e426ee9be84cbf1a88225d0b9502::tony {
    struct TONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONY>(arg0, 9, b"TONY", b"Tony dog", b"Tony doggy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8f46f1d-52c4-414b-b343-990f3b43a890.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

