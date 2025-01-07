module 0xe1cee6e4242c0ae76b070dac6daee8da3b7e1747950fec318bc44c7de018aefe::drarmccto {
    struct DRARMCCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRARMCCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRARMCCTO>(arg0, 6, b"drarmcCTO", b"Drarm", b"100% fair launch, no TG, no X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003101_0b6a51ef9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRARMCCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRARMCCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

