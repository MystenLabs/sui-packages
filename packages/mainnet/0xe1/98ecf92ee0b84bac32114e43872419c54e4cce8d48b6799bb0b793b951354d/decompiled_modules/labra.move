module 0xe198ecf92ee0b84bac32114e43872419c54e4cce8d48b6799bb0b793b951354d::labra {
    struct LABRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABRA>(arg0, 6, b"LABRA", b"Labrador", b"Labrador Your Loyal Crypto Companion!  1% Rewards in BUSD by simply holding $LABRA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bsc_labra_957d6d4550.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

