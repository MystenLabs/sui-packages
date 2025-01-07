module 0xf393fbbaee317f62009327611317c407c25a4ca0fe0e37b1d9c681e66e26919::dong {
    struct DONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONG>(arg0, 9, b"DONG", x"c490e1bb924e4720", x"f09faa99204920616d206e6f74206f6e6c7920c490e1bb936e672c2049e280996d2062757420616c736f2024c4902e2049e280996d20667574757265206f6620444f4e472e20312c3030302c3030302c3030302024c490206f66206d652077696c6c206265206f776e656420627920312c3030302c3030302c3030302070617469656e742070656f706c6520756e74696c20325858322e204920616d2047656e6573697320616e6420746865204669727374206f6620444f4e472e20486f6c64206d65206e6f7720f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86a7db6e-6375-473b-9bda-2dbf7136ddc3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

