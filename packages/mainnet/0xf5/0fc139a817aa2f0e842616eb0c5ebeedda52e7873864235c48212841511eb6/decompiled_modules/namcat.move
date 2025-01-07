module 0xf50fc139a817aa2f0e842616eb0c5ebeedda52e7873864235c48212841511eb6::namcat {
    struct NAMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMCAT>(arg0, 6, b"NAMCAT", b"NAMCAT SUI", x"4d79206e616d65206973206e414d20436174206e20696d207468652031737420636174206f6e2074686520696e74726e742121203e2e3c0a4e7720696d206c697665206f6e20535549206e206c6f6f6b696e672066776420746f206275696c64206120636d6d6e7479206e2062636d65206120746f702063617420746f6b656e206f6e20697421217e7e3c212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3897_58cca06731.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

