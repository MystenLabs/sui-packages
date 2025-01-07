module 0x7dafaf7c398a0f4dc7f6eb94614cacac88ad6b1a1ca4e9cf730c77321bd1e2a4::moew {
    struct MOEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOEW>(arg0, 9, b"MOEW", b"MEOW", b"MEOWS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf5ca3be-edcd-48e0-bbf0-ab06a1baf7ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

