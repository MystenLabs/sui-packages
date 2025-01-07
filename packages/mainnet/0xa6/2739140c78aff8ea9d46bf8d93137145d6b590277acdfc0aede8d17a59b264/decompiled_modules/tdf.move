module 0xa62739140c78aff8ea9d46bf8d93137145d6b590277acdfc0aede8d17a59b264::tdf {
    struct TDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDF>(arg0, 9, b"TDF", b"The food ", b"Food empowerment token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ba15ae4-c6f7-4b27-8a38-bf29aded0712.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

