module 0x804dfadc3997bcb7960f2e4e4858e8468530dbb8b18d3d5874cfc1e03c92c3c5::luffy28 {
    struct LUFFY28 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY28, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY28>(arg0, 9, b"LUFFY28", b"Luffy", x"f09f8eaf4265636f6d696e6720746865204c6561646572206f6620416e696d6520616e64204d656d6520546f6b656e730a0af09f9189576562736974653a2068747470733a2f2f6c75666679746f6b656e2e636f6d0a0af09f9189576869746570617065723a2068747470733a2f2f6c75666679746f6b656e2e636f6d2f7064662f776869746570617065722e7064660a0af09f9189486f7720746f206275793a2068747470733a2f2f6c75666679746f6b656e2e636f6d2f6275792f0a0af09f9189466f6c6c6f772075733a2068747470733a2f2f6c696e6b74722e65652f4c75666679746f6b656e0a0a542e6d652f6c75666679746f6b656e5f6f6666696369616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9e27607-8b07-48eb-9ed6-37f241375ba6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY28>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFY28>>(v1);
    }

    // decompiled from Move bytecode v6
}

