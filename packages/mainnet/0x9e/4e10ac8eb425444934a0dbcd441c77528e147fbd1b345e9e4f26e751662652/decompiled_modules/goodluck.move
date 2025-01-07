module 0x9e4e10ac8eb425444934a0dbcd441c77528e147fbd1b345e9e4f26e751662652::goodluck {
    struct GOODLUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOODLUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOODLUCK>(arg0, 9, b"GOODLUCK", b"Good luck", b"Good luck for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28fd0ede-ba6d-4058-bf95-a9c98defd034.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOODLUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOODLUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

