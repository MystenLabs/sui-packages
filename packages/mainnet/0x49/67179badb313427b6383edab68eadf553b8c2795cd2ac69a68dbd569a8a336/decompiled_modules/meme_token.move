module 0x4967179badb313427b6383edab68eadf553b8c2795cd2ac69a68dbd569a8a336::meme_token {
    struct MEME_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenCreatedEvent has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        max_supply: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TransferCoinEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
    }

    struct TreasuryCapTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME_TOKEN>, arg1: 0x2::coin::Coin<MEME_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MEME_TOKEN>(arg0, arg1);
        let v0 = BurnEvent{
            amount : 0x2::coin::value<MEME_TOKEN>(&arg1),
            burner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEME_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::total_supply<MEME_TOKEN>(arg0) + arg1 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(0x2::coin::mint<MEME_TOKEN>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<MEME_TOKEN>) : u64 {
        0x2::coin::total_supply<MEME_TOKEN>(arg0)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<MEME_TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg2 == 0x2::coin::value<MEME_TOKEN>(&arg0)) {
            let v1 = TransferCoinEvent{
                from   : v0,
                to     : arg1,
                amount : arg2,
            };
            0x2::event::emit<TransferCoinEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(arg0, arg1);
        } else {
            let v2 = 0x2::coin::split<MEME_TOKEN>(&mut arg0, arg2, arg3);
            let v3 = TransferCoinEvent{
                from   : v0,
                to     : arg1,
                amount : 0x2::coin::value<MEME_TOKEN>(&v2),
            };
            0x2::event::emit<TransferCoinEvent>(v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(v2, arg1);
            let v4 = TransferCoinEvent{
                from   : v0,
                to     : v0,
                amount : 0x2::coin::value<MEME_TOKEN>(&arg0),
            };
            0x2::event::emit<TransferCoinEvent>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(arg0, v0);
        };
    }

    fun init(arg0: MEME_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    public fun init_internal(arg0: MEME_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_TOKEN>(arg0, 9, b"GTC", b"GTC", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://summon.lon1.cdn.digitaloceanspaces.com/2026-01-06T07-44-07.977Z-2025-12-05T05-59-22.341Z-ghost-rider.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_TOKEN>>(v1);
        let v2 = TokenCreatedEvent{
            name       : 0x1::string::utf8(b"GTC"),
            symbol     : 0x1::string::utf8(b"GTC"),
            decimals   : 9,
            max_supply : 1000000000000000000,
        };
        0x2::event::emit<TokenCreatedEvent>(v2);
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<MEME_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCapTransferred{
            previous_owner : 0x2::tx_context::sender(arg2),
            new_owner      : arg1,
            timestamp      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TreasuryCapTransferred>(v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

