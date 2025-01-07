module 0xba2eecb7a727dba34f3f77d2222c44d2964b88b7fa935944dd6bce02830ff769::tot {
    struct TOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOT>(arg0, 9, b"ToT", b"TT", b"khokkkkk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/83be1f92ac51360b1e8c97a9e3f51957blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

