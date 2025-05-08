module 0xa5aecb16a948ea61ef5cee77d53af080155c981bf6ed3b9f5cc6afa3daee5be5::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPEPE", b"SuiPEPE", b"makin my mark on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihdtg5txagd3q3swbhkimsatchcyjocv6grzzc7wylxuq6x4wdlwi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

