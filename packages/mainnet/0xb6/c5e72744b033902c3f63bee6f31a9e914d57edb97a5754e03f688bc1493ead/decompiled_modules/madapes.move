module 0xb6c5e72744b033902c3f63bee6f31a9e914d57edb97a5754e03f688bc1493ead::madapes {
    struct MADAPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADAPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADAPES>(arg0, 6, b"Madapes", b"Mad apes", x"4d61642061706573206865726520776520616c6c206d616b6520697420746f2074686520746f70200a506f7374696e6720616c6c20706f74656e7469616c207469636b657273206f6e20616c6c20626c6f636b636861696e73202c4c464747474747204d4144204150455320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000078937_ebdcc3356f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADAPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADAPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

