module 0x8f50d135538874f352089971e3c16ebd77f03e40bb14d85b260e7148f54e2355::Done {
    struct DONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONE>(arg0, 9, b"DUSTED", b"Done", x"776527726520646f6e652e2e2e20f09f9a802074696d652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzsvUKRXEAA3WOu?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

