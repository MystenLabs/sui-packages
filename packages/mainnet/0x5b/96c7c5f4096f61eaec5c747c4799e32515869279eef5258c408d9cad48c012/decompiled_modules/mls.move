module 0x5b96c7c5f4096f61eaec5c747c4799e32515869279eef5258c408d9cad48c012::mls {
    struct MLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLS>(arg0, 9, b"MLS", b"Miles", b"MLS is aiming to hit above 1$. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76fa3517-eef1-481e-8df9-1432bff86693.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

