module 0xb06c46db7e86b4c639f0e4108ce38f9881e8c057ee3f9572bb64174d827499d6::pawtato_coin_perfect_emerald {
    struct PAWTATO_COIN_PERFECT_EMERALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PERFECT_EMERALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PERFECT_EMERALD>(arg0, 9, b"PERFECT_EMERALD", b"Pawtato Perfect Emerald", b"An Emerald with flawless clarity, ideal symmetry, and maximum brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/emerald-perfect.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PERFECT_EMERALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PERFECT_EMERALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_perfect_emerald(arg0: 0x2::coin::Coin<PAWTATO_COIN_PERFECT_EMERALD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PERFECT_EMERALD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

