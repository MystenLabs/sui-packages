module 0x541b7dc85e8d638c99d58a1a4a10b93727c6df9ce248a053a7d24016d52afc87::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct TokenFactory has key {
        id: 0x2::object::UID,
        admin: address,
        total_tokens_created: u64,
    }

    struct DynamicTokenCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    struct DynamicFreezeCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct DynamicPauseCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct DynamicFreezeRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        frozen_addresses: 0x2::table::Table<address, bool>,
    }

    struct DynamicPauseState<phantom T0> has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct BurnedTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    struct TokenCreated has copy, drop {
        creator: address,
        token_type: address,
        name: vector<u8>,
        symbol: vector<u8>,
        decimals: u8,
        total_supply: u64,
        treasury_cap_id: address,
        metadata_id: address,
        freeze_registry_id: address,
        pause_state_id: address,
        timestamp: u64,
    }

    struct AddressFrozen<phantom T0> has copy, drop {
        token_type: address,
        target_address: address,
    }

    struct AddressUnfrozen<phantom T0> has copy, drop {
        token_type: address,
        target_address: address,
    }

    struct TokenPaused<phantom T0> has copy, drop {
        token_type: address,
        paused: bool,
    }

    struct AuthorityRevoked<phantom T0> has copy, drop {
        token_type: address,
        treasury_id: address,
    }

    public fun burn<T0>(arg0: &mut DynamicTokenCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
    }

    public fun create_token<T0: drop>(arg0: &mut TokenFactory, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 18, 3);
        assert!(arg5 > 0, 4);
        let v0 = if (0x1::vector::length<u8>(&arg7) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(arg7)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg1, arg4, arg3, arg2, arg6, v0, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::tx_context::sender(arg8);
        let v6 = DynamicTokenCap<T0>{
            id       : 0x2::object::new(arg8),
            treasury : v4,
        };
        let v7 = DynamicFreezeCap<T0>{id: 0x2::object::new(arg8)};
        let v8 = DynamicPauseCap<T0>{id: 0x2::object::new(arg8)};
        let v9 = DynamicFreezeRegistry<T0>{
            id               : 0x2::object::new(arg8),
            frozen_addresses : 0x2::table::new<address, bool>(arg8),
        };
        let v10 = DynamicPauseState<T0>{
            id        : 0x2::object::new(arg8),
            is_paused : false,
        };
        let v11 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut v4, arg5, arg8), v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v3);
        0x2::transfer::public_transfer<DynamicTokenCap<T0>>(v6, v5);
        0x2::transfer::public_transfer<DynamicFreezeCap<T0>>(v7, v5);
        0x2::transfer::public_transfer<DynamicPauseCap<T0>>(v8, v5);
        0x2::transfer::share_object<DynamicFreezeRegistry<T0>>(v9);
        0x2::transfer::share_object<DynamicPauseState<T0>>(v10);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        let v12 = TokenCreated{
            creator            : v5,
            token_type         : 0x2::object::id_to_address(&v11),
            name               : arg2,
            symbol             : arg3,
            decimals           : arg4,
            total_supply       : arg5,
            treasury_cap_id    : 0x2::object::id_address<DynamicTokenCap<T0>>(&v6),
            metadata_id        : 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(&v3),
            freeze_registry_id : 0x2::object::id_address<DynamicFreezeRegistry<T0>>(&v9),
            pause_state_id     : 0x2::object::id_address<DynamicPauseState<T0>>(&v10),
            timestamp          : 0x2::tx_context::epoch(arg8),
        };
        0x2::event::emit<TokenCreated>(v12);
    }

    public fun freeze_address<T0>(arg0: &DynamicFreezeCap<T0>, arg1: &mut DynamicFreezeRegistry<T0>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen<T0>{
            token_type     : @0x0,
            target_address : arg2,
        };
        0x2::event::emit<AddressFrozen<T0>>(v0);
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

    public fun is_frozen<T0>(arg0: &DynamicFreezeRegistry<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen_addresses, arg1) && *0x2::table::borrow<address, bool>(&arg0.frozen_addresses, arg1)
    }

    public fun pause_token<T0>(arg0: &DynamicPauseCap<T0>, arg1: &mut DynamicPauseState<T0>) {
        arg1.is_paused = true;
        let v0 = TokenPaused<T0>{
            token_type : @0x0,
            paused     : true,
        };
        0x2::event::emit<TokenPaused<T0>>(v0);
    }

    public fun renounce_treasury<T0>(arg0: DynamicTokenCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let DynamicTokenCap {
            id       : v0,
            treasury : v1,
        } = arg0;
        let v2 = v1;
        let v3 = 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v2);
        0x2::object::delete(v0);
        let v4 = BurnedTreasury<T0>{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        0x2::transfer::share_object<BurnedTreasury<T0>>(v4);
        let v5 = AuthorityRevoked<T0>{
            token_type  : @0x0,
            treasury_id : 0x2::object::id_to_address(&v3),
        };
        0x2::event::emit<AuthorityRevoked<T0>>(v5);
    }

    public fun resume_token<T0>(arg0: &DynamicPauseCap<T0>, arg1: &mut DynamicPauseState<T0>) {
        arg1.is_paused = false;
        let v0 = TokenPaused<T0>{
            token_type : @0x0,
            paused     : false,
        };
        0x2::event::emit<TokenPaused<T0>>(v0);
    }

    public fun transfer_admin(arg0: &mut TokenFactory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.admin = arg1;
    }

    public fun transfer_checked<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &DynamicFreezeRegistry<T0>, arg3: &DynamicPauseState<T0>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 6);
        assert!(!is_frozen<T0>(arg2, 0x2::tx_context::sender(arg4)), 5);
        assert!(!is_frozen<T0>(arg2, arg1), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun transfer_treasury<T0>(arg0: DynamicTokenCap<T0>, arg1: address) {
        0x2::transfer::public_transfer<DynamicTokenCap<T0>>(arg0, arg1);
    }

    public fun unfreeze_address<T0>(arg0: &DynamicFreezeCap<T0>, arg1: &mut DynamicFreezeRegistry<T0>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.frozen_addresses, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.frozen_addresses, arg2);
        };
        let v0 = AddressUnfrozen<T0>{
            token_type     : @0x0,
            target_address : arg2,
        };
        0x2::event::emit<AddressUnfrozen<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

