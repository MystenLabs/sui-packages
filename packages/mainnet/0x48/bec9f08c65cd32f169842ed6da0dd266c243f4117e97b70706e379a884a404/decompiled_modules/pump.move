module 0x48bec9f08c65cd32f169842ed6da0dd266c243f4117e97b70706e379a884a404::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"PUMP", b"Bee", b"Bee fly to the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1891f46-4e18-42ba-97d5-124cb5edd1fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

