module 0x3bfd1714b20c4962e77bf175fd97db927186c65ea6a28a57f99920245485eae2::rps_token {
    struct RPS_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<RPS_TOKEN>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        total_minted: u64,
        total_burned: u64,
        commission_earned: u64,
        mint_commission_rate: u64,
        burn_commission_rate: u64,
        admin: address,
        paused: bool,
        created_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokensMinted has copy, drop {
        user: address,
        sui_amount: u64,
        rps_amount: u64,
        commission: u64,
        timestamp: u64,
    }

    struct TokensBurned has copy, drop {
        user: address,
        rps_amount: u64,
        sui_amount: u64,
        commission: u64,
        timestamp: u64,
    }

    struct CommissionUpdated has copy, drop {
        commission_type: u8,
        old_rate: u64,
        new_rate: u64,
        timestamp: u64,
    }

    struct CommissionWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public fun burn_commission_rate(arg0: &TokenRegistry) : u64 {
        arg0.burn_commission_rate
    }

    public fun burn_tokens(arg0: &mut TokenRegistry, arg1: 0x2::coin::Coin<RPS_TOKEN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::coin::value<RPS_TOKEN>(&arg1);
        assert!(v0 >= 1000000000, 7);
        let v1 = v0 * 1000000000 / 100 * 100000000;
        let v2 = v1 * arg0.burn_commission_rate / 10000;
        let v3 = v1 - v2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v3, 3);
        arg0.total_burned = arg0.total_burned + v0;
        arg0.commission_earned = arg0.commission_earned + v2;
        0x2::coin::burn<RPS_TOKEN>(&mut arg0.treasury_cap, arg1);
        let v4 = TokensBurned{
            user       : 0x2::tx_context::sender(arg3),
            rps_amount : v0,
            sui_amount : v3,
            commission : v2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokensBurned>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v3), arg3)
    }

    public fun commission_earned(arg0: &TokenRegistry) : u64 {
        arg0.commission_earned
    }

    public fun get_stats(arg0: &TokenRegistry) : (u64, u64, u64, u64, u64, u64) {
        (arg0.total_minted, arg0.total_burned, total_supply(arg0), sui_reserve_balance(arg0), arg0.commission_earned, arg0.created_at)
    }

    fun init(arg0: RPS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPS_TOKEN>(arg0, 8, b"RPS", b"Rock Paper SUI Token", b"Gameplay token for Rock Paper SUI games. Mint with SUI, burn back to SUI.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = TokenRegistry{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            sui_reserve          : 0x2::balance::zero<0x2::sui::SUI>(),
            total_minted         : 0,
            total_burned         : 0,
            commission_earned    : 0,
            mint_commission_rate : 500,
            burn_commission_rate : 100,
            admin                : 0x2::tx_context::sender(arg1),
            paused               : false,
            created_at           : 0,
        };
        0x2::transfer::share_object<TokenRegistry>(v3);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RPS_TOKEN>>(v1);
    }

    public fun is_paused(arg0: &TokenRegistry) : bool {
        arg0.paused
    }

    public fun mint_commission_rate(arg0: &TokenRegistry) : u64 {
        arg0.mint_commission_rate
    }

    public fun mint_tokens(arg0: &mut TokenRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RPS_TOKEN> {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 100000000, 7);
        let v1 = v0 * arg0.mint_commission_rate / 10000;
        let v2 = (v0 - v1) * 100 * 100000000 / 1000000000;
        arg0.total_minted = arg0.total_minted + v2;
        arg0.commission_earned = arg0.commission_earned + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = TokensMinted{
            user       : 0x2::tx_context::sender(arg3),
            sui_amount : v0,
            rps_amount : v2,
            commission : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokensMinted>(v3);
        0x2::coin::mint<RPS_TOKEN>(&mut arg0.treasury_cap, v2, arg3)
    }

    public fun preview_burn(arg0: &TokenRegistry, arg1: u64) : (u64, u64) {
        let v0 = arg1 * 1000000000 / 100 * 100000000;
        let v1 = v0 * arg0.burn_commission_rate / 10000;
        (v0 - v1, v1)
    }

    public fun preview_mint(arg0: &TokenRegistry, arg1: u64) : (u64, u64) {
        let v0 = arg1 * arg0.mint_commission_rate / 10000;
        ((arg1 - v0) * 100 * 100000000 / 1000000000, v0)
    }

    public fun sui_reserve_balance(arg0: &TokenRegistry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun toggle_pause(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        arg0.paused = !arg0.paused;
    }

    public fun total_supply(arg0: &TokenRegistry) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    public fun transfer_admin(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 5);
        arg0.admin = arg2;
    }

    public fun update_burn_commission(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 5);
        assert!(arg2 <= 1000, 4);
        arg0.burn_commission_rate = arg2;
        let v0 = CommissionUpdated{
            commission_type : 1,
            old_rate        : arg0.burn_commission_rate,
            new_rate        : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CommissionUpdated>(v0);
    }

    public fun update_mint_commission(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 5);
        assert!(arg2 <= 1000, 4);
        arg0.mint_commission_rate = arg2;
        let v0 = CommissionUpdated{
            commission_type : 0,
            old_rate        : arg0.mint_commission_rate,
            new_rate        : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CommissionUpdated>(v0);
    }

    public fun withdraw_commission(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 5);
        let v0 = total_supply(arg0) * 1000000000 / 100;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        assert!(arg2 <= v2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, arg2), arg4), @0x47f0a8a77587ff3712b911c6e8371717615c13d1fb294bb01069dcde40edfbe5);
        arg0.commission_earned = arg0.commission_earned - arg2;
        let v3 = CommissionWithdrawn{
            amount    : arg2,
            recipient : @0x47f0a8a77587ff3712b911c6e8371717615c13d1fb294bb01069dcde40edfbe5,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CommissionWithdrawn>(v3);
    }

    // decompiled from Move bytecode v6
}

