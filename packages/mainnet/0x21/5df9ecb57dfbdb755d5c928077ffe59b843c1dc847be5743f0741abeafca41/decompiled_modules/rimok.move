module 0x215df9ecb57dfbdb755d5c928077ffe59b843c1dc847be5743f0741abeafca41::rimok {
    struct RIMOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIMOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIMOK>(arg0, 9, b"Rimok", b"Rimo", b"fast, best,  amazing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dede716c3aaa7a9b56c666b9710cff46blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIMOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIMOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

