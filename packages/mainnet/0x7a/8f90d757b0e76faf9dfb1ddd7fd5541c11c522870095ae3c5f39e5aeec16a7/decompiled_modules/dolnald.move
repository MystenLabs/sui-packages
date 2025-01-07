module 0x7a8f90d757b0e76faf9dfb1ddd7fd5541c11c522870095ae3c5f39e5aeec16a7::dolnald {
    struct DOLNALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLNALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLNALD>(arg0, 9, b"DOLNALD", b"Doldol", b"I am dolnald", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12d0bc9a-6c74-4007-8e85-0bfc15978132.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLNALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLNALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

