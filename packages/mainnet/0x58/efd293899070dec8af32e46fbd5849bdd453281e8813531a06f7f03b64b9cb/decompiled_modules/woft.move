module 0x58efd293899070dec8af32e46fbd5849bdd453281e8813531a06f7f03b64b9cb::woft {
    struct WOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOFT>(arg0, 6, b"WoFT", b"Way of The Future", b"$WoFT launched on Solana reached a marketcap of $12.5M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsdfs_1b6e9fcf02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

