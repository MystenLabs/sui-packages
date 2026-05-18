module 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dapp_service {
    struct UserStorageRegistryKey has copy, drop, store {
        owner: address,
    }

    struct ParticipantKey has copy, drop, store {
        addr: address,
    }

    struct PermitMetadata has copy, drop, store {
        expires_at: 0x1::option::Option<u64>,
        invitees: vector<address>,
        invites_expire_at: 0x1::option::Option<u64>,
        max_participants: 0x1::option::Option<u64>,
        participant_count: u64,
    }

    struct ObjectEntityIdKey has copy, drop, store {
        type_tag: vector<u8>,
        entity_id: vector<u8>,
    }

    struct FeeHistoryEntry has copy, drop, store {
        base_fee: u256,
        bytes_fee: u256,
        effective_from_ms: u64,
    }

    struct FrameworkFeeConfig has drop, store {
        base_fee_per_write: u256,
        bytes_fee_per_byte: u256,
        pending_base_fee: u256,
        pending_bytes_fee: u256,
        fee_effective_at_ms: u64,
        treasury: address,
        pending_treasury: address,
        fee_history: vector<FeeHistoryEntry>,
        accepted_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        pending_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        coin_type_effective_at_ms: u64,
    }

    struct FrameworkConfig has drop, store {
        default_free_credit: u256,
        default_free_credit_duration_ms: u64,
        admin: address,
        pending_admin: address,
        default_write_fee_dapp_share_bps: u64,
        framework_max_write_limit: u64,
        marketplace_fee_bps: u64,
        marketplace_dapp_share_bps: u64,
    }

    struct DappHub has store, key {
        id: 0x2::object::UID,
        fee_config: FrameworkFeeConfig,
        config: FrameworkConfig,
        version: u64,
    }

    struct DappStorage has store, key {
        id: 0x2::object::UID,
        dapp_key: 0x1::ascii::String,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        website_url: 0x1::ascii::String,
        cover_url: vector<0x1::ascii::String>,
        partners: vector<0x1::ascii::String>,
        package_ids: vector<address>,
        created_at: u64,
        admin: address,
        pending_admin: address,
        version: u32,
        paused: bool,
        free_credit: u256,
        free_credit_expires_at: u64,
        credit_pool: u256,
        total_settled: u256,
        base_fee_per_write: u256,
        bytes_fee_per_byte: u256,
        settlement_mode: u8,
        write_fee_dapp_share_bps: u64,
    }

    struct UserStorage has key {
        id: 0x2::object::UID,
        dapp_key: 0x1::ascii::String,
        canonical_owner: address,
        session_key: address,
        session_expires_at: u64,
        write_count: u64,
        settled_count: u64,
        write_bytes: u256,
        settled_bytes: u256,
        write_limit: u64,
    }

    struct ObjectStorage<phantom T0> has key {
        id: 0x2::object::UID,
        dapp_key: 0x1::ascii::String,
        object_type: vector<u8>,
        entity_id: vector<u8>,
        data: 0x2::bag::Bag,
    }

    struct ScenePermit<phantom T0> has key {
        id: 0x2::object::UID,
        dapp_key: 0x1::ascii::String,
        permit_type: vector<u8>,
        meta: PermitMetadata,
    }

    struct SceneStorage<phantom T0> has key {
        id: 0x2::object::UID,
        dapp_key: 0x1::ascii::String,
        scene_type: vector<u8>,
        authorized_permit_id: 0x1::option::Option<address>,
        data: 0x2::bag::Bag,
    }

    struct DappRevenueKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DappGenesisKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Listing<phantom T0> has key {
        id: 0x2::object::UID,
        record_data: vector<vector<u8>>,
        record_type: vector<u8>,
        record_key: vector<vector<u8>>,
        field_names: vector<vector<u8>>,
        seller: address,
        price: u64,
        listed_until: 0x1::option::Option<u64>,
        dapp_key: 0x1::ascii::String,
        is_fungible: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DappHub {
        let v0 = FrameworkFeeConfig{
            base_fee_per_write        : 0,
            bytes_fee_per_byte        : 0,
            pending_base_fee          : 0,
            pending_bytes_fee         : 0,
            fee_effective_at_ms       : 0,
            treasury                  : @0x0,
            pending_treasury          : @0x0,
            fee_history               : 0x1::vector::empty<FeeHistoryEntry>(),
            accepted_coin_type        : 0x1::option::none<0x1::type_name::TypeName>(),
            pending_coin_type         : 0x1::option::none<0x1::type_name::TypeName>(),
            coin_type_effective_at_ms : 0,
        };
        let v1 = FrameworkConfig{
            default_free_credit              : 25000000000,
            default_free_credit_duration_ms  : 0,
            admin                            : 0x2::tx_context::sender(arg0),
            pending_admin                    : @0x0,
            default_write_fee_dapp_share_bps : 0,
            framework_max_write_limit        : 2000,
            marketplace_fee_bps              : 300,
            marketplace_dapp_share_bps       : 5000,
        };
        DappHub{
            id         : 0x2::object::new(arg0),
            fee_config : v0,
            config     : v1,
            version    : 1,
        }
    }

    public(friend) fun accept_invitation_in_scene_permit<T0>(arg0: &mut ScenePermit<T0>, arg1: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.meta.invitees, &arg1);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::not_participant(v0);
        0x1::vector::remove<address>(&mut arg0.meta.invitees, v1);
        add_participant_in_scene_permit<T0>(arg0, arg1);
    }

    public fun accepted_coin_type(arg0: &FrameworkFeeConfig) : &0x1::option::Option<0x1::type_name::TypeName> {
        &arg0.accepted_coin_type
    }

    public(friend) fun add_credit(arg0: &mut DappStorage, arg1: u256) {
        arg0.credit_pool = arg0.credit_pool + arg1;
    }

    public(friend) fun add_dapp_revenue<T0>(arg0: &mut DappStorage, arg1: 0x2::balance::Balance<T0>) {
        let v0 = DappRevenueKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<DappRevenueKey<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<DappRevenueKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<DappRevenueKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        };
    }

    public(friend) fun add_participant_in_scene_permit<T0>(arg0: &mut ScenePermit<T0>, arg1: address) {
        let v0 = ParticipantKey{addr: arg1};
        if (0x2::dynamic_field::exists_<ParticipantKey>(&arg0.id, v0)) {
            return
        };
        if (0x1::option::is_some<u64>(&arg0.meta.max_participants)) {
            0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::scene_full(arg0.meta.participant_count < *0x1::option::borrow<u64>(&arg0.meta.max_participants));
        };
        let v1 = ParticipantKey{addr: arg1};
        0x2::dynamic_field::add<ParticipantKey, bool>(&mut arg0.id, v1, true);
        arg0.meta.participant_count = arg0.meta.participant_count + 1;
    }

    public(friend) fun add_settled_bytes(arg0: &mut UserStorage, arg1: u256) {
        arg0.settled_bytes = arg0.settled_bytes + arg1;
    }

    public(friend) fun add_settled_count(arg0: &mut UserStorage, arg1: u64) {
        arg0.settled_count = arg0.settled_count + arg1;
    }

    public(friend) fun add_total_settled(arg0: &mut DappStorage, arg1: u256) {
        arg0.total_settled = arg0.total_settled + arg1;
    }

    public(friend) fun add_write_bytes(arg0: &mut UserStorage, arg1: u256) {
        arg0.write_bytes = arg0.write_bytes + arg1;
    }

    public fun base_fee_per_write(arg0: &FrameworkFeeConfig) : u256 {
        arg0.base_fee_per_write
    }

    public fun bytes_fee_per_byte(arg0: &FrameworkFeeConfig) : u256 {
        arg0.bytes_fee_per_byte
    }

    public fun canonical_owner(arg0: &UserStorage) : address {
        arg0.canonical_owner
    }

    public(friend) fun clear_session(arg0: &mut UserStorage) {
        arg0.session_key = @0x0;
        arg0.session_expires_at = 0;
    }

    public fun coin_type_effective_at_ms(arg0: &FrameworkFeeConfig) : u64 {
        arg0.coin_type_effective_at_ms
    }

    public fun compute_unsettled_charge(arg0: &UserStorage, arg1: u256, arg2: u256) : u256 {
        arg1 * ((arg0.write_count - arg0.settled_count) as u256) + arg2 * (arg0.write_bytes - arg0.settled_bytes)
    }

    public fun credit_pool(arg0: &DappStorage) : u256 {
        arg0.credit_pool
    }

    public fun dapp_admin(arg0: &DappStorage) : address {
        arg0.admin
    }

    public fun dapp_base_fee_per_write(arg0: &DappStorage) : u256 {
        arg0.base_fee_per_write
    }

    public fun dapp_bytes_fee_per_byte(arg0: &DappStorage) : u256 {
        arg0.bytes_fee_per_byte
    }

    public fun dapp_cover_url(arg0: &DappStorage) : vector<0x1::ascii::String> {
        arg0.cover_url
    }

    public fun dapp_created_at(arg0: &DappStorage) : u64 {
        arg0.created_at
    }

    public fun dapp_description(arg0: &DappStorage) : 0x1::ascii::String {
        arg0.description
    }

    public fun dapp_name(arg0: &DappStorage) : 0x1::ascii::String {
        arg0.name
    }

    public fun dapp_package_ids(arg0: &DappStorage) : vector<address> {
        arg0.package_ids
    }

    public fun dapp_partners(arg0: &DappStorage) : vector<0x1::ascii::String> {
        arg0.partners
    }

    public fun dapp_paused(arg0: &DappStorage) : bool {
        arg0.paused
    }

    public fun dapp_pending_admin(arg0: &DappStorage) : address {
        arg0.pending_admin
    }

    public fun dapp_revenue_balance<T0>(arg0: &DappStorage) : u64 {
        let v0 = DappRevenueKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<DappRevenueKey<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<DappRevenueKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        }
    }

    public fun dapp_storage_dapp_key(arg0: &DappStorage) : 0x1::ascii::String {
        arg0.dapp_key
    }

    public fun dapp_storage_id(arg0: &DappStorage) : &0x2::object::UID {
        &arg0.id
    }

    public fun dapp_version(arg0: &DappStorage) : u32 {
        arg0.version
    }

    public fun dapp_website_url(arg0: &DappStorage) : 0x1::ascii::String {
        arg0.website_url
    }

    public fun dapp_write_fee_share_bps(arg0: &DappStorage) : u64 {
        arg0.write_fee_dapp_share_bps
    }

    public(friend) fun deduct_credit(arg0: &mut DappStorage, arg1: u256) {
        arg0.credit_pool = arg0.credit_pool - arg1;
    }

    public(friend) fun deduct_free_credit(arg0: &mut DappStorage, arg1: u256) {
        arg0.free_credit = arg0.free_credit - arg1;
    }

    public fun default_free_credit(arg0: &FrameworkConfig) : u256 {
        arg0.default_free_credit
    }

    public fun default_free_credit_duration_ms(arg0: &FrameworkConfig) : u64 {
        arg0.default_free_credit_duration_ms
    }

    public fun default_write_fee_dapp_share_bps(arg0: &FrameworkConfig) : u64 {
        arg0.default_write_fee_dapp_share_bps
    }

    public(friend) fun delete_global_field<T0: copy + drop>(arg0: &mut DappStorage, arg1: vector<vector<u8>>, arg2: vector<u8>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x1::vector::push_back<vector<u8>>(&mut arg1, arg2);
        if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1);
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
            0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_delete_field(v0, v0, arg1, arg2);
        } else {
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
        };
    }

    public(friend) fun delete_global_record<T0: copy + drop>(arg0: &mut DappStorage, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1));
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_delete_record(v0, v0, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v1));
            if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
                0x2::dynamic_field::remove<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1);
            };
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
            v1 = v1 + 1;
        };
        0x2::dynamic_field::remove<vector<vector<u8>>, bool>(&mut arg0.id, arg1);
    }

    public(friend) fun delete_user_field<T0: copy + drop>(arg0: &mut UserStorage, arg1: vector<vector<u8>>, arg2: vector<u8>) {
        0x1::vector::push_back<vector<u8>>(&mut arg1, arg2);
        if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1);
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
            0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_delete_field(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::address::to_ascii_string(arg0.canonical_owner), arg1, arg2);
        } else {
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
        };
    }

    public(friend) fun delete_user_record<T0: copy + drop>(arg0: &mut UserStorage, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1));
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_delete_record(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::address::to_ascii_string(arg0.canonical_owner), arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
            if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
                0x2::dynamic_field::remove<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1);
            };
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
            v0 = v0 + 1;
        };
        0x2::dynamic_field::remove<vector<vector<u8>>, bool>(&mut arg0.id, arg1);
    }

    public(friend) fun destroy_listing<T0>(arg0: Listing<T0>) : (vector<vector<u8>>, vector<u8>, vector<vector<u8>>, vector<vector<u8>>, address, u64, 0x1::option::Option<u64>, 0x1::ascii::String) {
        let Listing {
            id           : v0,
            record_data  : v1,
            record_type  : v2,
            record_key   : v3,
            field_names  : v4,
            seller       : v5,
            price        : v6,
            listed_until : v7,
            dapp_key     : v8,
            is_fungible  : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5, v6, v7, v8)
    }

    public(friend) fun destroy_object_storage<T0>(arg0: ObjectStorage<T0>) {
        let ObjectStorage {
            id          : v0,
            dapp_key    : _,
            object_type : _,
            entity_id   : _,
            data        : v4,
        } = arg0;
        0x2::bag::destroy_empty(v4);
        0x2::object::delete(v0);
    }

    public(friend) fun destroy_scene_permit<T0>(arg0: ScenePermit<T0>) {
        let ScenePermit {
            id          : v0,
            dapp_key    : _,
            permit_type : _,
            meta        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun destroy_scene_storage<T0>(arg0: SceneStorage<T0>) {
        let SceneStorage {
            id                   : v0,
            dapp_key             : _,
            scene_type           : _,
            authorized_permit_id : _,
            data                 : v4,
        } = arg0;
        0x2::bag::destroy_empty(v4);
        0x2::object::delete(v0);
    }

    public fun effective_free_credit(arg0: &DappStorage, arg1: u64) : u256 {
        let v0 = arg0.free_credit_expires_at;
        if (v0 == 0 || arg1 < v0) {
            arg0.free_credit
        } else {
            0
        }
    }

    public(friend) fun emit_fee_state_record<T0: copy + drop>(arg0: &DappStorage) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_dapp_fee_state_updated(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), arg0.base_fee_per_write, arg0.bytes_fee_per_byte, arg0.free_credit, arg0.credit_pool, arg0.total_settled);
    }

    public(friend) fun emit_revenue_state_record<T0: copy + drop, T1>(arg0: &DappStorage) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_dapp_revenue_state_updated(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), dapp_revenue_balance<T1>(arg0), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
    }

    public fun ensure_has_global_record<T0: copy + drop>(arg0: &DappStorage, arg1: vector<vector<u8>>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(has_global_record<T0>(arg0, arg1));
    }

    public fun ensure_has_not_global_record<T0: copy + drop>(arg0: &DappStorage, arg1: vector<vector<u8>>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(!has_global_record<T0>(arg0, arg1));
    }

    public fun ensure_has_not_user_record<T0: copy + drop>(arg0: &UserStorage, arg1: vector<vector<u8>>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(!has_user_record<T0>(arg0, arg1));
    }

    public fun ensure_has_user_record<T0: copy + drop>(arg0: &UserStorage, arg1: vector<vector<u8>>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(has_user_record<T0>(arg0, arg1));
    }

    public fun fee_effective_at_ms(arg0: &FrameworkFeeConfig) : u64 {
        arg0.fee_effective_at_ms
    }

    public fun fee_history(arg0: &FrameworkFeeConfig) : &vector<FeeHistoryEntry> {
        &arg0.fee_history
    }

    public fun fee_history_base_fee(arg0: &FeeHistoryEntry) : u256 {
        arg0.base_fee
    }

    public fun fee_history_bytes_fee(arg0: &FeeHistoryEntry) : u256 {
        arg0.bytes_fee
    }

    public fun fee_history_effective_from_ms(arg0: &FeeHistoryEntry) : u64 {
        arg0.effective_from_ms
    }

    public fun framework_admin(arg0: &FrameworkConfig) : address {
        arg0.admin
    }

    public fun framework_max_write_limit(arg0: &FrameworkConfig) : u64 {
        arg0.framework_max_write_limit
    }

    public fun framework_version(arg0: &DappHub) : u64 {
        arg0.version
    }

    public fun free_credit(arg0: &DappStorage) : u256 {
        arg0.free_credit
    }

    public fun free_credit_expires_at(arg0: &DappStorage) : u64 {
        arg0.free_credit_expires_at
    }

    public fun get_config(arg0: &DappHub) : &FrameworkConfig {
        &arg0.config
    }

    public(friend) fun get_config_mut(arg0: &mut DappHub) : &mut FrameworkConfig {
        &mut arg0.config
    }

    public fun get_fee_config(arg0: &DappHub) : &FrameworkFeeConfig {
        &arg0.fee_config
    }

    public(friend) fun get_fee_config_mut(arg0: &mut DappHub) : &mut FrameworkFeeConfig {
        &mut arg0.fee_config
    }

    public fun get_global_field<T0: copy + drop>(arg0: &DappStorage, arg1: vector<vector<u8>>, arg2: vector<u8>) : vector<u8> {
        0x1::vector::push_back<vector<u8>>(&mut arg1, arg2);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1));
        *0x2::dynamic_field::borrow<vector<vector<u8>>, vector<u8>>(&arg0.id, arg1)
    }

    public(friend) fun get_object_field<T0, T1: copy + drop + store>(arg0: &ObjectStorage<T0>, arg1: vector<u8>) : T1 {
        *0x2::bag::borrow<vector<u8>, T1>(&arg0.data, arg1)
    }

    public(friend) fun get_scene_field<T0, T1: copy + drop + store>(arg0: &SceneStorage<T0>, arg1: vector<u8>) : T1 {
        *0x2::bag::borrow<vector<u8>, T1>(&arg0.data, arg1)
    }

    public fun get_user_field<T0: copy + drop>(arg0: &UserStorage, arg1: vector<vector<u8>>, arg2: vector<u8>) : vector<u8> {
        0x1::vector::push_back<vector<u8>>(&mut arg1, arg2);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1));
        *0x2::dynamic_field::borrow<vector<vector<u8>>, vector<u8>>(&arg0.id, arg1)
    }

    public fun has_global_record<T0: copy + drop>(arg0: &DappStorage, arg1: vector<vector<u8>>) : bool {
        0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)
    }

    public(friend) fun has_object_field<T0, T1: copy + drop + store>(arg0: &ObjectStorage<T0>, arg1: vector<u8>) : bool {
        0x2::bag::contains_with_type<vector<u8>, T1>(&arg0.data, arg1)
    }

    public fun has_registered_user_storage(arg0: &DappStorage, arg1: address) : bool {
        let v0 = UserStorageRegistryKey{owner: arg1};
        0x2::dynamic_field::exists_<UserStorageRegistryKey>(&arg0.id, v0)
    }

    public(friend) fun has_scene_field<T0, T1: copy + drop + store>(arg0: &SceneStorage<T0>, arg1: vector<u8>) : bool {
        0x2::bag::contains_with_type<vector<u8>, T1>(&arg0.data, arg1)
    }

    public fun has_user_record<T0: copy + drop>(arg0: &UserStorage, arg1: vector<vector<u8>>) : bool {
        0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)
    }

    public(friend) fun increment_write_count(arg0: &mut UserStorage) {
        arg0.write_count = arg0.write_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<DappHub>(new(arg0));
    }

    public fun is_dapp_genesis_done<T0: copy + drop>(arg0: &DappHub) : bool {
        let v0 = DappGenesisKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<DappGenesisKey<T0>>(&arg0.id, v0)
    }

    public fun is_fee_config_initialized(arg0: &DappHub) : bool {
        arg0.fee_config.treasury != @0x0
    }

    public fun is_listing_expired<T0>(arg0: &Listing<T0>, arg1: u64) : bool {
        if (0x1::option::is_none<u64>(&arg0.listed_until)) {
            return false
        };
        arg1 >= *0x1::option::borrow<u64>(&arg0.listed_until)
    }

    public fun is_participant_in_scene_permit<T0>(arg0: &ScenePermit<T0>, arg1: address) : bool {
        let v0 = ParticipantKey{addr: arg1};
        0x2::dynamic_field::exists_<ParticipantKey>(&arg0.id, v0)
    }

    public fun is_scene_active(arg0: &PermitMetadata, arg1: u64) : bool {
        if (0x1::option::is_none<u64>(&arg0.expires_at)) {
            return true
        };
        arg1 < *0x1::option::borrow<u64>(&arg0.expires_at)
    }

    public fun is_scene_invitee(arg0: &PermitMetadata, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.invitees, &arg1)
    }

    public fun is_scene_participant(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = ParticipantKey{addr: arg1};
        0x2::dynamic_field::exists_<ParticipantKey>(arg0, v0)
    }

    public fun is_write_authorized(arg0: &UserStorage, arg1: address, arg2: u64) : bool {
        if (arg1 == arg0.canonical_owner) {
            return true
        };
        if (arg0.session_key == @0x0) {
            return false
        };
        if (arg1 != arg0.session_key) {
            return false
        };
        if (arg0.session_expires_at > 0 && arg2 >= arg0.session_expires_at) {
            return false
        };
        true
    }

    public fun listing_dapp_key<T0>(arg0: &Listing<T0>) : 0x1::ascii::String {
        arg0.dapp_key
    }

    public fun listing_field_names<T0>(arg0: &Listing<T0>) : &vector<vector<u8>> {
        &arg0.field_names
    }

    public fun listing_id<T0>(arg0: &Listing<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun listing_is_fungible<T0>(arg0: &Listing<T0>) : bool {
        arg0.is_fungible
    }

    public fun listing_listed_until<T0>(arg0: &Listing<T0>) : 0x1::option::Option<u64> {
        arg0.listed_until
    }

    public fun listing_price<T0>(arg0: &Listing<T0>) : u64 {
        arg0.price
    }

    public fun listing_record_data<T0>(arg0: &Listing<T0>) : &vector<vector<u8>> {
        &arg0.record_data
    }

    public fun listing_record_key<T0>(arg0: &Listing<T0>) : &vector<vector<u8>> {
        &arg0.record_key
    }

    public fun listing_record_type<T0>(arg0: &Listing<T0>) : &vector<u8> {
        &arg0.record_type
    }

    public fun listing_seller<T0>(arg0: &Listing<T0>) : address {
        arg0.seller
    }

    public fun marketplace_dapp_share_bps(arg0: &FrameworkConfig) : u64 {
        arg0.marketplace_dapp_share_bps
    }

    public fun marketplace_fee_bps(arg0: &FrameworkConfig) : u64 {
        arg0.marketplace_fee_bps
    }

    public(friend) fun new_dapp_storage<T0: copy + drop>(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: vector<address>, arg3: u64, arg4: address, arg5: u256, arg6: u64, arg7: u256, arg8: u256, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : DappStorage {
        DappStorage{
            id                       : 0x2::object::new(arg11),
            dapp_key                 : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            name                     : arg0,
            description              : arg1,
            website_url              : 0x1::ascii::string(b""),
            cover_url                : 0x1::vector::empty<0x1::ascii::String>(),
            partners                 : 0x1::vector::empty<0x1::ascii::String>(),
            package_ids              : arg2,
            created_at               : arg3,
            admin                    : arg4,
            pending_admin            : @0x0,
            version                  : 1,
            paused                   : false,
            free_credit              : arg5,
            free_credit_expires_at   : arg6,
            credit_pool              : 0,
            total_settled            : 0,
            base_fee_per_write       : arg7,
            bytes_fee_per_byte       : arg8,
            settlement_mode          : arg9,
            write_fee_dapp_share_bps : arg10,
        }
    }

    public(friend) fun new_listing<T0>(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: address, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::ascii::String, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) : Listing<T0> {
        Listing<T0>{
            id           : 0x2::object::new(arg9),
            record_data  : arg0,
            record_type  : arg1,
            record_key   : arg2,
            field_names  : arg3,
            seller       : arg4,
            price        : arg5,
            listed_until : arg6,
            dapp_key     : arg7,
            is_fungible  : arg8,
        }
    }

    public(friend) fun new_object_storage<T0>(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : ObjectStorage<T0> {
        let v0 = ObjectStorage<T0>{
            id          : 0x2::object::new(arg3),
            dapp_key    : arg0,
            object_type : arg1,
            entity_id   : arg2,
            data        : 0x2::bag::new(arg3),
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_object_created(v0.dapp_key, v0.object_type, 0x2::object::uid_to_address(&v0.id), v0.entity_id);
        v0
    }

    public(friend) fun new_scene_meta(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>) : PermitMetadata {
        PermitMetadata{
            expires_at        : arg0,
            invitees          : 0x1::vector::empty<address>(),
            invites_expire_at : 0x1::option::none<u64>(),
            max_participants  : arg1,
            participant_count : 0,
        }
    }

    public(friend) fun new_scene_meta_with_invitations(arg0: vector<address>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>) : PermitMetadata {
        PermitMetadata{
            expires_at        : arg2,
            invitees          : arg0,
            invites_expire_at : arg1,
            max_participants  : arg3,
            participant_count : 0,
        }
    }

    public(friend) fun new_scene_permit_with_invitations<T0>(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: vector<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : ScenePermit<T0> {
        let v0 = ScenePermit<T0>{
            id          : 0x2::object::new(arg6),
            dapp_key    : arg0,
            permit_type : arg1,
            meta        : new_scene_meta_with_invitations(arg2, arg3, arg4, arg5),
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_scene_permit_created(v0.dapp_key, v0.permit_type, 0x2::object::uid_to_address(&v0.id), v0.meta.expires_at, v0.meta.invites_expire_at, v0.meta.max_participants, v0.meta.participant_count);
        v0
    }

    public(friend) fun new_scene_permit_with_participants<T0>(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: vector<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : ScenePermit<T0> {
        let v0 = ScenePermit<T0>{
            id          : 0x2::object::new(arg5),
            dapp_key    : arg0,
            permit_type : arg1,
            meta        : new_scene_meta(arg3, arg4),
        };
        let v1 = 0;
        let v2 = 0x1::vector::length<address>(&arg2);
        while (v1 < v2) {
            let v3 = &mut v0;
            add_participant_in_scene_permit<T0>(v3, *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
        let v4 = 0x2::object::uid_to_address(&v0.id);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_scene_permit_created(v0.dapp_key, v0.permit_type, v4, v0.meta.expires_at, v0.meta.invites_expire_at, v0.meta.max_participants, v0.meta.participant_count);
        let v5 = 0;
        while (v5 < v2) {
            0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_scene_permit_join(v0.dapp_key, v0.permit_type, v4, *0x1::vector::borrow<address>(&arg2, v5));
            v5 = v5 + 1;
        };
        v0
    }

    public(friend) fun new_scene_storage_system<T0>(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : SceneStorage<T0> {
        let v0 = SceneStorage<T0>{
            id                   : 0x2::object::new(arg2),
            dapp_key             : arg0,
            scene_type           : arg1,
            authorized_permit_id : 0x1::option::none<address>(),
            data                 : 0x2::bag::new(arg2),
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_scene_created(v0.dapp_key, v0.scene_type, 0x2::object::uid_to_address(&v0.id), b"system", v0.authorized_permit_id);
        v0
    }

    public(friend) fun new_scene_storage_with_permit<T0, T1>(arg0: 0x1::ascii::String, arg1: vector<u8>, arg2: &ScenePermit<T0>, arg3: &mut 0x2::tx_context::TxContext) : SceneStorage<T1> {
        let v0 = SceneStorage<T1>{
            id                   : 0x2::object::new(arg3),
            dapp_key             : arg0,
            scene_type           : arg1,
            authorized_permit_id : 0x1::option::some<address>(0x2::object::uid_to_address(scene_permit_id<T0>(arg2))),
            data                 : 0x2::bag::new(arg3),
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_scene_created(v0.dapp_key, v0.scene_type, 0x2::object::uid_to_address(&v0.id), b"permit", v0.authorized_permit_id);
        v0
    }

    public(friend) fun new_user_storage<T0: copy + drop>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : UserStorage {
        UserStorage{
            id                 : 0x2::object::new(arg2),
            dapp_key           : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            canonical_owner    : arg0,
            session_key        : @0x0,
            session_expires_at : 0,
            write_count        : 0,
            settled_count      : 0,
            write_bytes        : 0,
            settled_bytes      : 0,
            write_limit        : arg1,
        }
    }

    public fun object_storage_dapp_key<T0>(arg0: &ObjectStorage<T0>) : 0x1::ascii::String {
        arg0.dapp_key
    }

    public fun object_storage_entity_id<T0>(arg0: &ObjectStorage<T0>) : &vector<u8> {
        &arg0.entity_id
    }

    public fun object_storage_id<T0>(arg0: &ObjectStorage<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun object_storage_id_mut<T0>(arg0: &mut ObjectStorage<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun object_storage_type<T0>(arg0: &ObjectStorage<T0>) : &vector<u8> {
        &arg0.object_type
    }

    public fun pending_base_fee(arg0: &FrameworkFeeConfig) : u256 {
        arg0.pending_base_fee
    }

    public fun pending_bytes_fee(arg0: &FrameworkFeeConfig) : u256 {
        arg0.pending_bytes_fee
    }

    public fun pending_coin_type(arg0: &FrameworkFeeConfig) : &0x1::option::Option<0x1::type_name::TypeName> {
        &arg0.pending_coin_type
    }

    public fun pending_framework_admin(arg0: &FrameworkConfig) : address {
        arg0.pending_admin
    }

    public fun pending_treasury(arg0: &FrameworkFeeConfig) : address {
        arg0.pending_treasury
    }

    public(friend) fun push_fee_history(arg0: &mut FrameworkFeeConfig, arg1: u256, arg2: u256, arg3: u64) {
        let v0 = FeeHistoryEntry{
            base_fee          : arg1,
            bytes_fee         : arg2,
            effective_from_ms : arg3,
        };
        0x1::vector::push_back<FeeHistoryEntry>(&mut arg0.fee_history, v0);
        if (0x1::vector::length<FeeHistoryEntry>(&arg0.fee_history) > 20) {
            0x1::vector::remove<FeeHistoryEntry>(&mut arg0.fee_history, 0);
        };
    }

    public(friend) fun register_object_entity_id(arg0: &mut DappStorage, arg1: vector<u8>, arg2: vector<u8>, arg3: address) {
        let v0 = ObjectEntityIdKey{
            type_tag  : arg1,
            entity_id : arg2,
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::entity_id_already_exists(!0x2::dynamic_field::exists_<ObjectEntityIdKey>(&arg0.id, v0));
        0x2::dynamic_field::add<ObjectEntityIdKey, address>(&mut arg0.id, v0, arg3);
    }

    public(friend) fun register_user_storage(arg0: &mut DappStorage, arg1: address) {
        let v0 = UserStorageRegistryKey{owner: arg1};
        0x2::dynamic_field::add<UserStorageRegistryKey, bool>(&mut arg0.id, v0, true);
    }

    public(friend) fun remove_object_field<T0, T1: copy + drop + store>(arg0: &mut ObjectStorage<T0>, arg1: vector<u8>) : T1 {
        0x2::bag::remove<vector<u8>, T1>(&mut arg0.data, arg1)
    }

    public(friend) fun remove_participant_in_scene_permit<T0>(arg0: &mut ScenePermit<T0>, arg1: address) {
        let v0 = ParticipantKey{addr: arg1};
        if (!0x2::dynamic_field::exists_<ParticipantKey>(&arg0.id, v0)) {
            return
        };
        let v1 = ParticipantKey{addr: arg1};
        0x2::dynamic_field::remove<ParticipantKey, bool>(&mut arg0.id, v1);
        arg0.meta.participant_count = arg0.meta.participant_count - 1;
    }

    public(friend) fun remove_scene_field<T0, T1: copy + drop + store>(arg0: &mut SceneStorage<T0>, arg1: vector<u8>) : T1 {
        0x2::bag::remove<vector<u8>, T1>(&mut arg0.data, arg1)
    }

    public fun scene_expires_at(arg0: &PermitMetadata) : 0x1::option::Option<u64> {
        arg0.expires_at
    }

    public fun scene_invitees(arg0: &PermitMetadata) : &vector<address> {
        &arg0.invitees
    }

    public fun scene_invites_expire_at(arg0: &PermitMetadata) : 0x1::option::Option<u64> {
        arg0.invites_expire_at
    }

    public fun scene_max_participants(arg0: &PermitMetadata) : 0x1::option::Option<u64> {
        arg0.max_participants
    }

    public fun scene_participant_count(arg0: &PermitMetadata) : u64 {
        arg0.participant_count
    }

    public fun scene_permit_dapp_key<T0>(arg0: &ScenePermit<T0>) : 0x1::ascii::String {
        arg0.dapp_key
    }

    public fun scene_permit_id<T0>(arg0: &ScenePermit<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun scene_permit_id_mut<T0>(arg0: &mut ScenePermit<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun scene_permit_meta<T0>(arg0: &ScenePermit<T0>) : &PermitMetadata {
        &arg0.meta
    }

    public(friend) fun scene_permit_meta_mut<T0>(arg0: &mut ScenePermit<T0>) : &mut PermitMetadata {
        &mut arg0.meta
    }

    public fun scene_permit_type<T0>(arg0: &ScenePermit<T0>) : &vector<u8> {
        &arg0.permit_type
    }

    public fun scene_storage_authorized_permit_id<T0>(arg0: &SceneStorage<T0>) : &0x1::option::Option<address> {
        &arg0.authorized_permit_id
    }

    public fun scene_storage_dapp_key<T0>(arg0: &SceneStorage<T0>) : 0x1::ascii::String {
        arg0.dapp_key
    }

    public fun scene_storage_id<T0>(arg0: &SceneStorage<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun scene_storage_id_mut<T0>(arg0: &mut SceneStorage<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun scene_storage_type<T0>(arg0: &SceneStorage<T0>) : &vector<u8> {
        &arg0.scene_type
    }

    public fun session_expires_at(arg0: &UserStorage) : u64 {
        arg0.session_expires_at
    }

    public fun session_key(arg0: &UserStorage) : address {
        arg0.session_key
    }

    public(friend) fun set_accepted_coin_type(arg0: &mut FrameworkFeeConfig, arg1: 0x1::type_name::TypeName) {
        arg0.accepted_coin_type = 0x1::option::some<0x1::type_name::TypeName>(arg1);
    }

    public(friend) fun set_base_fee_per_write(arg0: &mut FrameworkFeeConfig, arg1: u256) {
        arg0.base_fee_per_write = arg1;
    }

    public(friend) fun set_bytes_fee_per_byte(arg0: &mut FrameworkFeeConfig, arg1: u256) {
        arg0.bytes_fee_per_byte = arg1;
    }

    public(friend) fun set_coin_type_effective_at_ms(arg0: &mut FrameworkFeeConfig, arg1: u64) {
        arg0.coin_type_effective_at_ms = arg1;
    }

    public(friend) fun set_dapp_admin(arg0: &mut DappStorage, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun set_dapp_base_fee_per_write(arg0: &mut DappStorage, arg1: u256) {
        arg0.base_fee_per_write = arg1;
    }

    public(friend) fun set_dapp_bytes_fee_per_byte(arg0: &mut DappStorage, arg1: u256) {
        arg0.bytes_fee_per_byte = arg1;
    }

    public(friend) fun set_dapp_cover_url(arg0: &mut DappStorage, arg1: vector<0x1::ascii::String>) {
        arg0.cover_url = arg1;
    }

    public(friend) fun set_dapp_description(arg0: &mut DappStorage, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
    }

    public(friend) fun set_dapp_genesis_done<T0: copy + drop>(arg0: &mut DappHub) {
        let v0 = DappGenesisKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<DappGenesisKey<T0>, bool>(&mut arg0.id, v0, true);
    }

    public(friend) fun set_dapp_name(arg0: &mut DappStorage, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    public(friend) fun set_dapp_package_ids(arg0: &mut DappStorage, arg1: vector<address>) {
        arg0.package_ids = arg1;
    }

    public(friend) fun set_dapp_partners(arg0: &mut DappStorage, arg1: vector<0x1::ascii::String>) {
        arg0.partners = arg1;
    }

    public(friend) fun set_dapp_paused(arg0: &mut DappStorage, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun set_dapp_pending_admin(arg0: &mut DappStorage, arg1: address) {
        arg0.pending_admin = arg1;
    }

    public(friend) fun set_dapp_version(arg0: &mut DappStorage, arg1: u32) {
        arg0.version = arg1;
    }

    public(friend) fun set_dapp_website_url(arg0: &mut DappStorage, arg1: 0x1::ascii::String) {
        arg0.website_url = arg1;
    }

    public(friend) fun set_default_free_credit(arg0: &mut FrameworkConfig, arg1: u256, arg2: u64) {
        arg0.default_free_credit = arg1;
        arg0.default_free_credit_duration_ms = arg2;
    }

    public(friend) fun set_default_write_fee_dapp_share_bps(arg0: &mut FrameworkConfig, arg1: u64) {
        arg0.default_write_fee_dapp_share_bps = arg1;
    }

    public(friend) fun set_fee_effective_at_ms(arg0: &mut FrameworkFeeConfig, arg1: u64) {
        arg0.fee_effective_at_ms = arg1;
    }

    public(friend) fun set_framework_admin(arg0: &mut FrameworkConfig, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun set_framework_max_write_limit_cfg(arg0: &mut FrameworkConfig, arg1: u64) {
        arg0.framework_max_write_limit = arg1;
    }

    public(friend) fun set_framework_version(arg0: &mut DappHub, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun set_free_credit(arg0: &mut DappStorage, arg1: u256, arg2: u64) {
        arg0.free_credit = arg1;
        arg0.free_credit_expires_at = arg2;
    }

    public(friend) fun set_global_field<T0: copy + drop>(arg0: &mut DappStorage, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1));
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x1::vector::push_back<vector<u8>>(&mut arg1, arg2);
        if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1) = arg3;
        } else {
            0x2::dynamic_field::add<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1, arg3);
        };
        0x1::vector::pop_back<vector<u8>>(&mut arg1);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_set_field(v0, v0, arg1, arg2, arg3);
    }

    public(friend) fun set_global_record<T0: copy + drop>(arg0: &mut DappStorage, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: bool) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::length_mismatch(v0 == 0x1::vector::length<vector<u8>>(&arg3));
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (arg4) {
            0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_set_record(v1, v1, arg1, arg3);
            return
        };
        if (!0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<vector<vector<u8>>, bool>(&mut arg0.id, arg1, true);
        };
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<vector<u8>>(&mut arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v2));
            if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
                *0x2::dynamic_field::borrow_mut<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1) = *0x1::vector::borrow<vector<u8>>(&arg3, v2);
            } else {
                0x2::dynamic_field::add<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1, *0x1::vector::borrow<vector<u8>>(&arg3, v2));
            };
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
            v2 = v2 + 1;
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_set_record(v1, v1, arg1, arg3);
    }

    public(friend) fun set_marketplace_dapp_share_bps(arg0: &mut FrameworkConfig, arg1: u64) {
        arg0.marketplace_dapp_share_bps = arg1;
    }

    public(friend) fun set_marketplace_fee_bps(arg0: &mut FrameworkConfig, arg1: u64) {
        arg0.marketplace_fee_bps = arg1;
    }

    public(friend) fun set_object_field<T0, T1: copy + drop + store>(arg0: &mut ObjectStorage<T0>, arg1: vector<u8>, arg2: T1) {
        if (0x2::bag::contains_with_type<vector<u8>, T1>(&arg0.data, arg1)) {
            *0x2::bag::borrow_mut<vector<u8>, T1>(&mut arg0.data, arg1) = arg2;
        } else {
            0x2::bag::add<vector<u8>, T1>(&mut arg0.data, arg1, arg2);
        };
    }

    public(friend) fun set_pending_base_fee(arg0: &mut FrameworkFeeConfig, arg1: u256) {
        arg0.pending_base_fee = arg1;
    }

    public(friend) fun set_pending_bytes_fee(arg0: &mut FrameworkFeeConfig, arg1: u256) {
        arg0.pending_bytes_fee = arg1;
    }

    public(friend) fun set_pending_coin_type(arg0: &mut FrameworkFeeConfig, arg1: 0x1::option::Option<0x1::type_name::TypeName>) {
        arg0.pending_coin_type = arg1;
    }

    public(friend) fun set_pending_framework_admin(arg0: &mut FrameworkConfig, arg1: address) {
        arg0.pending_admin = arg1;
    }

    public(friend) fun set_pending_treasury(arg0: &mut FrameworkFeeConfig, arg1: address) {
        arg0.pending_treasury = arg1;
    }

    public(friend) fun set_scene_field<T0, T1: copy + drop + store>(arg0: &mut SceneStorage<T0>, arg1: vector<u8>, arg2: T1) {
        if (0x2::bag::contains_with_type<vector<u8>, T1>(&arg0.data, arg1)) {
            *0x2::bag::borrow_mut<vector<u8>, T1>(&mut arg0.data, arg1) = arg2;
        } else {
            0x2::bag::add<vector<u8>, T1>(&mut arg0.data, arg1, arg2);
        };
    }

    public(friend) fun set_session_expires_at(arg0: &mut UserStorage, arg1: u64) {
        arg0.session_expires_at = arg1;
    }

    public(friend) fun set_session_key(arg0: &mut UserStorage, arg1: address) {
        arg0.session_key = arg1;
    }

    public(friend) fun set_settled_to_write(arg0: &mut UserStorage) {
        arg0.settled_count = arg0.write_count;
        arg0.settled_bytes = arg0.write_bytes;
    }

    public(friend) fun set_settlement_mode(arg0: &mut DappStorage, arg1: u8) {
        arg0.settlement_mode = arg1;
    }

    public(friend) fun set_treasury(arg0: &mut FrameworkFeeConfig, arg1: address) {
        arg0.treasury = arg1;
    }

    public(friend) fun set_user_field<T0: copy + drop>(arg0: &mut UserStorage, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::invalid_key(0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1));
        0x1::vector::push_back<vector<u8>>(&mut arg1, arg2);
        if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1) = arg3;
        } else {
            0x2::dynamic_field::add<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1, arg3);
        };
        0x1::vector::pop_back<vector<u8>>(&mut arg1);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_set_field(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::address::to_ascii_string(arg0.canonical_owner), arg1, arg2, arg3);
    }

    public(friend) fun set_user_record<T0: copy + drop>(arg0: &mut UserStorage, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: bool) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::error::length_mismatch(v0 == 0x1::vector::length<vector<u8>>(&arg3));
        if (arg4) {
            0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_set_record(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::address::to_ascii_string(arg0.canonical_owner), arg1, arg3);
            return
        };
        if (!0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
            0x2::dynamic_field::add<vector<vector<u8>>, bool>(&mut arg0.id, arg1, true);
        };
        let v1 = 0;
        while (v1 < v0) {
            0x1::vector::push_back<vector<u8>>(&mut arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v1));
            if (0x2::dynamic_field::exists_<vector<vector<u8>>>(&arg0.id, arg1)) {
                *0x2::dynamic_field::borrow_mut<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1) = *0x1::vector::borrow<vector<u8>>(&arg3, v1);
            } else {
                0x2::dynamic_field::add<vector<vector<u8>>, vector<u8>>(&mut arg0.id, arg1, *0x1::vector::borrow<vector<u8>>(&arg3, v1));
            };
            0x1::vector::pop_back<vector<u8>>(&mut arg1);
            v1 = v1 + 1;
        };
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dubhe_events::emit_store_set_record(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::address::to_ascii_string(arg0.canonical_owner), arg1, arg3);
    }

    public(friend) fun set_user_write_limit(arg0: &mut UserStorage, arg1: u64) {
        arg0.write_limit = arg1;
    }

    public(friend) fun set_write_fee_dapp_share_bps(arg0: &mut DappStorage, arg1: u64) {
        arg0.write_fee_dapp_share_bps = arg1;
    }

    public fun settled_bytes(arg0: &UserStorage) : u256 {
        arg0.settled_bytes
    }

    public fun settled_count(arg0: &UserStorage) : u64 {
        arg0.settled_count
    }

    public fun settlement_mode(arg0: &DappStorage) : u8 {
        arg0.settlement_mode
    }

    public(friend) fun share_listing<T0>(arg0: Listing<T0>) {
        0x2::transfer::share_object<Listing<T0>>(arg0);
    }

    public(friend) fun share_object_storage<T0>(arg0: ObjectStorage<T0>) {
        0x2::transfer::share_object<ObjectStorage<T0>>(arg0);
    }

    public(friend) fun share_scene_permit<T0>(arg0: ScenePermit<T0>) {
        0x2::transfer::share_object<ScenePermit<T0>>(arg0);
    }

    public(friend) fun share_scene_storage<T0>(arg0: SceneStorage<T0>) {
        0x2::transfer::share_object<SceneStorage<T0>>(arg0);
    }

    public(friend) fun share_user_storage(arg0: UserStorage) {
        0x2::transfer::share_object<UserStorage>(arg0);
    }

    public(friend) fun take_dapp_revenue<T0>(arg0: &mut DappStorage) : 0x2::balance::Balance<T0> {
        let v0 = DappRevenueKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<DappRevenueKey<T0>>(&arg0.id, v0)) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<DappRevenueKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0))
        }
    }

    public fun total_settled(arg0: &DappStorage) : u256 {
        arg0.total_settled
    }

    public fun treasury(arg0: &FrameworkFeeConfig) : address {
        arg0.treasury
    }

    public(friend) fun unregister_object_entity_id(arg0: &mut DappStorage, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = ObjectEntityIdKey{
            type_tag  : arg1,
            entity_id : arg2,
        };
        if (0x2::dynamic_field::exists_<ObjectEntityIdKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<ObjectEntityIdKey, address>(&mut arg0.id, v0);
        };
    }

    public fun unsettled_bytes(arg0: &UserStorage) : u256 {
        arg0.write_bytes - arg0.settled_bytes
    }

    public fun unsettled_count(arg0: &UserStorage) : u64 {
        arg0.write_count - arg0.settled_count
    }

    public fun user_storage_dapp_key(arg0: &UserStorage) : 0x1::ascii::String {
        arg0.dapp_key
    }

    public fun user_storage_id(arg0: &UserStorage) : &0x2::object::UID {
        &arg0.id
    }

    public fun user_write_limit(arg0: &UserStorage) : u64 {
        arg0.write_limit
    }

    public fun write_bytes(arg0: &UserStorage) : u256 {
        arg0.write_bytes
    }

    public fun write_count(arg0: &UserStorage) : u64 {
        arg0.write_count
    }

    // decompiled from Move bytecode v6
}

