module 0x904beab894e235ccb58da7c77cf0721a78d2d47eb2f39fe64083d7464752ad08::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"ONE PUNCH MAN", x"245354414d412c207468652066697273742073757065726865726f206f66207468652053756920436861696e2c2069732066696e616c6c79206865726520746f20626520746865206e65787420626967206d656d6520746f6b656e20696e20746865207370616365210a0a68747470733a2f2f742e6d652f73756974616d61636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3623_36f740ca81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

