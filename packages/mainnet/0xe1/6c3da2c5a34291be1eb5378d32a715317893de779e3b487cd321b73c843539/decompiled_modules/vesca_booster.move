module 0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::vesca_booster {
    struct VeScaBindingRegistry has key {
        id: 0x2::object::UID,
        tiers: vector<TierThreshold>,
        max_discount_bp: u64,
        total_voting_power: u64,
        revenue_coins: vector<0x1::type_name::TypeName>,
        next_bind_sequence: u64,
        open_tickets: u64,
        writer_cap: 0x1::option::Option<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>,
        u64_padding: vector<u64>,
    }

    struct TierThreshold has copy, drop, store {
        min_voting_power: u64,
        discount_bp: u64,
    }

    struct VeScaAuthorityCap has store, key {
        id: 0x2::object::UID,
    }

    struct VpUpdateTicket {
        registry_id: 0x2::object::ID,
        user: address,
        remaining: vector<0x1::type_name::TypeName>,
    }

    struct BindingKey has copy, drop, store {
        user: address,
    }

    struct GenerationKey has copy, drop, store {
        user: address,
    }

    struct Binding has store {
        voting_power: u64,
        bound_ts_ms: u64,
        sequence: u64,
    }

    struct VeScaRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct VeScaAuthorityCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct VeScaWriterCapInstalled has copy, drop {
        registry_id: 0x2::object::ID,
        table_id: 0x2::object::ID,
    }

    struct VeScaTierConfigUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        tier_count: u64,
        max_discount_bp: u64,
    }

    struct VeScaBound has copy, drop {
        registry_id: 0x2::object::ID,
        user: address,
        voting_power: u64,
        discount_bp: u64,
        total_voting_power: u64,
    }

    struct VeScaVotingPowerRefreshed has copy, drop {
        registry_id: 0x2::object::ID,
        user: address,
        voting_power: u64,
        total_voting_power: u64,
    }

    struct VeScaUnbound has copy, drop {
        registry_id: 0x2::object::ID,
        user: address,
        total_voting_power: u64,
    }

    fun assert_authority(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &VeScaAuthorityCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert!(!0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::is_revoked(arg3, 0x2::object::id<VeScaAuthorityCap>(arg2)), 1100);
    }

    public fun apply_discount(arg0: &VeScaBindingRegistry, arg1: address, arg2: u64) : u64 {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::discount_fee_rate(arg2, discount_bp_of(arg0, arg1))
    }

    public fun begin_vp_update(arg0: &mut VeScaBindingRegistry, arg1: address) : VpUpdateTicket {
        arg0.open_tickets = arg0.open_tickets + 1;
        VpUpdateTicket{
            registry_id : 0x2::object::id<VeScaBindingRegistry>(arg0),
            user        : arg1,
            remaining   : arg0.revenue_coins,
        }
    }

    public fun bind_for(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &VeScaAuthorityCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &mut VeScaBindingRegistry, arg5: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg6: address, arg7: u64, arg8: &0x2::clock::Clock) : VpUpdateTicket {
        assert_authority(arg0, arg1, arg2, arg3);
        assert!(!is_bound(arg4, arg6), 2202);
        assert!(arg7 > 0, 2704);
        arg4.total_voting_power = checked_add(arg4.total_voting_power, arg7);
        bump_generation(arg4, arg6);
        let v0 = arg4.next_bind_sequence;
        arg4.next_bind_sequence = v0 + 1;
        let v1 = BindingKey{user: arg6};
        let v2 = Binding{
            voting_power : arg7,
            bound_ts_ms  : 0x2::clock::timestamp_ms(arg8),
            sequence     : v0,
        };
        0x2::dynamic_field::add<BindingKey, Binding>(&mut arg4.id, v1, v2);
        let v3 = VeScaBound{
            registry_id        : 0x2::object::id<VeScaBindingRegistry>(arg4),
            user               : arg6,
            voting_power       : arg7,
            discount_bp        : write_discount(arg0, arg4, arg5, arg6),
            total_voting_power : arg4.total_voting_power,
        };
        0x2::event::emit<VeScaBound>(v3);
        begin_vp_update(arg4, arg6)
    }

    public fun binding_generation(arg0: &VeScaBindingRegistry, arg1: address) : u64 {
        let v0 = GenerationKey{user: arg1};
        if (!0x2::dynamic_field::exists_<GenerationKey>(&arg0.id, v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<GenerationKey, u64>(&arg0.id, v0)
    }

    public fun binding_sequence_of(arg0: &VeScaBindingRegistry, arg1: address) : u64 {
        if (!is_bound(arg0, arg1)) {
            return 0
        };
        let v0 = BindingKey{user: arg1};
        0x2::dynamic_field::borrow<BindingKey, Binding>(&arg0.id, v0).sequence
    }

    public fun bound_since_ts_ms(arg0: &VeScaBindingRegistry, arg1: address) : u64 {
        if (!is_bound(arg0, arg1)) {
            return 0
        };
        let v0 = BindingKey{user: arg1};
        0x2::dynamic_field::borrow<BindingKey, Binding>(&arg0.id, v0).bound_ts_ms
    }

    fun bump_generation(arg0: &mut VeScaBindingRegistry, arg1: address) {
        let v0 = GenerationKey{user: arg1};
        if (0x2::dynamic_field::exists_<GenerationKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<GenerationKey, u64>(&mut arg0.id, v0);
            *v1 = *v1 + 1;
        } else {
            0x2::dynamic_field::add<GenerationKey, u64>(&mut arg0.id, v0, 1);
        };
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 2208);
        (v0 as u64)
    }

    public fun consume_ticket(arg0: &mut VeScaBindingRegistry, arg1: VpUpdateTicket) {
        destroy_settled_ticket(arg0, arg1, arg1.user);
    }

    fun destroy_settled_ticket(arg0: &mut VeScaBindingRegistry, arg1: VpUpdateTicket, arg2: address) {
        assert!(arg1.registry_id == 0x2::object::id<VeScaBindingRegistry>(arg0), 2204);
        assert!(arg1.user == arg2, 2204);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&arg1.remaining), 2205);
        arg0.open_tickets = arg0.open_tickets - 1;
        let VpUpdateTicket {
            registry_id : _,
            user        : _,
            remaining   : _,
        } = arg1;
    }

    public fun discount_bp_of(arg0: &VeScaBindingRegistry, arg1: address) : u64 {
        if (!is_bound(arg0, arg1)) {
            return 0
        };
        tier_discount_for(arg0, voting_power_of(arg0, arg1))
    }

    public fun has_writer_cap(arg0: &VeScaBindingRegistry) : bool {
        0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>(&arg0.writer_cap)
    }

    public fun install_writer_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut VeScaBindingRegistry, arg3: 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap, arg4: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_authority(arg0, arg4);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert!(0x1::option::is_none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>(&arg2.writer_cap), 2210);
        let v0 = VeScaWriterCapInstalled{
            registry_id : 0x2::object::id<VeScaBindingRegistry>(arg2),
            table_id    : 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::writer_cap_table_id(&arg3),
        };
        0x2::event::emit<VeScaWriterCapInstalled>(v0);
        0x1::option::fill<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>(&mut arg2.writer_cap, arg3);
    }

    public fun is_bound(arg0: &VeScaBindingRegistry, arg1: address) : bool {
        let v0 = BindingKey{user: arg1};
        0x2::dynamic_field::exists_<BindingKey>(&arg0.id, v0)
    }

    public fun is_revenue_coin(arg0: &VeScaBindingRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.revenue_coins, &arg1)
    }

    public fun max_discount_bp(arg0: &VeScaBindingRegistry) : u64 {
        arg0.max_discount_bp
    }

    public fun mint_authority_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg2, arg3);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        let v0 = VeScaAuthorityCap{id: 0x2::object::new(arg5)};
        let v1 = VeScaAuthorityCapIssued{
            cap_id    : 0x2::object::id<VeScaAuthorityCap>(&v0),
            recipient : arg4,
        };
        0x2::event::emit<VeScaAuthorityCapIssued>(v1);
        0x2::transfer::public_transfer<VeScaAuthorityCap>(v0, arg4);
    }

    public fun new_registry(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg2, arg3);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        let v0 = VeScaBindingRegistry{
            id                 : 0x2::object::new(arg4),
            tiers              : 0x1::vector::empty<TierThreshold>(),
            max_discount_bp    : 2000,
            total_voting_power : 0,
            revenue_coins      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            next_bind_sequence : 1,
            open_tickets       : 0,
            writer_cap         : 0x1::option::none<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>(),
            u64_padding        : vector[],
        };
        let v1 = VeScaRegistryCreated{registry_id: 0x2::object::id<VeScaBindingRegistry>(&v0)};
        0x2::event::emit<VeScaRegistryCreated>(v1);
        0x2::transfer::share_object<VeScaBindingRegistry>(v0);
    }

    public fun next_bind_sequence(arg0: &VeScaBindingRegistry) : u64 {
        arg0.next_bind_sequence
    }

    public fun open_tickets(arg0: &VeScaBindingRegistry) : u64 {
        arg0.open_tickets
    }

    public fun refresh_voting_power_for(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &VeScaAuthorityCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &mut VeScaBindingRegistry, arg5: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg6: VpUpdateTicket, arg7: address, arg8: u64) : VpUpdateTicket {
        assert_authority(arg0, arg1, arg2, arg3);
        destroy_settled_ticket(arg4, arg6, arg7);
        assert!(is_bound(arg4, arg7), 2203);
        let v0 = BindingKey{user: arg7};
        let v1 = 0x2::dynamic_field::borrow_mut<BindingKey, Binding>(&mut arg4.id, v0);
        v1.voting_power = arg8;
        arg4.total_voting_power = checked_add(arg4.total_voting_power - v1.voting_power, arg8);
        write_discount(arg0, arg4, arg5, arg7);
        let v2 = VeScaVotingPowerRefreshed{
            registry_id        : 0x2::object::id<VeScaBindingRegistry>(arg4),
            user               : arg7,
            voting_power       : arg8,
            total_voting_power : arg4.total_voting_power,
        };
        0x2::event::emit<VeScaVotingPowerRefreshed>(v2);
        begin_vp_update(arg4, arg7)
    }

    public(friend) fun register_revenue_coin(arg0: &mut VeScaBindingRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.revenue_coins, &arg1), 2207);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.revenue_coins, arg1);
    }

    public fun revenue_coin_count(arg0: &VeScaBindingRegistry) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.revenue_coins)
    }

    public fun set_tier_config(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::AdminCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &mut VeScaBindingRegistry, arg5: vector<u64>, arg6: vector<u64>, arg7: u64) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::caps::assert_admin_cap(arg0, arg2, arg3);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u64>(&arg6), 2200);
        assert!(arg7 <= 10000, 2201);
        let v0 = 0x1::vector::length<u64>(&arg5);
        let v1 = 0x1::vector::empty<TierThreshold>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg5, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg6, v2);
            if (v2 > 0) {
                assert!(v3 > *0x1::vector::borrow<u64>(&arg5, v2 - 1), 2200);
            } else {
                assert!(v3 > 0, 2200);
            };
            assert!(v4 <= arg7, 2201);
            let v5 = TierThreshold{
                min_voting_power : v3,
                discount_bp      : v4,
            };
            0x1::vector::push_back<TierThreshold>(&mut v1, v5);
            v2 = v2 + 1;
        };
        arg4.tiers = v1;
        arg4.max_discount_bp = arg7;
        let v6 = VeScaTierConfigUpdated{
            registry_id     : 0x2::object::id<VeScaBindingRegistry>(arg4),
            tier_count      : v0,
            max_discount_bp : arg7,
        };
        0x2::event::emit<VeScaTierConfigUpdated>(v6);
    }

    public fun sync_discount(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &VeScaBindingRegistry, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg4: address) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        write_discount(arg0, arg2, arg3, arg4);
    }

    public(friend) fun ticket_mark_settled(arg0: &mut VpUpdateTicket, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        assert!(arg0.registry_id == arg1, 2204);
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.remaining, &arg2);
        assert!(v0, 2206);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.remaining, v1);
    }

    public(friend) fun ticket_user(arg0: &VpUpdateTicket) : address {
        arg0.user
    }

    public fun tier_count(arg0: &VeScaBindingRegistry) : u64 {
        0x1::vector::length<TierThreshold>(&arg0.tiers)
    }

    fun tier_discount_for(arg0: &VeScaBindingRegistry, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<TierThreshold>(&arg0.tiers);
        let v1 = 0;
        while (v0 > 0) {
            v0 = v0 - 1;
            let v2 = 0x1::vector::borrow<TierThreshold>(&arg0.tiers, v0);
            if (arg1 >= v2.min_voting_power) {
                v1 = v2.discount_bp;
                break
            };
        };
        0x1::u64::min(v1, arg0.max_discount_bp)
    }

    public fun total_voting_power(arg0: &VeScaBindingRegistry) : u64 {
        arg0.total_voting_power
    }

    public fun unbind(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &mut VeScaBindingRegistry, arg3: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg4: VpUpdateTicket, arg5: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::assert_version(arg0);
        0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::version_check(arg1);
        unbind_inner(arg0, arg2, arg3, arg4, 0x2::tx_context::sender(arg5));
    }

    public fun unbind_for(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0xe16c3da2c5a34291be1eb5378d32a715317893de779e3b487cd321b73c843539::rewards_admin::Version, arg2: &VeScaAuthorityCap, arg3: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::cap_revocation::CapRevocationRegistry, arg4: &mut VeScaBindingRegistry, arg5: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg6: VpUpdateTicket, arg7: address) {
        assert_authority(arg0, arg1, arg2, arg3);
        unbind_inner(arg0, arg4, arg5, arg6, arg7);
    }

    fun unbind_inner(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut VeScaBindingRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg3: VpUpdateTicket, arg4: address) {
        destroy_settled_ticket(arg1, arg3, arg4);
        assert!(is_bound(arg1, arg4), 2203);
        let v0 = BindingKey{user: arg4};
        let Binding {
            voting_power : v1,
            bound_ts_ms  : _,
            sequence     : _,
        } = 0x2::dynamic_field::remove<BindingKey, Binding>(&mut arg1.id, v0);
        arg1.total_voting_power = arg1.total_voting_power - v1;
        write_discount(arg0, arg1, arg2, arg4);
        let v4 = VeScaUnbound{
            registry_id        : 0x2::object::id<VeScaBindingRegistry>(arg1),
            user               : arg4,
            total_voting_power : arg1.total_voting_power,
        };
        0x2::event::emit<VeScaUnbound>(v4);
    }

    public fun voting_power_of(arg0: &VeScaBindingRegistry, arg1: address) : u64 {
        if (!is_bound(arg0, arg1)) {
            return 0
        };
        let v0 = BindingKey{user: arg1};
        0x2::dynamic_field::borrow<BindingKey, Binding>(&arg0.id, v0).voting_power
    }

    fun write_discount(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &VeScaBindingRegistry, arg2: &mut 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::FeeDiscountTable, arg3: address) : u64 {
        assert!(0x1::option::is_some<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>(&arg1.writer_cap), 2211);
        let v0 = 0x1::u64::min(discount_bp_of(arg1, arg3), 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::max_discount_bp(arg2));
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::set_discount_bp(arg0, arg2, 0x1::option::borrow<0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::fee_discount::DiscountWriterCap>(&arg1.writer_cap), arg3, v0);
        v0
    }

    // decompiled from Move bytecode v7
}

