module 0xe63acf4942634c6d7748d0498773376cbbf2c89375fff602365bce8b09b7c258::zs {
    struct ZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZS>(arg0, 9, b"ZS", b"$ZEUS", x"536f6f6e2077652077696c6c206c61756e636820746865206e657765737420636f696e20746861742077696c6c207368616b652074686520776f726c64207769746820697473206c696768746e696e672c206c6f6f6b20666f727761726420746f20697420736f6f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/787ae855-80b3-4890-bb3a-5156a0063d81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZS>>(v1);
    }

    // decompiled from Move bytecode v6
}

