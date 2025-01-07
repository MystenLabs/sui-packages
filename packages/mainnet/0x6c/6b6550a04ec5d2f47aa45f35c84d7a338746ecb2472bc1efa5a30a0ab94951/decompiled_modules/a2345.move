module 0x6c6b6550a04ec5d2f47aa45f35c84d7a338746ecb2472bc1efa5a30a0ab94951::a2345 {
    struct A2345 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A2345, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A2345>(arg0, 9, b"A2345", b"motherfuck", b"123453", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1592c27c-8b7b-4867-bce0-0f14b5beff33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A2345>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A2345>>(v1);
    }

    // decompiled from Move bytecode v6
}

