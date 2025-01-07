module 0xd9b6ad9270e2d06f04d0f4e79fe539b4b38783c187b5ae4476d492cbe74f2c89::nakamoto {
    struct NAKAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAMOTO>(arg0, 9, b"NAKAMOTO", b"Satoshi11", b"It's just a secret coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f679bd4a-5641-4627-b545-81fdbd042af4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAMOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAMOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

