module 0x906a7480a012b215ab45fc0b9a301312843c2ec0b98de42713a5fce253ade18e::creaty {
    struct CREATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREATY>(arg0, 9, b"CREATY", b"create", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b93d091eeedbc8b838879d9e57976166blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CREATY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREATY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

