module 0x3997f5736800c8b75bd247d26e0bb2ef7fa275343ce5de8e87c4f552b3cfa424::sxs {
    struct SXS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXS>(arg0, 9, b"SXS", b"Sui X Sale", b"Only love !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8f3ee6adc3656dff6986dfd20334ccf8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SXS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

