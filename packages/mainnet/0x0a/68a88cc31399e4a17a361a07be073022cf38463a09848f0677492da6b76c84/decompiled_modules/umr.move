module 0xa68a88cc31399e4a17a361a07be073022cf38463a09848f0677492da6b76c84::umr {
    struct UMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMR>(arg0, 9, b"UMR", b"Umar", b"Umrtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f146833-5255-41af-a071-f18cf6995f8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

