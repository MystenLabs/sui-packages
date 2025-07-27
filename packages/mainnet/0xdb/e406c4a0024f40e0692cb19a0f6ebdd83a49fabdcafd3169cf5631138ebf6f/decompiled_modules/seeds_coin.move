module 0xdbe406c4a0024f40e0692cb19a0f6ebdd83a49fabdcafd3169cf5631138ebf6f::seeds_coin {
    struct SEEDS_COIN has drop {
        dummy_field: bool,
    }

    struct CoinConfig has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        current_supply: u64,
        mint_cap_per_tx: u64,
        is_paused: bool,
        admin: address,
        last_mint_time: u64,
        mint_cooldown: u64,
    }

    struct Blacklist has store, key {
        id: 0x2::object::UID,
        blocked_addresses: vector<address>,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
        minter: address,
        timestamp: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
        timestamp: u64,
    }

    struct TransferEvent has copy, drop {
        amount: u64,
        from: address,
        to: address,
        timestamp: u64,
    }

    struct PauseEvent has copy, drop {
        is_paused: bool,
        admin: address,
        timestamp: u64,
    }

    struct BlacklistEvent has copy, drop {
        address: address,
        is_blocked: bool,
        admin: address,
        timestamp: u64,
    }

    public entry fun add_to_blacklist(arg0: &CoinConfig, arg1: &mut Blacklist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        if (!0x1::vector::contains<address>(&arg1.blocked_addresses, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.blocked_addresses, arg2);
            let v0 = BlacklistEvent{
                address    : arg2,
                is_blocked : true,
                admin      : 0x2::tx_context::sender(arg3),
                timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<BlacklistEvent>(v0);
        };
    }

    public entry fun batch_mint(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(0x1::vector::length<u64>(&arg1) == v0, 7);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v3 = *0x1::vector::borrow<address>(&arg2, v1);
            0x2::coin::mint_and_transfer<SEEDS_COIN>(arg0, v2, v3, arg3);
            let v4 = MintEvent{
                amount    : v2,
                recipient : v3,
                minter    : 0x2::tx_context::sender(arg3),
                timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<MintEvent>(v4);
            v1 = v1 + 1;
        };
    }

    public entry fun batch_transfer(arg0: vector<0x2::coin::Coin<SEEDS_COIN>>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(0x1::vector::length<0x2::coin::Coin<SEEDS_COIN>>(&arg0) == v0, 7);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::pop_back<0x2::coin::Coin<SEEDS_COIN>>(&mut arg0);
            let v3 = *0x1::vector::borrow<address>(&arg1, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<SEEDS_COIN>>(v2, v3);
            let v4 = TransferEvent{
                amount    : 0x2::coin::value<SEEDS_COIN>(&v2),
                from      : 0x2::tx_context::sender(arg2),
                to        : v3,
                timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
            };
            0x2::event::emit<TransferEvent>(v4);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<SEEDS_COIN>>(arg0);
    }

    public entry fun burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: 0x2::coin::Coin<SEEDS_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SEEDS_COIN>(arg0, arg1);
        let v0 = BurnEvent{
            amount    : 0x2::coin::value<SEEDS_COIN>(&arg1),
            burner    : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun community_mint(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: &mut CoinConfig, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        assert!(!arg1.is_paused, 2);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 7);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v1);
            v1 = v1 + 1;
        };
        assert!(arg1.current_supply + v2 <= arg1.max_supply, 3);
        v1 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            let v4 = *0x1::vector::borrow<address>(&arg2, v1);
            0x2::coin::mint_and_transfer<SEEDS_COIN>(arg0, v3, v4, arg4);
            let v5 = MintEvent{
                amount    : v3,
                recipient : v4,
                minter    : 0x2::tx_context::sender(arg4),
                timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
            };
            0x2::event::emit<MintEvent>(v5);
            v1 = v1 + 1;
        };
        arg1.current_supply = arg1.current_supply + v2;
    }

    public entry fun ecosystem_rewards_mint(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: &mut CoinConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 1);
        assert!(!arg1.is_paused, 2);
        assert!(arg1.current_supply + arg2 <= arg1.max_supply, 3);
        0x2::coin::mint_and_transfer<SEEDS_COIN>(arg0, arg2, arg3, arg4);
        arg1.current_supply = arg1.current_supply + arg2;
        let v0 = MintEvent{
            amount    : arg2,
            recipient : arg3,
            minter    : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun get_coin_balance(arg0: &0x2::coin::Coin<SEEDS_COIN>) : u64 {
        0x2::coin::value<SEEDS_COIN>(arg0)
    }

    public fun get_config(arg0: &CoinConfig) : (u64, u64, u64, bool, address, u64, u64) {
        (arg0.max_supply, arg0.current_supply, arg0.mint_cap_per_tx, arg0.is_paused, arg0.admin, arg0.last_mint_time, arg0.mint_cooldown)
    }

    public fun get_total_supply(arg0: &0x2::coin::TreasuryCap<SEEDS_COIN>) : u64 {
        0x2::coin::total_supply<SEEDS_COIN>(arg0)
    }

    fun init(arg0: SEEDS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDS_COIN>(arg0, 6, b"SEEDS", b"Seeds Coin", b"SEEDS - Empowering sustainable communities and regenerative economics with 5 billion token ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blue-high-asp-865.mypinata.cloud/ipfs/bafkreigx74ff7sbm37lxy2zes4lsq7fmvbl2q44ghrdc5m4p24yhe25qdy")), arg1);
        let v2 = CoinConfig{
            id              : 0x2::object::new(arg1),
            max_supply      : 5000000000000000,
            current_supply  : 0,
            mint_cap_per_tx : 1000000000,
            is_paused       : false,
            admin           : 0x2::tx_context::sender(arg1),
            last_mint_time  : 0,
            mint_cooldown   : 60000,
        };
        let v3 = Blacklist{
            id                : 0x2::object::new(arg1),
            blocked_addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDS_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<CoinConfig>(v2);
        0x2::transfer::public_share_object<Blacklist>(v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEDS_COIN>>(v1);
    }

    public fun is_blacklisted(arg0: &Blacklist, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.blocked_addresses, &arg1)
    }

    public entry fun join_coins(arg0: &mut 0x2::coin::Coin<SEEDS_COIN>, arg1: 0x2::coin::Coin<SEEDS_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<SEEDS_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SEEDS_COIN>(arg0, arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
            minter    : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun remove_from_blacklist(arg0: &CoinConfig, arg1: &mut Blacklist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.blocked_addresses, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.blocked_addresses, v1);
            let v2 = BlacklistEvent{
                address    : arg2,
                is_blocked : false,
                admin      : 0x2::tx_context::sender(arg3),
                timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
            };
            0x2::event::emit<BlacklistEvent>(v2);
        };
    }

    public entry fun secure_burn(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: &mut CoinConfig, arg2: 0x2::coin::Coin<SEEDS_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 2);
        let v0 = 0x2::coin::value<SEEDS_COIN>(&arg2);
        0x2::coin::burn<SEEDS_COIN>(arg0, arg2);
        arg1.current_supply = arg1.current_supply - v0;
        let v1 = BurnEvent{
            amount    : v0,
            burner    : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun secure_mint(arg0: &mut 0x2::coin::TreasuryCap<SEEDS_COIN>, arg1: &mut CoinConfig, arg2: &Blacklist, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 2);
        assert!(arg3 > 0, 7);
        assert!(arg3 <= arg1.mint_cap_per_tx, 4);
        assert!(arg1.current_supply + arg3 <= arg1.max_supply, 3);
        assert!(!0x1::vector::contains<address>(&arg2.blocked_addresses, &arg4), 6);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg1.last_mint_time + arg1.mint_cooldown, 5);
        0x2::coin::mint_and_transfer<SEEDS_COIN>(arg0, arg3, arg4, arg6);
        arg1.current_supply = arg1.current_supply + arg3;
        arg1.last_mint_time = v0;
        let v1 = MintEvent{
            amount    : arg3,
            recipient : arg4,
            minter    : 0x2::tx_context::sender(arg6),
            timestamp : v0,
        };
        0x2::event::emit<MintEvent>(v1);
    }

    public entry fun secure_transfer(arg0: &CoinConfig, arg1: &Blacklist, arg2: 0x2::coin::Coin<SEEDS_COIN>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        assert!(!0x1::vector::contains<address>(&arg1.blocked_addresses, &arg3), 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x1::vector::contains<address>(&arg1.blocked_addresses, &v0), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEEDS_COIN>>(arg2, arg3);
        let v1 = TransferEvent{
            amount    : 0x2::coin::value<SEEDS_COIN>(&arg2),
            from      : 0x2::tx_context::sender(arg4),
            to        : arg3,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TransferEvent>(v1);
    }

    public entry fun set_pause(arg0: &mut CoinConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.is_paused = arg1;
        let v0 = PauseEvent{
            is_paused : arg1,
            admin     : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun split_coin(arg0: &mut 0x2::coin::Coin<SEEDS_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<SEEDS_COIN>(arg0) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SEEDS_COIN>>(0x2::coin::split<SEEDS_COIN>(arg0, arg1, arg3), arg2);
        let v0 = TransferEvent{
            amount    : arg1,
            from      : 0x2::tx_context::sender(arg3),
            to        : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public entry fun transfer_coin(arg0: 0x2::coin::Coin<SEEDS_COIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SEEDS_COIN>>(arg0, arg1);
        let v0 = TransferEvent{
            amount    : 0x2::coin::value<SEEDS_COIN>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public entry fun update_config(arg0: &mut CoinConfig, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        if (0x1::option::is_some<u64>(&arg1)) {
            arg0.max_supply = 0x1::option::extract<u64>(&mut arg1);
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            arg0.mint_cap_per_tx = 0x1::option::extract<u64>(&mut arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg0.mint_cooldown = 0x1::option::extract<u64>(&mut arg3);
        };
    }

    // decompiled from Move bytecode v6
}

