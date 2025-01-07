module 0xdf7059ce677f18f70120cef39ac8334d47dc8e2429f6b89ac6515a559de73aed::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 6, b"MURAD", b"Cult of Murad", x"57484f204953204d55524144203f0a4865206973206f75722063686f73656e206f6e652e2046697273742c20746865726520776173205361746f7368692c207468656e20566974616c696b2c20616e64206e6f77204d757261642e2043656c65627261746520616e6420706179207472696275746520746f20746865206c6561646572206f66206d656d65636f696e732c204d757261642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_20_17_00_699cc37c72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

