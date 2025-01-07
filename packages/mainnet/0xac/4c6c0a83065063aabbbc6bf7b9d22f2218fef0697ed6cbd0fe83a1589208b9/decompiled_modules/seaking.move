module 0xac4c6c0a83065063aabbbc6bf7b9d22f2218fef0697ed6cbd0fe83a1589208b9::seaking {
    struct SEAKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAKING>(arg0, 9, b"SEAKING", b"Sea King", x"417175616d616e206973204b696e67206f66205365612e20486520676f7665726e732065766572797468696e6720746861742069732062656c6f6e6720746f20776174657220776f726c642e2048697320706f77657266756c207374726f6e6720636f6d65732066726f6d2068697320627261766520686561727420616e642068697320676f6c642074726964656e742e2e2e20416e64206e6f772c20746865206c6567656e6420626567696e732120f09f928ef09f94b1f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90c8a650-a869-48db-b4ca-1f6932b019c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

