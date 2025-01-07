module 0xfe590048f13fca1f146a32fc846c96931dd703970ea871a5e5de318d7d90f3e8::fct {
    struct FCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCT>(arg0, 9, b"FCT", b"Fluffy Cat", b"A fluffy cat is loved by all for its warmth and positive energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4a51e38-8285-4eb9-86c8-c84fc06f6e37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

