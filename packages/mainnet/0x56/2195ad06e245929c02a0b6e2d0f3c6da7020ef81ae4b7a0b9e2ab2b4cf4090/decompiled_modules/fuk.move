module 0x562195ad06e245929c02a0b6e2d0f3c6da7020ef81ae4b7a0b9e2ab2b4cf4090::fuk {
    struct FUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUK>(arg0, 9, b"FUK", b"FUk", b"Fuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f9ed152-6280-4586-98df-a904cb48f1cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

