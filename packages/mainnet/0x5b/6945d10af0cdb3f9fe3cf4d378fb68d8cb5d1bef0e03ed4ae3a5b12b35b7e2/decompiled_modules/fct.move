module 0x5b6945d10af0cdb3f9fe3cf4d378fb68d8cb5d1bef0e03ed4ae3a5b12b35b7e2::fct {
    struct FCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCT>(arg0, 9, b"FCT", b"Fluffy Cat", b"A fluffy cat is loved by all for its warmth and positive energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c57a2107-7463-4e8d-bfd9-ef801b0fb5a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

