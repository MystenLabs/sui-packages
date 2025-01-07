module 0xefd7a5e648481c0bcd05b791bb9b1a4f6a74109d3f4c18038e2bbf7f916c6c7b::kodak {
    struct KODAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KODAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KODAK>(arg0, 6, b"KODAK", b"Kodak On Sui", x"4d79206e616d65206973206b6f64616b2c2062757420796f75206b6e6f77207468617420616c7265616479210a57686164647570204a6974732e0a54686973206973206d792066697273742074696d65206f6e207375692e0a57696c6c20776520676f20746f20746865206d6f6f6e3f0a4920686f706520736f6f6f6f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_850ef0bf45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KODAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KODAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

