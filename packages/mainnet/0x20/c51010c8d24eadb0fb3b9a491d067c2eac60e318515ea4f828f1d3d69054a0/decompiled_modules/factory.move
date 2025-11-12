module 0x20c51010c8d24eadb0fb3b9a491d067c2eac60e318515ea4f828f1d3d69054a0::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct TokenFactory has key {
        id: 0x2::object::UID,
        admin: address,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        total_tokens_created: u64,
        fee_collector_package: address,
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

    public fun create_token<T0: drop>(arg0: &mut TokenFactory, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 18, 3);
        assert!(arg5 > 0, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(v0 >= 6000000000, 1);
        if (v0 > 6000000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v0 - 6000000000, arg9), 0x2::tx_context::sender(arg9));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        let v1 = if (0x1::vector::length<u8>(&arg7) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(arg7)))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<T0>(arg1, arg4, arg3, arg2, arg6, v1, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg9);
        let v7 = DynamicTokenCap<T0>{
            id       : 0x2::object::new(arg9),
            treasury : v5,
        };
        let v8 = DynamicFreezeCap<T0>{id: 0x2::object::new(arg9)};
        let v9 = DynamicPauseCap<T0>{id: 0x2::object::new(arg9)};
        let v10 = DynamicFreezeRegistry<T0>{
            id               : 0x2::object::new(arg9),
            frozen_addresses : 0x2::table::new<address, bool>(arg9),
        };
        let v11 = DynamicPauseState<T0>{
            id        : 0x2::object::new(arg9),
            is_paused : false,
        };
        let v12 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut v5, arg5, arg9), v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v4);
        0x2::transfer::public_transfer<DynamicTokenCap<T0>>(v7, v6);
        0x2::transfer::public_transfer<DynamicFreezeCap<T0>>(v8, v6);
        0x2::transfer::public_transfer<DynamicPauseCap<T0>>(v9, v6);
        0x2::transfer::share_object<DynamicFreezeRegistry<T0>>(v10);
        0x2::transfer::share_object<DynamicPauseState<T0>>(v11);
        arg0.total_tokens_created = arg0.total_tokens_created + 1;
        let v13 = TokenCreated{
            creator            : v6,
            token_type         : 0x2::object::id_to_address(&v12),
            name               : arg2,
            symbol             : arg3,
            decimals           : arg4,
            total_supply       : arg5,
            treasury_cap_id    : 0x2::object::id_address<DynamicTokenCap<T0>>(&v7),
            metadata_id        : 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(&v4),
            freeze_registry_id : 0x2::object::id_address<DynamicFreezeRegistry<T0>>(&v10),
            pause_state_id     : 0x2::object::id_address<DynamicPauseState<T0>>(&v11),
            timestamp          : 0x2::tx_context::epoch(arg9),
        };
        0x2::event::emit<TokenCreated>(v13);
    }

    public fun freeze_address<T0>(arg0: &DynamicFreezeCap<T0>, arg1: &mut DynamicFreezeRegistry<T0>, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.frozen_addresses, arg2, true);
        let v0 = AddressFrozen<T0>{
            token_type     : @0x0,
            target_address : arg2,
        };
        0x2::event::emit<AddressFrozen<T0>>(v0);
    }

    public fun get_creation_fee() : u64 {
        6000000000
    }

    public fun get_stats(arg0: &TokenFactory) : (u64, u64) {
        (arg0.total_tokens_created, 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees))
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenFactory{
            id                    : 0x2::object::new(arg1),
            admin                 : 0x2::tx_context::sender(arg1),
            collected_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_tokens_created  : 0,
            fee_collector_package : @0x0,
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

    public fun update_fee_collector(arg0: &mut TokenFactory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        arg0.fee_collector_package = arg1;
    }

    public fun withdraw_fees(arg0: &mut TokenFactory, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_fees, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

