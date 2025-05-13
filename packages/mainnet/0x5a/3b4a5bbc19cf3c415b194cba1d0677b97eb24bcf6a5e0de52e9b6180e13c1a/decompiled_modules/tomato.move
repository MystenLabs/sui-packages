module 0x5a3b4a5bbc19cf3c415b194cba1d0677b97eb24bcf6a5e0de52e9b6180e13c1a::tomato {
    struct TOMATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMATO>(arg0, 6, b"TOMATO", b"Squishy Tomato", x"526f756e642c206669726d2c206a756963790a0a4974732068617070656e696e6720616e64206e6f7468696e6720697320676f696e6720746f2073746f702069740a0a5265642069732074686520636f6c6f72206f66206c696265726174696f6e20616e6420697320746865206f6e6c7920477265656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidk7z6zelx7iu3d77fluorjw7vdigeo3ynanloafjmcoyxkjsh6oy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOMATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

