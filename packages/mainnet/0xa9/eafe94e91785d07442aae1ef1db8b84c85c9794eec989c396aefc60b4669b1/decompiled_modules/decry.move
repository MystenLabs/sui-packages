module 0xa9eafe94e91785d07442aae1ef1db8b84c85c9794eec989c396aefc60b4669b1::decry {
    struct DECRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DECRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DECRY>(arg0, 9, b"DECRY", b"De Cryp", b"Community token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5da7713c-ba6e-4288-9560-a5153d3bfaae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DECRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DECRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

