module 0x99d8c6becc36c8514579d536ab6c1cb3d5799f02520faa85504e37e0e2ec4a70::gmbl {
    struct GMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMBL>(arg0, 9, b"GMBL", b"Gamble", b"Gamble!!! An actual community driven token no telegram no X no allocation for the owner just gamble ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3880d9cc-829d-4107-9d9c-e90a7849f406.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

