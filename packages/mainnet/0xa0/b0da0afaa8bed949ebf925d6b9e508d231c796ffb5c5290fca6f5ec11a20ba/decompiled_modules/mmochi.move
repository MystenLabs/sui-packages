module 0xa0b0da0afaa8bed949ebf925d6b9e508d231c796ffb5c5290fca6f5ec11a20ba::mmochi {
    struct MMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMOCHI>(arg0, 9, b"MMochi", b"V2", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4b8804554ac6fb90dcf7f91e58b870f5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMOCHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMOCHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

