module 0x20e7030aa9bf152fae7aa836d4481f7f461bae190496e8768989dc86f902a001::songo {
    struct SONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONGO>(arg0, 9, b"SONGO", b"SON", b"Dragon ball Songoku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2869762c2cffd64dbbaa1bff1ced8586blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

