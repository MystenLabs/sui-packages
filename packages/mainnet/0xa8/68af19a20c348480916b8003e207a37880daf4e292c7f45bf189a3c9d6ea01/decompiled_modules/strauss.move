module 0xa868af19a20c348480916b8003e207a37880daf4e292c7f45bf189a3c9d6ea01::strauss {
    struct STRAUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAUSS>(arg0, 6, b"STRAUSS", b"IAMSTRAUSS", b"JOHANNES STRAUSS I AM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730948658852.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRAUSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAUSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

