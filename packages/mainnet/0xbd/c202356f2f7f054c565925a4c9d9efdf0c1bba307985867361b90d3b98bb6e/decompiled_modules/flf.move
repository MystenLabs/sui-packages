module 0xbdc202356f2f7f054c565925a4c9d9efdf0c1bba307985867361b90d3b98bb6e::flf {
    struct FLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLF>(arg0, 9, b"FLF", b"Fluffy", x"426568696e64206576657279207375636365737366756c20746f6b656e2e2e2e746865726520697320616c77617973206120676f6f6f6f6f64206d656d652e2e2e2e2ef09f988ef09f988e202e7765206769766520796f7520666c756666792c61696d206174206272696e67696e672074686520736f636965747920746f6765746865722e2e2e2e2e2e2ef09f918cf09f8cbb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/164a8eee-6674-41e4-aa97-1ab83955feb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

