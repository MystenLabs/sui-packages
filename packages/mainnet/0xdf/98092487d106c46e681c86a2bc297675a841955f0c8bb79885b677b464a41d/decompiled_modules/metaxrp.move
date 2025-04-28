module 0xdf98092487d106c46e681c86a2bc297675a841955f0c8bb79885b677b464a41d::metaxrp {
    struct METAXRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAXRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAXRP>(arg0, 9, b"MetaXrp", b"XRP", b"Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1ee2b217faea6c2f71be66014ab856edblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METAXRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAXRP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

