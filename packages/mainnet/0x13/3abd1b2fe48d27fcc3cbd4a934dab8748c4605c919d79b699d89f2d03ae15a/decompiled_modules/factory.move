module 0x133abd1b2fe48d27fcc3cbd4a934dab8748c4605c919d79b699d89f2d03ae15a::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct TokenFactory has key {
        id: 0x2::object::UID,
        admin: address,
        total_tokens_created: u64,
    }

    struct TokenWitness has drop {
        dummy_field: bool,
    }

    struct ManagedToken has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        total_supply: u64,
        treasury: 0x2::coin::TreasuryCap<TokenWitness>,
    }

    struct DynamicFreezeCap has store, key {
        id: 0x2::object::UID,
        token_id: address,
    }

    struct DynamicPauseCap has store, key {
        id: 0x2::object::UID,
        token_id: address,
    }

    struct DynamicFreezeRegistry has key {
        id: 0x2::object::UID,
        token_id: address,
        frozen_addresses: 0x2::table::Table<address, bool>,
    }

    struct DynamicPauseState has key {
        id: 0x2::object::UID,
        token_id: address,
        is_paused: bool,
    }

    struct TokenCreated has copy, drop {
        creator: address,
        token_id: address,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        total_supply: u64,
        metadata_id: address,
        timestamp: u64,
    }

    struct AddressFrozen has copy, drop {
        token_id: address,
        target_address: address,
    }

    struct AddressUnfrozen has copy, drop {
        token_id: address,
        target_address: address,
    }

    struct TokenPaused has copy, drop {
        token_id: address,
        paused: bool,
    }

    public entry fun burn(arg0: &mut ManagedToken, arg1: 0x2::coin::Coin<TokenWitness>) {
        0x2::coin::burn<TokenWitness>(&mut arg0.treasury, arg1);
    }

    public entry fun create_token(arg0: &mut TokenFactory, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 18, 3);
        assert!(arg4 > 0, 4);
        let v0 = if (0x1::vector::length<u8>(&arg6) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(arg6)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let v1 = TokenWitness{dummy_field: false};
        let (v2, v3) = 0x2::coin::create_currency<TokenWitness>(v1, arg3, arg2, arg1, arg5, v0, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg7);
        let v7 = ManagedToken{
            id           : 0x2::object::new(arg7),
            name         : arg1,
            symbol       : arg2,
            decimals     : arg3,
            total_supply : arg4,
            treasury     : v5,
        };
        let v8 = 0x2::object::id_address<ManagedToken>(&v7);
        let v9 = DynamicFreezeCap{
            id       : 0x2::object::new(arg7),
            token_id : v8,
        };
        let v10 = DynamicPauseCap{
            id       : 0x2::object::new(arg7),
            token_id : v8,
        };
        let v11 = DynamicFreezeRegistry{
            id               : 0x2::object::new(arg7),
            token_id         : v8,
            frozen_addresses : 0x2::table::new<address, bool>(arg7),
        };
        let v12 = DynamicPauseState{
            id        : 0x2::object::new(arg7),
            token_id  : v8,
            is_paused : false,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TokenWitness>>(0x2::coin::mint<TokenWitness>(&mut v5, arg4, arg7), v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TokenWitness>>(v4);
        0x2::transfer::public_transfer<ManagedToken>(v7, v6);
        0x2::transfer::public_transfer<DynamicFreezeCap>(v9, v6);
        0x2::transfer::public_transfer<DynamicPauseCap>(v10, v6);
        0x2::transfer::share_object<DynamicFreezeRegistry>(v11);
        0x2::transfer::share_object<DynamicPauseState>(v12);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        let v13 = TokenCreated{
            creator      : v6,
            token_id     : v8,
            name         : arg1,
            symbol       : arg2,
            decimals     : arg3,
            total_supply : arg4,
            metadata_id  : 0x2::object::id_address<0x2::coin::CoinMetadata<TokenWitness>>(&v4),
            timestamp    : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<TokenCreated>(v13);
    }

    public entry fun freeze_address(arg0: &DynamicFreezeCap, arg1: &mut DynamicFreezeRegistry, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen{
            token_id       : arg1.token_id,
            target_address : arg2,
        };
        0x2::event::emit<AddressFrozen>(v0);
    }

    public fun get_admin(arg0: &TokenFactory) : address {
        arg0.admin
    }

    public fun get_stats(arg0: &TokenFactory) : u64 {
        arg0.total_tokens_created
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenFactory{
            id                   : 0x2::object::new(arg1),
            admin                : 0x2::tx_context::sender(arg1),
            total_tokens_created : 0,
        };
        0x2::transfer::share_object<TokenFactory>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<FACTORY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_frozen(arg0: &DynamicFreezeRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public entry fun pause_token(arg0: &DynamicPauseCap, arg1: &mut DynamicPauseState) {
        arg1.is_paused = true;
        let v0 = TokenPaused{
            token_id : arg1.token_id,
            paused   : true,
        };
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun resume_token(arg0: &DynamicPauseCap, arg1: &mut DynamicPauseState) {
        arg1.is_paused = false;
        let v0 = TokenPaused{
            token_id : arg1.token_id,
            paused   : false,
        };
        0x2::event::emit<TokenPaused>(v0);
    }

    public entry fun transfer_admin(arg0: &mut TokenFactory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public entry fun unfreeze_address(arg0: &DynamicFreezeCap, arg1: &mut DynamicFreezeRegistry, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen{
            token_id       : arg1.token_id,
            target_address : arg2,
        };
        0x2::event::emit<AddressUnfrozen>(v0);
    }

    // decompiled from Move bytecode v6
}

