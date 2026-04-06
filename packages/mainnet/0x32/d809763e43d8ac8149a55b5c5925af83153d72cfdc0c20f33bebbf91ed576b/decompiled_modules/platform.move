module 0x85414a4d2a076f209b1eaddb1d3143832acc478601dfe3ecbc40bd7dfea6e000::platform {
    struct PlatformAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DonationPlatform has key {
        id: 0x2::object::UID,
        admin: address,
        total_projects_created: u64,
        total_vaults_created: u64,
        total_value_locked: u64,
        created_at: u64,
    }

    struct PlatformCreated has copy, drop {
        platform_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    public(friend) fun add_to_tvl(arg0: &mut DonationPlatform, arg1: u64) {
        arg0.total_value_locked = arg0.total_value_locked + arg1;
    }

    public fun get_admin(arg0: &DonationPlatform) : address {
        arg0.admin
    }

    public fun get_stats(arg0: &DonationPlatform) : (u64, u64, u64, u64) {
        (arg0.total_projects_created, arg0.total_vaults_created, arg0.total_value_locked, arg0.created_at)
    }

    public(friend) fun increment_project_count(arg0: &mut DonationPlatform) {
        arg0.total_projects_created = arg0.total_projects_created + 1;
    }

    public(friend) fun increment_vault_count(arg0: &mut DonationPlatform) {
        arg0.total_vaults_created = arg0.total_vaults_created + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = DonationPlatform{
            id                     : 0x2::object::new(arg0),
            admin                  : v0,
            total_projects_created : 0,
            total_vaults_created   : 0,
            total_value_locked     : 0,
            created_at             : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v2 = PlatformAdminCap{id: 0x2::object::new(arg0)};
        let v3 = PlatformCreated{
            platform_id : 0x2::object::id<DonationPlatform>(&v1),
            admin       : v0,
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<PlatformCreated>(v3);
        0x2::transfer::share_object<DonationPlatform>(v1);
        0x2::transfer::transfer<PlatformAdminCap>(v2, v0);
    }

    public(friend) fun subtract_from_tvl(arg0: &mut DonationPlatform, arg1: u64) {
        arg0.total_value_locked = arg0.total_value_locked - arg1;
    }

    // decompiled from Move bytecode v6
}

