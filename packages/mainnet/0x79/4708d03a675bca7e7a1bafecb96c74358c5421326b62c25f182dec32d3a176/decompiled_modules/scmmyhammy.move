module 0x794708d03a675bca7e7a1bafecb96c74358c5421326b62c25f182dec32d3a176::scmmyhammy {
    struct SCMMYHAMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCMMYHAMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCMMYHAMMY>(arg0, 6, b"SCMMYHAMMY", b"Scammy Hammy", x"2453414448414d4d59206a7573742072756767656420736f206c65747320676574206f7572206d6f6e6579206261636b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732789126115.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCMMYHAMMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCMMYHAMMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

