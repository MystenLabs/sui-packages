module 0xf77996d12aff41865989de6b9f230645404bd9a8e09a34921241237a6fc3a7fb::clt {
    struct CLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLT>(arg0, 9, b"CLT", b"CoinLite", b"CoinLite (CLT) is a cutting-edge digital currency designed for speed, security, and accessibility. Built on a robust blockchain infrastructure, CLT enables fast and seamless transactions, making it ideal for everyday use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/601445f4-a2bd-42e4-b91d-0f00526044ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

