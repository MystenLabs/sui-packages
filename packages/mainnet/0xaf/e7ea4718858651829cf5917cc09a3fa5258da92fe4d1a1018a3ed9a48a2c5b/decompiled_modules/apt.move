module 0xafe7ea4718858651829cf5917cc09a3fa5258da92fe4d1a1018a3ed9a48a2c5b::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<APT>(arg0, 6, b"APT", b"Aptos by SuiAI", b"Aptos Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/21794_7f35d40fc9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

