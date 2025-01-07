module 0x70eb7d790699d03a6ca85ca7872de0689d8430413f8fde269afa9a460cc8dfec::kemdn {
    struct KEMDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMDN>(arg0, 9, b"KEMDN", b"jsdn", b"jeje", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdd4f97d-c72c-4fe3-89a0-2760a8f08fbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEMDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

