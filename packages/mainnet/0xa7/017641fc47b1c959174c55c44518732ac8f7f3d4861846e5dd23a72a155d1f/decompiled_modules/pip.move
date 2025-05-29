module 0xa7017641fc47b1c959174c55c44518732ac8f7f3d4861846e5dd23a72a155d1f::pip {
    struct PIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIP>(arg0, 6, b"PIP", b"Piplup", b"Piplup the Penguin Pokemon. A Water Type. On Sui Chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiha52loitqjrbqfzdipgoct4jbxkbrzq5o4qgoltxny2lw433fkxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

