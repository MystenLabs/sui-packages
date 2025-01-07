module 0x7ebf56b6ed6141923c895c177f77689d8fe93102e2ea6abb221b980ff761d4ae::donkey {
    struct DONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY>(arg0, 6, b"DONKEY", b"Only Donkey on Sui", b"The Only Donkey on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMAGE_2024_06_26_19_14_55_768x768_ff15cdf573.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

