module 0x9343000108312aee38aaf8d32e57ef3233c564a637cfe0290ccfdceb4280547f::pibit {
    struct PIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIBIT>(arg0, 9, b"PIBIT", b"pinkRabbit", b"FOLLOW THE PINK RABBIT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58bb1ed1-9cc4-4e3b-8eae-a282739ff134.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

