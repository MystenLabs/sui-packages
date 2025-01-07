module 0x68ca1df5158287d45ba8fb7e35e293f5e27cf1a9fc2491d255d03a3b313a89a8::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 9, b"SB", b"SuiRonaldo", x"492077696c6c2062652067726561746572207468616e206d792066617468657220535549202620524f4e414c444f20e29c85", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b28e66d0-989d-44d6-af3c-f01b0eaa0289.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

