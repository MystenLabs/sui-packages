module 0x1a44647046a9f553c3d0ce78a3cb4e614e59d0390f8024c7bddc605fdab2ded0::Cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS>>(0x2::coin::mint<CETUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"cetusairdrop com Airdrop token", b"CetusAirdrop com", b"Token drop to active users of the CETUS platform", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

