module 0xaa27214a6a61d838d0b0ad8dc8f79ddcc17e09248e9d8cdd0a6d93cfa7a5ccec::bullfrog {
    struct BULLFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLFROG>(arg0, 6, b"BULLFROG", b"Bullfrog", x"42756c6c66726f67206973206120676f6f6679206168682066726f672c206865206a757374207369747320616e642073746172657320617420666c69657320616e642074616c6b696e20686973206e6f6e73656e736520616c6c20646179206c6f6e672c206865206e6565647320746f206561742062757420686520697320746f6f2064756d20746f206576656e206361746368206f6e650a4a6f696e206869732074656c656772616d20616e64206c65742068696d206b6e6f7720686f772064756d20616e6420616e6e6f79696e6720686520697321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_58265f1181.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

