module 0x77baf2f78833d3b3578b38f870d140041a6b09fce9a225562688dee6beb2b074::kex {
    struct KEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEX>(arg0, 9, b"KEX", b"Kira ", b"Kira network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6311a98c-2ef5-4223-a28c-24fae3002352.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

