module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeTier has copy, drop, store {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_rate: u64,
        fee_tiers: 0x2::vec_map::VecMap<u32, FeeTier>,
        acl: 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::acl::ACL,
        package_version: u64,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct AddFeeTierEvent has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct UpdateFeeTierEvent has copy, drop {
        tick_spacing: u32,
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct DeleteFeeTierEvent has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun acl(arg0: &GlobalConfig) : &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::acl::ACL {
        abort 0
    }

    public fun add_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        abort 0
    }

    public fun check_fee_tier_manager_role(arg0: &GlobalConfig, arg1: address) {
        abort 0
    }

    public fun check_partner_manager_role(arg0: &GlobalConfig, arg1: address) {
        abort 0
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        abort 0
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        abort 0
    }

    public fun check_rewarder_manager_role(arg0: &GlobalConfig, arg1: address) {
        abort 0
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        abort 0
    }

    public fun delete_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun fee_rate(arg0: &FeeTier) : u64 {
        abort 0
    }

    public fun fee_tiers(arg0: &GlobalConfig) : &0x2::vec_map::VecMap<u32, FeeTier> {
        abort 0
    }

    public fun get_fee_rate(arg0: u32, arg1: &GlobalConfig) : u64 {
        abort 0
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::acl::Member> {
        abort 0
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        abort 0
    }

    public fun is_pool_manager(arg0: &GlobalConfig, arg1: address) : bool {
        abort 0
    }

    public fun max_fee_rate() : u64 {
        abort 0
    }

    public fun max_protocol_fee_rate() : u64 {
        abort 0
    }

    public fun package_version() : u64 {
        abort 0
    }

    public fun protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        abort 0
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        abort 0
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        abort 0
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        abort 0
    }

    public fun tick_spacing(arg0: &FeeTier) : u32 {
        abort 0
    }

    public fun update_fee_tier(arg0: &mut GlobalConfig, arg1: u32, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        abort 0
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

