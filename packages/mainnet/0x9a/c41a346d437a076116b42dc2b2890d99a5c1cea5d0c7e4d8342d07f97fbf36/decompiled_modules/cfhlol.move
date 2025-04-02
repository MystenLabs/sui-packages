module 0x9ac41a346d437a076116b42dc2b2890d99a5c1cea5d0c7e4d8342d07f97fbf36::cfhlol {
    struct CFHLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFHLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFHLOL>(arg0, 9, b"CFHLOL", b"dyou", b"ky6uk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7fa3898891e10e54b7fcec8749bb42d2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFHLOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFHLOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

