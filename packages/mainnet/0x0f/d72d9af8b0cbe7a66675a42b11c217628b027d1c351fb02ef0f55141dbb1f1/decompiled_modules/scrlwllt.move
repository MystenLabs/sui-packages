module 0xfd72d9af8b0cbe7a66675a42b11c217628b027d1c351fb02ef0f55141dbb1f1::scrlwllt {
    struct SCRLWLLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRLWLLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRLWLLT>(arg0, 9, b"Scrlwllt", b"scrollwallet", b".....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a4182b70cfb365421c2e346ca9e9a0a3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCRLWLLT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRLWLLT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

