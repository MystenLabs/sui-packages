module 0x787d56ad0ad650be2691b8fca4d08915260ec5a3bb71c582a58e60fe0818577::meotemp {
    struct MEOTEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOTEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOTEMP>(arg0, 9, b"MEOTEMP", b"MEOEE", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/1b5edde3c00af46c6aa24e043193521ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOTEMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOTEMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

