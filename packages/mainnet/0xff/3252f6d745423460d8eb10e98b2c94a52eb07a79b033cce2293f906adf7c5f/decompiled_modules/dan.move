module 0xff3252f6d745423460d8eb10e98b2c94a52eb07a79b033cce2293f906adf7c5f::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 9, b"DAN", b"DANCHO", b"Handsome DANCHO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d05eb2ae7308fd43e27ccebde99758bbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

