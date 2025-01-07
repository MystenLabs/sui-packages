module 0x578013555cea34091fd1e725d20f96a30b4dc547469cdc9f26fbad7f36532165::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"WALRUS", b"Sui Walrus", b"In ancient times, WALRUS ruled the deep as the true king of the seas. Now, he's backstronger, mightier, and ready to reclaim his throne on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwalrus_1_37842f5262.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

