module 0x47ea37ad93d595d4ccbaf5cbad492c47ed69b498ee71b9bd6c2106f2defee822::txi {
    struct TXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXI>(arg0, 9, b"TXI", b"taxi", x"5468652066756e6e696573742063727970746f63757272656e6379206f6e2074686520626c6f636b2c2064657369676e656420746f20737072656164206c6175676874657220616e64206a6f79207768696c65207475726e696e67206d656d657320696e746f206469676974616c20676f6c642120f09f9884f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/632d2d3f-0f4d-4d8e-9e2f-1c1ff754f276.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

