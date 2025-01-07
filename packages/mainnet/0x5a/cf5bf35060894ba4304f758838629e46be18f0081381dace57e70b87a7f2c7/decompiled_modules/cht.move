module 0x5acf5bf35060894ba4304f758838629e46be18f0081381dace57e70b87a7f2c7::cht {
    struct CHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHT>(arg0, 9, b"CHT", b"chert", b"Unearth treasure with ChertCoin: The resilient cryptocurrency that's built on solid rock, delivering durable profits and strengthening your portfolio with unbreakable gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7cf0dbed-1f32-4083-aa78-5f2c92b2ab1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

