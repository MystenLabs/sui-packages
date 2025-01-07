module 0x5b40582717e02edfe74c8070f00500c1f2dc0020118df4bd55c4cff1b23962e1::hp {
    struct HP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HP>(arg0, 6, b"HP", b"HOLY PRINTER", b"May the Holy Printer bless all of your bags. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/perfil_1083f38730.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HP>>(v1);
    }

    // decompiled from Move bytecode v6
}

