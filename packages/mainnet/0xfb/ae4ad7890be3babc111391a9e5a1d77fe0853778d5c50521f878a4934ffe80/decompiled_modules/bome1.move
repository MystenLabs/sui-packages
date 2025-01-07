module 0xfbae4ad7890be3babc111391a9e5a1d77fe0853778d5c50521f878a4934ffe80::bome1 {
    struct BOME1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOME1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOME1>(arg0, 9, b"BOME1", b"BOME", b"Funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/721a02d8-5547-4f04-960d-659b864272b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOME1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOME1>>(v1);
    }

    // decompiled from Move bytecode v6
}

