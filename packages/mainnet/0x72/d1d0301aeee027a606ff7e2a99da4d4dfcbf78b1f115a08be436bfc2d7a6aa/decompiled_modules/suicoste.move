module 0x72d1d0301aeee027a606ff7e2a99da4d4dfcbf78b1f115a08be436bfc2d7a6aa::suicoste {
    struct SUICOSTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOSTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOSTE>(arg0, 6, b"Suicoste", b"Suicoste - Fun in Sui", x"41207665727920756e6c696b656c7920627574206c696b656c79206d6572676572206f662053756920616e6420746865204c61636f737465206272616e642e200a20202020202020202020204173207468657265206973206e6f7468696e67206c696b65206974206f6e20746865206d61726b65742c200a4c6574277320686f706520697420676f657320766972616c20616e64207468652076616c756520676f657320746f20746865206d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suicoste_Move_Pump_123d6e2777.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOSTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOSTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

