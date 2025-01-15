module 0xe836193e950e498a1d695166dd85106e5c3cb2e118bd8427ca67a0be3b702247::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        owner: address,
        total_supply: u64,
        treasury_cap: 0x2::coin::TreasuryCap<BULLSHARK>,
    }

    public fun get_total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_supply
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULLSHARK>(arg0, 6, b"BSHARK", b"BULLSHARK", b"Bullshark ($BSHARK) is based on the most famous *SuiFren* on the ($SUI) network, combining AI AGENT + Trading bot and Dynamic PFP NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreib7pj7ig4tkjg3vsanyo5n4jhg2qmitl6mzqrlh2x2msxi5ebeqhe.ipfs.w3s.link")), arg1);
        let v3 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSHARK>>(v2);
        let v4 = TokenConfig{
            id           : 0x2::object::new(arg1),
            owner        : v0,
            total_supply : 1000000000000000,
            treasury_cap : v3,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLSHARK>>(0x2::coin::mint<BULLSHARK>(&mut v3, 1000000000000000, arg1), v0);
        0x2::transfer::share_object<TokenConfig>(v4);
    }

    // decompiled from Move bytecode v6
}

