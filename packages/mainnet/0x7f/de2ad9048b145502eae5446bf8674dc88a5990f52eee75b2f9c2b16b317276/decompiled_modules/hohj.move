module 0x7fde2ad9048b145502eae5446bf8674dc88a5990f52eee75b2f9c2b16b317276::hohj {
    struct HOHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHJ>(arg0, 9, b"Hohj", b"miyiip", b"cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ceca57856099ec8d66cd3a415c398de9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOHJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

