module 0x20234dd2399caef4ea76d492787c4a50b7ad6ae89789fa7495506c6e388ad804::hayk {
    struct HAYK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAYK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAYK>(arg0, 9, b"HAYK", b"HAYKO", b"ART", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e40ad32778d14aaf49a7943c1172e4aablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAYK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAYK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

