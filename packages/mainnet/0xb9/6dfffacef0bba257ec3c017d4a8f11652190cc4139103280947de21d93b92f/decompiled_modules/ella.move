module 0xb96dfffacef0bba257ec3c017d4a8f11652190cc4139103280947de21d93b92f::ella {
    struct ELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELLA>(arg0, 6, b"ELLA", b"Ella AI", b"Meet Ella, shes got the power to make your portfolio adorable and unstoppable!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_051440_584_6b9a40735c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

