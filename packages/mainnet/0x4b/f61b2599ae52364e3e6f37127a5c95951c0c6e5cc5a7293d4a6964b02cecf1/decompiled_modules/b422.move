module 0x4bf61b2599ae52364e3e6f37127a5c95951c0c6e5cc5a7293d4a6964b02cecf1::b422 {
    struct B422 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B422, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B422>(arg0, 9, b"B422", b"Benbk", b"This is first test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/049569e4-5a6f-4f0a-9b57-317c63056c76.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B422>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B422>>(v1);
    }

    // decompiled from Move bytecode v6
}

