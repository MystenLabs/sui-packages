module 0x761d7a4b3f3b459ec03edabe92c559935ea949c92585fa5ce8dac29afe431873::cosmos {
    struct COSMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMOS>(arg0, 9, b"Cosmos", b"Cosmos on Sui", b"\"Interstellar Wealth: COSMOS'' ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cd58e524d3362e4a6e4472e9fa1c0895blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COSMOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

