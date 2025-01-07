module 0x9daf19f942760ed42cc06ace268167af6575ebfc1f39a12b01460ecf9c04ab92::squidsui {
    struct SQUIDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDSUI>(arg0, 6, b"SQUIDSUI", b"Squid sui", x"53717569642053554920686173206f6666696369616c6c79206c616e646564206f6e207468652053554920636861696e20616e64206973206e6f7720626174746c696e67206974732077617920696e746f20626f6e64696e6721200a49742773206120726f6c6c6572636f617374657220726964652c20616e642074686520636f6d6d756e697479206973206669676874696e67206861726420746f2072656163682074686973206372756369616c206d696c6573746f6e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031391_dbbbb41d2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

