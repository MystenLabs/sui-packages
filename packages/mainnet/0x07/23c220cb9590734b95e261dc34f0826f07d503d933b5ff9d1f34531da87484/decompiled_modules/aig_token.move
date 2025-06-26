module 0x723c220cb9590734b95e261dc34f0826f07d503d933b5ff9d1f34531da87484::aig_token {
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
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<AIG_TOKEN>,
    }

    struct AIG_TOKEN has drop {
        dummy_field: bool,
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
        let v0 = 3;
        let v1 = b"AIG";
        let v2 = b"AIG Token";
        let v3 = b"AIG Token is a token that is used to incentivize the community to achieve the goals of the AI Goal.";
        let v4 = 0x2::url::new_unsafe_from_bytes(b"https://ai-goal.vercel.app/");
        let (v5, v6) = 0x2::coin::create_currency<AIG_TOKEN>(arg0, v0, v1, v2, v3, 0x1::option::some<0x2::url::Url>(v4), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIG_TOKEN>>(v6);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIG_TOKEN>>(v5, 0x2::tx_context::sender(arg1));
        let v7 = EventCoinMeta{
            decimals    : v0,
            symbol      : 0x1::string::utf8(v1),
            name        : 0x1::string::utf8(v2),
            description : 0x1::string::utf8(v3),
            icon_url    : 0x1::option::some<0x2::url::Url>(v4),
        };
        0x2::event::emit<EventCoinMeta>(v7);
        let v8 = Vault{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<AIG_TOKEN>(),
        };
        0x2::transfer::share_object<Vault>(v8);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIG_TOKEN>, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<AIG_TOKEN>(&mut arg1.balance, 0x2::coin::mint_balance<AIG_TOKEN>(arg0, arg2));
        let v0 = EventMint{
            sender    : 0x2::tx_context::sender(arg3),
            amount    : arg2,
            coin_left : 0x2::balance::value<AIG_TOKEN>(&arg1.balance),
        };
        0x2::event::emit<EventMint>(v0);
    }

    // decompiled from Move bytecode v6
}

