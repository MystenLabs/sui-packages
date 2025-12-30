module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::provider {
    struct Provider has store, key {
        id: 0x2::object::UID,
        owner: address,
        capacity_gb: u64,
        used_capacity_gb: u64,
        available_capacity_gb: u64,
        price_per_gb_per_month: u64,
        reputation_score: u64,
        is_active: bool,
        total_deals: u64,
        total_earned: u64,
        walrus_metadata_blob_id: vector<u8>,
        created_at: u64,
        updated_at: u64,
    }

    struct ProviderRegistry has store, key {
        id: 0x2::object::UID,
        providers: 0x2::table::Table<address, 0x2::object::ID>,
        total_providers: u64,
        total_capacity_gb: u64,
    }

    struct ProviderRegistered has copy, drop {
        provider_id: 0x2::object::ID,
        owner: address,
        capacity_gb: u64,
        price_per_gb_per_month: u64,
        timestamp: u64,
    }

    struct ProviderUpdated has copy, drop {
        provider_id: 0x2::object::ID,
        capacity_gb: u64,
        price_per_gb_per_month: u64,
        is_active: bool,
    }

    public fun get_capacity(arg0: &Provider) : (u64, u64, u64) {
        (arg0.capacity_gb, arg0.used_capacity_gb, arg0.available_capacity_gb)
    }

    public fun get_owner(arg0: &Provider) : address {
        arg0.owner
    }

    public fun get_pricing(arg0: &Provider) : u64 {
        arg0.price_per_gb_per_month
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProviderRegistry{
            id                : 0x2::object::new(arg0),
            providers         : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_providers   : 0,
            total_capacity_gb : 0,
        };
        0x2::transfer::share_object<ProviderRegistry>(v0);
    }

    public fun is_active(arg0: &Provider) : bool {
        arg0.is_active
    }

    public fun register_provider(arg0: &mut ProviderRegistry, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = Provider{
            id                      : 0x2::object::new(arg4),
            owner                   : v0,
            capacity_gb             : arg1,
            used_capacity_gb        : 0,
            available_capacity_gb   : arg1,
            price_per_gb_per_month  : arg2,
            reputation_score        : 5000,
            is_active               : true,
            total_deals             : 0,
            total_earned            : 0,
            walrus_metadata_blob_id : arg3,
            created_at              : v1,
            updated_at              : v1,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = ProviderRegistered{
            provider_id            : v3,
            owner                  : v0,
            capacity_gb            : arg1,
            price_per_gb_per_month : arg2,
            timestamp              : v1,
        };
        0x2::event::emit<ProviderRegistered>(v4);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.providers, v0, v3);
        arg0.total_providers = arg0.total_providers + 1;
        arg0.total_capacity_gb = arg0.total_capacity_gb + arg1;
        0x2::transfer::share_object<Provider>(v2);
    }

    public(friend) fun release_capacity(arg0: &mut Provider, arg1: u64) {
        arg0.used_capacity_gb = arg0.used_capacity_gb - arg1;
        arg0.available_capacity_gb = arg0.available_capacity_gb + arg1;
    }

    public(friend) fun reserve_capacity(arg0: &mut Provider, arg1: u64) {
        assert!(arg0.is_active, 2);
        assert!(arg0.available_capacity_gb >= arg1, 1);
        arg0.used_capacity_gb = arg0.used_capacity_gb + arg1;
        arg0.available_capacity_gb = arg0.available_capacity_gb - arg1;
    }

    public fun toggle_active(arg0: &mut Provider, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        arg0.is_active = !arg0.is_active;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    public fun update_capacity(arg0: &mut Provider, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(arg1 >= arg0.used_capacity_gb, 1);
        arg0.capacity_gb = arg1;
        arg0.available_capacity_gb = arg1 - arg0.used_capacity_gb;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v0 = ProviderUpdated{
            provider_id            : 0x2::object::uid_to_inner(&arg0.id),
            capacity_gb            : arg1,
            price_per_gb_per_month : arg0.price_per_gb_per_month,
            is_active              : arg0.is_active,
        };
        0x2::event::emit<ProviderUpdated>(v0);
    }

    public fun update_pricing(arg0: &mut Provider, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        assert!(arg1 > 0, 3);
        arg0.price_per_gb_per_month = arg1;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

