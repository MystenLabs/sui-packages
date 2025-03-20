module 0x545da26e007d0c7fe335aaf7d1654867fa7a916cd292adf9695fffa882e94e6b::invest_token {
    struct INVEST_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct TokenBurned has copy, drop {
        amount: u64,
        burner: address,
        timestamp: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<INVEST_TOKEN>, arg1: 0x2::coin::Coin<INVEST_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<INVEST_TOKEN>(arg0, arg1);
        let v0 = TokenBurned{
            amount    : 0x2::coin::value<INVEST_TOKEN>(&arg1),
            burner    : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TokenBurned>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<INVEST_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<INVEST_TOKEN>>(0x2::coin::mint<INVEST_TOKEN>(arg0, arg1, arg3), arg2);
        let v0 = TokenMinted{
            amount    : arg1,
            recipient : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenMinted>(v0);
    }

    fun init(arg0: INVEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVEST_TOKEN>(arg0, 9, b"XSPL Token", b"XSPL", b"Sui Platform Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVEST_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

