module 0x53b5a789cc8fc85cd30fbfc4fd8552f2b97ea960d617562c88f2e742911e6785::raahhh {
    struct RAAHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAAHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAAHHH>(arg0, 9, b"RAAHHH", b"Oil Token", b"Just oil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63011ad3-1628-499b-873b-8d1b3ab24199.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAAHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAAHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

