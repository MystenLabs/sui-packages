module 0xa9a52009de030f05d5c077f7427c436976c7a19d832f16fbfbeea83fa1a51ff2::comedian {
    struct COMEDIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMEDIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMEDIAN>(arg0, 9, b"COMEDIAN", b"BAN", b"Banana on the wall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3591d086-218e-4709-a927-6ce19a58553f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMEDIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMEDIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

