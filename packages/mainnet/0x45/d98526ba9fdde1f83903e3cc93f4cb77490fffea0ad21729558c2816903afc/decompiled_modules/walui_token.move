module 0x45d98526ba9fdde1f83903e3cc93f4cb77490fffea0ad21729558c2816903afc::walui_token {
    struct WALUI_TOKEN has drop {
        dummy_field: bool,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        lp_wallet: address,
        creator_wallet: address,
        reward_wallets: vector<address>,
    }

    struct FeeTaken has copy, drop {
        total_fee: u64,
        lp_amount: u64,
        creator_amount: u64,
        rewards_amount: u64,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WALUI_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WALUI_TOKEN>>(0x2::coin::mint<WALUI_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WALUI_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WALUI_TOKEN>(arg0, 9, b"WALUI", b"Walui", b"Balanced SUI-WAL token with rewards", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALUI_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALUI_TOKEN>>(v1, v0);
        let v3 = FeeConfig{
            id             : 0x2::object::new(arg1),
            lp_wallet      : @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a,
            creator_wallet : v0,
            reward_wallets : vector[@0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a, @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a, @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a, @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a, @0x58189b677894e0fe7ad38e0e516408a3500da57d86fc0436373bc1d9c6334d0a],
        };
        0x2::transfer::share_object<FeeConfig>(v3);
    }

    public entry fun transfer_with_fee(arg0: &FeeConfig, arg1: 0x2::coin::Coin<WALUI_TOKEN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<WALUI_TOKEN>(&arg1);
        if (v0 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WALUI_TOKEN>>(arg1, arg2);
            return
        };
        let v1 = v0 / 50;
        let v2 = v1 / 8;
        let v3 = v1 * 3 / 8;
        let v4 = v1 - v2 - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<WALUI_TOKEN>>(0x2::coin::split<WALUI_TOKEN>(&mut arg1, v2, arg3), arg0.lp_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<WALUI_TOKEN>>(0x2::coin::split<WALUI_TOKEN>(&mut arg1, v3, arg3), arg0.creator_wallet);
        let v5 = 0;
        let v6 = 0x2::coin::split<WALUI_TOKEN>(&mut arg1, v4, arg3);
        while (v5 < 5) {
            let v7 = if (v5 == 4) {
                0x2::coin::value<WALUI_TOKEN>(&v6)
            } else {
                v4 / 5
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<WALUI_TOKEN>>(0x2::coin::split<WALUI_TOKEN>(&mut v6, v7, arg3), *0x1::vector::borrow<address>(&arg0.reward_wallets, v5));
            v5 = v5 + 1;
        };
        0x2::coin::destroy_zero<WALUI_TOKEN>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<WALUI_TOKEN>>(arg1, arg2);
        let v8 = FeeTaken{
            total_fee      : v1,
            lp_amount      : v2,
            creator_amount : v3,
            rewards_amount : v4,
        };
        0x2::event::emit<FeeTaken>(v8);
    }

    // decompiled from Move bytecode v6
}

