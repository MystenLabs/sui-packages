module 0x4069e01d31a03c5d7a25a9851baeff79b87d179d18bf266cfcdef8940ac86f58::popy {
    struct POPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPY>(arg0, 9, b"POPy", b"POP", b"pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/233fdce8389a52658041d070cafbc363blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

