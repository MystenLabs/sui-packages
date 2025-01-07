module 0x5ba5487eeeae71f78b89ab961bb44b286eba8b36fbc8bcc9b24be5304bc078cb::twd {
    struct TWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWD>(arg0, 6, b"TWD", b"Wif Dog Trump", b"$TWD represents a new era of transparency and community-focused values in the crypto space. By eliminating taxes, ensuring the liquidity pool is burned, and renouncing the contract, $TWD prioritizes trust & long-term stability. These measures ensure that the coin is truly owned and governed by the community, removing the risk of manipulation by developers. Backed by the collective power of memes, $TWD seeks to engage a global audience, uniting enthusiasts & investors under a shared vision of fairness and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T_Rump_Dog_f9c08e9687.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

