module 0xe347c1fb909089a7dc0b5f648d4619e13570acefc75f5a5e672240f781fd99ae::exppro {
    struct EXPPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXPPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXPPRO>(arg0, 9, b"EXPPRO", b"Exp", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b0038fe2b8e30b17ca656ca735c53419blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXPPRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXPPRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

