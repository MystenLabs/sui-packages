module 0x15fc1b6710fe32095bf07ef9698b3c50bd869b684d2c4d5a93e08adcd9b46802::tate {
    struct TATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATE>(arg0, 6, b"TATE", b"Tate Talisman", x"5472697374616e20546174652069732061207265616c2d6c696665204a616d657320426f6e642e205472697374616e20697320616e2065782d6b69636b626f786572206368616d70696f6e2c206d6564696120706572736f6e616c6974792c20616e64206e6f626c656d616e2c2077686f2072756e73207375636365737366756c20627573696e657373657320616c6c2061726f756e642074686520776f726c642e2050656f706c6520616c736f206b6e6f772068696d2061732054616c69736d616e20546174652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tate_6d5c1be3d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

