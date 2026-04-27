module 0xc92c929316f67a06196586c38212032d1a40debd9230d908f3a1b9e2720d83e2::pprf {
    struct PPRF has drop {
        dummy_field: bool,
    }

    struct TreasuryLock has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PPRF>,
    }

    public fun update_icon_url(arg0: &TreasuryLock, arg1: &mut 0x2::coin::CoinMetadata<PPRF>, arg2: vector<u8>) {
        0x2::coin::update_icon_url<PPRF>(&arg0.treasury_cap, arg1, 0x1::ascii::string(arg2));
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: PPRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPRF>(arg0, 9, b"PPRF", b"PaperProof Protocol Token", b"PaperProof Protocol Token (PPRF) is the governance and treasury token of PaperProof, a decentralized protocol on Sui for publishing, verifying, distributing, and engaging with digital artifacts. PPRF supports protocol governance, treasury stewardship, ecosystem growth, and long-term sustainability. PaperProof combines on-chain records with decentralized storage to enable verifiable content and global community participation around published artifacts.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = TreasuryLock{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<PPRF>>(0x2::coin::mint<PPRF>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PPRF>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<TreasuryLock>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun total_supply_base_units() : u64 {
        10000000000000000000
    }

    public fun total_supply_tokens() : u64 {
        10000000000
    }

    // decompiled from Move bytecode v7
}

