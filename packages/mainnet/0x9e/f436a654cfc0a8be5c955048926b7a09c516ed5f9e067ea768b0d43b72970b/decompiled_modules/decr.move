module 0x9ef436a654cfc0a8be5c955048926b7a09c516ed5f9e067ea768b0d43b72970b::decr {
    struct DECR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECR>(arg0, 9, b"DECR", b"De cry", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7c14094-52e1-4605-9948-c27e1da8d351.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECR>>(v1);
    }

    // decompiled from Move bytecode v6
}

