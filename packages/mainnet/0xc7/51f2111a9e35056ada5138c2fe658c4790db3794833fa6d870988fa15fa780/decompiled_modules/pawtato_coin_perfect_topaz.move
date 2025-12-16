module 0xc751f2111a9e35056ada5138c2fe658c4790db3794833fa6d870988fa15fa780::pawtato_coin_perfect_topaz {
    struct PAWTATO_COIN_PERFECT_TOPAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PERFECT_TOPAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PERFECT_TOPAZ>(arg0, 9, b"PERFECT_TOPAZ", b"Pawtato Perfect Topaz", b"A Topaz with flawless clarity, ideal symmetry, and maximum brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/topaz-perfect.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PERFECT_TOPAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PERFECT_TOPAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_perfect_topaz(arg0: 0x2::coin::Coin<PAWTATO_COIN_PERFECT_TOPAZ>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PERFECT_TOPAZ>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

