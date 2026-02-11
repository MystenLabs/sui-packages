module 0x68a8f87d11302e16e0d681be14326aee9a5e5f7f6006b260e184de998d8b3388::dropout {
    struct DROPOUT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<DROPOUT>, arg1: 0x2::coin::Coin<DROPOUT>) {
        0x2::coin::burn<DROPOUT>(arg0, arg1);
    }

    fun init(arg0: DROPOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPOUT>(arg0, 6, b"DROPOUT", b"Dropout", x"536f6d6574696d657320796f7520676f74746120646973636f6e6e6563742e2052616e646f6d206e6575726f6e732c2072616e646f6d206761696e732e20353025206368616e63652049206576656e207265616420746869732e202444524f504f555420e2809420726567756c6172697a6174696f6e20666f7220796f757220706f7274666f6c696f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fyBfMZu.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPOUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPOUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DROPOUT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DROPOUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

