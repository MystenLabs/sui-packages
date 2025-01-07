module 0x2b92dda313e049456bd70d229a95f1c806fd76ffb7f77a8137cde5e5fd1b0b80::jinxy {
    struct JINXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINXY>(arg0, 9, b"JINXY", b"Jinxy", x"4a696e787920746865205265616c20536973746572206f66205065616e75742074686520537175697272656c20f09f90bfefb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/156097c2-45af-4426-bd46-84fd82a99897.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

