module 0xd8e7fdc3f579f399c42544ecf94ce3f6ed42b23ea296df4f9b5b87a40fa318f0::bullshark {
    struct BULLSHARK has drop {
        dummy_field: bool,
    }

    struct TokenConfig has key {
        id: 0x2::object::UID,
        owner: address,
        total_supply: u64,
        treasury_cap: 0x2::coin::TreasuryCap<BULLSHARK>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BULLSHARK>, arg1: 0x2::coin::Coin<BULLSHARK>) {
        0x2::coin::burn<BULLSHARK>(arg0, arg1);
    }

    public fun get_total_supply(arg0: &TokenConfig) : u64 {
        arg0.total_supply
    }

    fun init(arg0: BULLSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULLSHARK>(arg0, 6, b"BSHARK", b"BULLSHARK", b"Bullshark ($BSHARK) is based on the most famous *SuiFren* on the ($SUI) network, combining AI AGENT + Trading bot and Dynamic PFP NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreihbeqqcphnt5356uh43becdgr556lspaahyoo4mxshtzxe7ih4qde.ipfs.w3s.link")), arg1);
        let v3 = v1;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSHARK>>(v2);
        let v4 = TokenConfig{
            id           : 0x2::object::new(arg1),
            owner        : v0,
            total_supply : 1000000000,
            treasury_cap : v3,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<BULLSHARK>>(0x2::coin::mint<BULLSHARK>(&mut v3, 1000000000, arg1), v0);
        0x2::transfer::share_object<TokenConfig>(v4);
    }

    public fun is_renounced(arg0: &TokenConfig) : bool {
        arg0.owner == @0x0
    }

    public entry fun renounce_ownership(arg0: &mut TokenConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.owner = @0x0;
    }

    // decompiled from Move bytecode v6
}

