module 0x6bf14eabc55adbe1ddd42d3eca414454a156bedb7c00f7b43516cc62707d4e8::dynamic_currency {
    struct DYNAMIC_CURRENCY has drop {
        dummy_field: bool,
    }

    struct DynamicCurrencyAdmin has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<DYNAMIC_CURRENCY>,
        metadata: 0x2::coin::CoinMetadata<DYNAMIC_CURRENCY>,
    }

    struct CoinMintedEvent has copy, drop {
        receiver: address,
        amount: u64,
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        description: 0x1::ascii::String,
    }

    fun init(arg0: DYNAMIC_CURRENCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYNAMIC_CURRENCY>(arg0, 9, b"DYNAMIC", b"Dynamic Coin", b"A dynamic currency that can be minted with custom properties", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = DynamicCurrencyAdmin{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            metadata     : v1,
        };
        0x2::transfer::share_object<DynamicCurrencyAdmin>(v2);
    }

    public entry fun mint_dynamic_coin(arg0: &mut DynamicCurrencyAdmin, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::update_name<DYNAMIC_CURRENCY>(&mut arg0.treasury_cap, &mut arg0.metadata, 0x1::string::utf8(arg2));
        0x2::coin::update_symbol<DYNAMIC_CURRENCY>(&mut arg0.treasury_cap, &mut arg0.metadata, 0x1::ascii::string(arg3));
        0x2::coin::update_description<DYNAMIC_CURRENCY>(&mut arg0.treasury_cap, &mut arg0.metadata, 0x1::string::utf8(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<DYNAMIC_CURRENCY>>(0x2::coin::mint<DYNAMIC_CURRENCY>(&mut arg0.treasury_cap, arg1, arg6), arg5);
        let v0 = CoinMintedEvent{
            receiver    : arg5,
            amount      : arg1,
            name        : 0x1::ascii::string(arg2),
            symbol      : 0x1::ascii::string(arg3),
            description : 0x1::ascii::string(arg4),
        };
        0x2::event::emit<CoinMintedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

