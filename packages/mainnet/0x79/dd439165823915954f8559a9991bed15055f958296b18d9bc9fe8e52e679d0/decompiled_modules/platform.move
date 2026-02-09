module 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform {
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
        let v0 = DonationPlatform{
            id                     : 0x2::object::new(arg0),
            admin                  : 0x2::tx_context::sender(arg0),
            total_projects_created : 0,
            total_vaults_created   : 0,
            total_value_locked     : 0,
            created_at             : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v1 = PlatformCreated{
            platform_id : 0x2::object::id<DonationPlatform>(&v0),
            admin       : 0x2::tx_context::sender(arg0),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<PlatformCreated>(v1);
        0x2::transfer::share_object<DonationPlatform>(v0);
    }

    public(friend) fun subtract_from_tvl(arg0: &mut DonationPlatform, arg1: u64) {
        arg0.total_value_locked = arg0.total_value_locked - arg1;
    }

    // decompiled from Move bytecode v6
}

