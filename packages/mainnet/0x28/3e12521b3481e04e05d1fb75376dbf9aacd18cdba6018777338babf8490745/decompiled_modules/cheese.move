module 0x283e12521b3481e04e05d1fb75376dbf9aacd18cdba6018777338babf8490745::cheese {
    struct CHEESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEESE>(arg0, 6, b"CHEESE", b"Cheese Cat 8888", x"4920616d204368656573652e2048656c6c6f206d65776f2e20492068616420746f6f206d75636820636865646461722077697468206d792062657374792c20536f67205075700a0a537461792074756e656420666f72206d7920616476656e74757265732061732049206578706c6f72657320746865206772656174206269672077657420776f726c64206f6620535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheesecatsmol_df207c99db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

