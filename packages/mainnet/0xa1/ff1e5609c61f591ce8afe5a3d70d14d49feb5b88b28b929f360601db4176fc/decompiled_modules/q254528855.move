module 0xa1ff1e5609c61f591ce8afe5a3d70d14d49feb5b88b28b929f360601db4176fc::q254528855 {
    struct Q254528855 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q254528855, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q254528855>(arg0, 9, b"Q254528855", x"5741564520f09f8c8a", b"Get rich together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48aa943d-38a3-4250-9db5-2ed90260a9eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q254528855>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q254528855>>(v1);
    }

    // decompiled from Move bytecode v6
}

