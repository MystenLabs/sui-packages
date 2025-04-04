module 0xe4446eb5c3afb0b97994f29381755ddb3e008cc07ea80c53ef967d023a0df138::sld {
    struct SLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLD>(arg0, 9, b"SLD", b"SuiLucid", b"nobody ready for it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/36b2c453978f6446a02041b0987418ecblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

