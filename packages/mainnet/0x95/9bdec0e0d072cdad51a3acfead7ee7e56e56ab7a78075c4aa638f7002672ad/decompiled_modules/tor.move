module 0x959bdec0e0d072cdad51a3acfead7ee7e56e56ab7a78075c4aa638f7002672ad::tor {
    struct TOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOR>(arg0, 6, b"ToR", b"Alastor", b"LOng time Liquidity Lockup no Tax Fees Best meme coin BEst token for investors and traders LEst help alastor To bulid an army", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1709977631372_d5be6a8a435a51211bc139f3b1467a7d_63321f2889.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

