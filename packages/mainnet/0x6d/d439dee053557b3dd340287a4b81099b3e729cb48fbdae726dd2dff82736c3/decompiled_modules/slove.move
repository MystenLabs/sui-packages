module 0x6dd439dee053557b3dd340287a4b81099b3e729cb48fbdae726dd2dff82736c3::slove {
    struct SLOVE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLOVE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SLOVE>>(0x2::coin::mint<SLOVE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOVE>(arg0, 6, b"SLOVE", b"SLOVE", b"$SLOVE is the utility token in SEED App, earned through gameplay and used for essential in-game activities like breeding and NFT upgrades.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigt2pvpzokflugamigupuwo3xfw3agg3xcfuiduqpv3j6hfooh65a")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

