module 0xa28a85700e24c690d9fd5c48ae989c6b2abee7c8821d23b05518cb9b2a8b59e8::aig_token {
    struct EventMint has copy, drop {
        sender: address,
        amount: u64,
        coin_left: u64,
    }

    struct EventAirdrop has copy, drop {
        method: 0x1::string::String,
        sender: address,
        amount: u64,
    }

    struct EventCoinMeta has copy, drop {
        decimals: u8,
        symbol: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct EventTotalSupply has copy, drop {
        total_supply: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<AIG_TOKEN>,
    }

    struct AIG_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint_balance(arg0: &mut 0x2::coin::TreasuryCap<AIG_TOKEN>, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<AIG_TOKEN>(&mut arg1.balance, 0x2::coin::mint_balance<AIG_TOKEN>(arg0, arg2));
        let v0 = EventMint{
            sender    : 0x2::tx_context::sender(arg3),
            amount    : arg2,
            coin_left : 0x2::balance::value<AIG_TOKEN>(&arg1.balance),
        };
        0x2::event::emit<EventMint>(v0);
    }

    public(friend) fun airdrop(arg0: &mut Vault, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::balance::split<AIG_TOKEN>(&mut arg0.balance, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIG_TOKEN>>(0x2::coin::take<AIG_TOKEN>(&mut v1, arg1, arg3), v0);
        0x2::balance::destroy_zero<AIG_TOKEN>(v1);
        let v2 = EventAirdrop{
            method : 0x1::string::utf8(arg2),
            sender : v0,
            amount : arg1,
        };
        0x2::event::emit<EventAirdrop>(v2);
    }

    fun init(arg0: AIG_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://ai-goal.vercel.app/");
        let (v1, v2) = 0x2::coin::create_currency<AIG_TOKEN>(arg0, 3, b"AIG", b"AIG Token", b"AIG Token is a token that is used to incentivize the community to achieve the goals of the AI Goal.", 0x1::option::some<0x2::url::Url>(v0), arg1);
        let v3 = v2;
        let v4 = EventCoinMeta{
            decimals    : 0x2::coin::get_decimals<AIG_TOKEN>(&v3),
            symbol      : 0x2::coin::get_symbol<AIG_TOKEN>(&v3),
            name        : 0x2::coin::get_name<AIG_TOKEN>(&v3),
            description : 0x2::coin::get_description<AIG_TOKEN>(&v3),
            icon_url    : 0x1::option::some<0x2::url::Url>(v0),
        };
        0x2::event::emit<EventCoinMeta>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIG_TOKEN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIG_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        let v5 = Vault{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<AIG_TOKEN>(),
        };
        0x2::transfer::share_object<Vault>(v5);
    }

    public fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<AIG_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AIG_TOKEN>>(0x2::coin::mint<AIG_TOKEN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
        0x2::coin::mint_and_transfer<AIG_TOKEN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
        let v0 = EventTotalSupply{total_supply: 0x2::coin::total_supply<AIG_TOKEN>(arg0)};
        0x2::event::emit<EventTotalSupply>(v0);
    }

    // decompiled from Move bytecode v6
}

