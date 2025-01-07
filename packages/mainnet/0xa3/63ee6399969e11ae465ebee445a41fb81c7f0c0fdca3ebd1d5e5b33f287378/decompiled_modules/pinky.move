module 0xa363ee6399969e11ae465ebee445a41fb81c7f0c0fdca3ebd1d5e5b33f287378::pinky {
    struct PINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKY>(arg0, 6, b"PINKY", b"PINKY SUI", b"Don't fade the pink!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Lt_I4w_400x400_6ddbe88442.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

