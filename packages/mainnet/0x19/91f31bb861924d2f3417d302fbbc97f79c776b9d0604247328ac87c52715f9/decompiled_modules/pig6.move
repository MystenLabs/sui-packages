module 0x1991f31bb861924d2f3417d302fbbc97f79c776b9d0604247328ac87c52715f9::pig6 {
    struct PIG6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG6>(arg0, 9, b"PIG6", b"PIGO", b"pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/705a703fd1168b459500b5dd6975b0deblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

