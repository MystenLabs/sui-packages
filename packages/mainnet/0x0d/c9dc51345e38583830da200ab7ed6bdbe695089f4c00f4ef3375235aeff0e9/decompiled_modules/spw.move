module 0xdc9dc51345e38583830da200ab7ed6bdbe695089f4c00f4ef3375235aeff0e9::spw {
    struct SPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPW>(arg0, 6, b"SPW", b"Sparrow", b"Sparrow Project | Set sail for crypto treasures!  Staking, Play-to-Earn games, & NFT loot await. Join the crew and claim yer share of the Sparrow bounty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017139_c02b0ea3ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

