module 0xd4cee9abfc4543e7c7cb8bcc37a54f7021e9ece2b30354a0af1e1a2749568fcd::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 9, b"zxcvb", b"zxcvb", b"zxcvb is test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/logos/zxcvb.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: &mut 0x2::coin::TreasuryCap<COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

