module 0x5211a68b279fea092af58a0e217ca19a0d80cc4ad9a62779207aa13307b691::circle {
    struct CIRCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRCLE>(arg0, 6, b"CIRCLE", b"Circle", x"556c747261726f756e64204d6f6e657920697320746865207072656d69657265206368616f7320656e67696e65206275696c74206f6e205375692e20417320616e20696e647573747279206c65616465722c20556c747261726f756e64204d6f6e6579206861732070696f6e6565726564206e657720746563686e6f6c6f6779206b6e6f776e20617320746865204368616f7320456e67696e6520284345292e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/obraz_2024_10_01_195913606_6f1d882d41.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIRCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

