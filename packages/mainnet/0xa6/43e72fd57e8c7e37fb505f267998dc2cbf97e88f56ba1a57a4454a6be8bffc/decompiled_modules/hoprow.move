module 0xa643e72fd57e8c7e37fb505f267998dc2cbf97e88f56ba1a57a4454a6be8bffc::hoprow {
    struct HOPROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPROW>(arg0, 6, b"HOPROW", b"HOPRO", b"HOPROWHOPROW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731107834970.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPROW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPROW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

