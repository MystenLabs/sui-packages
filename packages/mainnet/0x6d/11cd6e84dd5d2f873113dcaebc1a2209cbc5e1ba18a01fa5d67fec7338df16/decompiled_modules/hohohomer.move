module 0x6d11cd6e84dd5d2f873113dcaebc1a2209cbc5e1ba18a01fa5d67fec7338df16::hohohomer {
    struct HOHOHOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHOHOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHOHOMER>(arg0, 6, b"HOHOHOMER", b"HoHoHomer", x"486f6d6572206973206865726520746f20737072656164204368726973746d617320686f6c6964617920766962657320616e642024486f486f486f6d6572206761696e73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_200653_626_41254f80c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHOHOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOHOHOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

