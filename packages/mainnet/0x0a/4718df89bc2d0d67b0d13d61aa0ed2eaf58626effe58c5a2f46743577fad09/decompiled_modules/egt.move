module 0xa4718df89bc2d0d67b0d13d61aa0ed2eaf58626effe58c5a2f46743577fad09::egt {
    struct EGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGT>(arg0, 9, b"EGT", b"ELON GAMES", x"456c6f6e2047616d6520546f6b656e20697320746865206e6578742d67656e206d656d6520746f6b656e2064657369676e656420746f206d657267652066756e2c2067616d696e672c20616e6420736f6369616c20696e746572616374696f6e20696e2061207365616d6c65737320657870657269656e63652e204275696c7420666f72207468652076696272616e742067616d696e6720636f6d6d756e6974792c206f757220746f6b656e206f6666657273206d6f7265207468616e206a7573742076616c7565e28094697420706f77657273206120756e697665727365206f6620706c617966756c20656e676167656d656e742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89a85d32-cf56-449f-a83b-df64289dc3bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

