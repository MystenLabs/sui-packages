module 0xac197b1b30d1f4926c56b0e0d326a797c23c35c178b29c93be53c60ff6127305::pibit {
    struct PIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIBIT>(arg0, 9, b"PIBIT", b"pinkRabbit", b"FOLLOW THE PINK RABBIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2868f474-0fd4-447f-93b3-5f8aad0a08a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

