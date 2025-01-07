module 0x4d4cf64df4d26b15e6cb9e07a55404b8d6bfacf492e4bdfe040eab18e5d9a545::sharif {
    struct SHARIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARIF>(arg0, 9, b"SHARIF", b"Chas ", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2141c6ca-fea5-4643-b629-d1c8c8cdf369.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

