module 0x453db1b41d62bf8653fa9c5b51b87b90864712b659a3ae4622ce2e5ba7033f37::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 9, b"CAP", b"Caprisun", b"Join now and enjoy the taste of fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64a323a2-3cc9-42f0-96b1-d049e764083e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

