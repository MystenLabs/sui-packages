module 0x7b3c10b1e98f27ca42b77e0b37bfa79bc2b525a9321d7e54e65eab299fcaff5b::mamama {
    struct MAMAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMAMA>(arg0, 9, b"MAMAMA", b"Mama", b"Meme funy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06a7818d-70e4-471a-9a7a-c54b63f656e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

