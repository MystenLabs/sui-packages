module 0x4a6237edc7f7e1766317a4ee731e85975f7b3b87fe8d7616f3023722b0991085::stats_objects {
    struct STATS_OBJECTS has drop {
        dummy_field: bool,
    }

    struct StatsAdminCap has store, key {
        id: 0x2::object::UID,
        package_version: u64,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        package_version: u64,
    }

    struct MintAuthorization has drop, store {
        reward_id: 0x2::object::ID,
        revoked: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        metadata_hash: vector<u8>,
        max_supply: u64,
        minted: u64,
        next_serial: u64,
        activated: bool,
        paused: bool,
        royalty_bps: u64,
        royalty_locked: bool,
        package_version: u64,
        mint_caps: 0x2::table::Table<0x2::object::ID, MintAuthorization>,
        replay_registry: 0x2::table::Table<address, bool>,
    }

    struct RewardDefinition has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        reward_key: vector<u8>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        metadata_hash: vector<u8>,
        schema_version: u64,
        package_version: u64,
        edition_size: u64,
        minted: u64,
        enabled: bool,
    }

    struct StatsObject has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        reward_key: vector<u8>,
        redemption_hash: vector<u8>,
        original_recipient: address,
        serial: u64,
        edition_size: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        metadata_hash: vector<u8>,
        schema_version: u64,
        package_version: u64,
        minted_at_epoch: u64,
    }

    struct StatsSoulboundObject has key {
        id: 0x2::object::UID,
        subject: address,
        provenance_hash: vector<u8>,
        schema_version: u64,
        package_version: u64,
        issued_at_epoch: u64,
    }

    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyRuleConfig has drop, store {
        package_version: u64,
    }

    struct ProtocolInitialized has copy, drop {
        stats_admin_cap_id: 0x2::object::ID,
        display_id: 0x2::object::ID,
        transfer_policy_id: 0x2::object::ID,
        transfer_policy_cap_id: 0x2::object::ID,
        package_version: u64,
        default_royalty_bps: u64,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        collection_admin_cap_id: 0x2::object::ID,
        max_supply: u64,
        royalty_bps: u64,
        package_version: u64,
    }

    struct CollectionActivated has copy, drop {
        collection_id: 0x2::object::ID,
        royalty_bps: u64,
    }

    struct CollectionPauseChanged has copy, drop {
        collection_id: 0x2::object::ID,
        paused: bool,
    }

    struct RewardCreated has copy, drop {
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        reward_key: vector<u8>,
        edition_size: u64,
        metadata_hash: vector<u8>,
        schema_version: u64,
        package_version: u64,
    }

    struct RewardEnabledChanged has copy, drop {
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        enabled: bool,
    }

    struct MintCapGranted has copy, drop {
        mint_cap_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        recipient: address,
    }

    struct MintCapRevoked has copy, drop {
        mint_cap_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
    }

    struct StatsObjectMinted has copy, drop {
        stats_object_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        reward_id: 0x2::object::ID,
        redemption_hash: vector<u8>,
        recipient: address,
        serial: u64,
        edition_size: u64,
        metadata_hash: vector<u8>,
        schema_version: u64,
        package_version: u64,
    }

    struct SoulboundObjectIssued has copy, drop {
        object_id: 0x2::object::ID,
        subject: address,
        provenance_hash: vector<u8>,
        schema_version: u64,
        package_version: u64,
    }

    public fun activate_collection(arg0: &CollectionAdminCap, arg1: &mut Collection) {
        assert_collection_admin(arg0, arg1);
        assert!(!arg1.activated, 7);
        arg1.activated = true;
        arg1.paused = false;
        arg1.royalty_locked = true;
        let v0 = CollectionActivated{
            collection_id : 0x2::object::id<Collection>(arg1),
            royalty_bps   : arg1.royalty_bps,
        };
        0x2::event::emit<CollectionActivated>(v0);
    }

    fun assert_collection_admin(arg0: &CollectionAdminCap, arg1: &Collection) {
        assert!(arg0.collection_id == 0x2::object::id<Collection>(arg1), 1);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13);
    }

    fun assert_mint_authorized(arg0: &MintCap, arg1: &Collection, arg2: &RewardDefinition) {
        assert!(arg0.package_version == 1, 21);
        let v0 = 0x2::object::id<Collection>(arg1);
        let v1 = 0x2::object::id<RewardDefinition>(arg2);
        assert!(arg0.collection_id == v0, 2);
        assert!(arg2.collection_id == v0, 2);
        assert!(arg0.reward_id == v1, 3);
        let v2 = 0x2::object::id<MintCap>(arg0);
        assert!(0x2::table::contains<0x2::object::ID, MintAuthorization>(&arg1.mint_caps, v2), 4);
        let v3 = 0x2::table::borrow<0x2::object::ID, MintAuthorization>(&arg1.mint_caps, v2);
        assert!(v3.reward_id == v1, 3);
        assert!(!v3.revoked, 5);
    }

    fun assert_reward_admin(arg0: &CollectionAdminCap, arg1: &Collection, arg2: &RewardDefinition) {
        assert_collection_admin(arg0, arg1);
        assert!(arg2.collection_id == 0x2::object::id<Collection>(arg1), 2);
    }

    fun assert_stats_admin(arg0: &StatsAdminCap) {
        assert!(arg0.package_version == 1, 21);
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun collection_id(arg0: &Collection) : 0x2::object::ID {
        0x2::object::id<Collection>(arg0)
    }

    public fun collection_is_activated(arg0: &Collection) : bool {
        arg0.activated
    }

    public fun collection_is_paused(arg0: &Collection) : bool {
        arg0.paused
    }

    public fun collection_max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public fun collection_metadata_hash(arg0: &Collection) : &vector<u8> {
        &arg0.metadata_hash
    }

    public fun collection_metadata_uri(arg0: &Collection) : &0x1::string::String {
        &arg0.metadata_uri
    }

    public fun collection_minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun collection_next_serial(arg0: &Collection) : u64 {
        arg0.next_serial
    }

    public fun collection_royalty_bps(arg0: &Collection) : u64 {
        arg0.royalty_bps
    }

    public fun collection_royalty_locked(arg0: &Collection) : bool {
        arg0.royalty_locked
    }

    public fun create_collection(arg0: &StatsAdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_stats_admin(arg0);
        let (v0, v1) = new_collection(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = CollectionCreated{
            collection_id           : 0x2::object::id<Collection>(&v3),
            collection_admin_cap_id : 0x2::object::id<CollectionAdminCap>(&v2),
            max_supply              : arg6,
            royalty_bps             : arg7,
            package_version         : 1,
        };
        0x2::event::emit<CollectionCreated>(v4);
        0x2::transfer::share_object<Collection>(v3);
        0x2::transfer::public_transfer<CollectionAdminCap>(v2, 0x2::tx_context::sender(arg8));
    }

    fun create_protocol_objects(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::display::Display<StatsObject>, 0x2::transfer_policy::TransferPolicy<StatsObject>, 0x2::transfer_policy::TransferPolicyCap<StatsObject>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{metadata_uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://anavrinstats.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Stats"));
        let v4 = 0x2::display::new_with_fields<StatsObject>(arg0, v0, v2, arg1);
        0x2::display::update_version<StatsObject>(&mut v4);
        let (v5, v6) = 0x2::transfer_policy::new<StatsObject>(arg0, arg1);
        let v7 = v6;
        let v8 = v5;
        let v9 = RoyaltyRule{dummy_field: false};
        let v10 = RoyaltyRuleConfig{package_version: 1};
        0x2::transfer_policy::add_rule<StatsObject, RoyaltyRule, RoyaltyRuleConfig>(v9, &mut v8, &v7, v10);
        (v4, v8, v7)
    }

    public fun create_reward(arg0: &CollectionAdminCap, arg1: &Collection, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = new_reward(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = RewardCreated{
            collection_id   : 0x2::object::id<Collection>(arg1),
            reward_id       : 0x2::object::id<RewardDefinition>(&v0),
            reward_key      : clone_bytes(&v0.reward_key),
            edition_size    : arg9,
            metadata_hash   : clone_bytes(&v0.metadata_hash),
            schema_version  : arg8,
            package_version : 1,
        };
        0x2::event::emit<RewardCreated>(v1);
        0x2::transfer::public_share_object<RewardDefinition>(v0);
    }

    public fun default_royalty_bps() : u64 {
        500
    }

    public fun derive_redemption_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg2) == 32, 14);
        let v0 = b"stats.objects.redemption.v1";
        let v1 = 1;
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg1));
        0x1::vector::append<u8>(&mut v0, clone_bytes(arg2));
        0x2::hash::blake2b256(&v0)
    }

    public fun disable_reward(arg0: &CollectionAdminCap, arg1: &Collection, arg2: &mut RewardDefinition) {
        assert_reward_admin(arg0, arg1, arg2);
        arg2.enabled = false;
        let v0 = RewardEnabledChanged{
            collection_id : 0x2::object::id<Collection>(arg1),
            reward_id     : 0x2::object::id<RewardDefinition>(arg2),
            enabled       : false,
        };
        0x2::event::emit<RewardEnabledChanged>(v0);
    }

    public fun enable_reward(arg0: &CollectionAdminCap, arg1: &Collection, arg2: &mut RewardDefinition) {
        assert_reward_admin(arg0, arg1, arg2);
        arg2.enabled = true;
        let v0 = RewardEnabledChanged{
            collection_id : 0x2::object::id<Collection>(arg1),
            reward_id     : 0x2::object::id<RewardDefinition>(arg2),
            enabled       : true,
        };
        0x2::event::emit<RewardEnabledChanged>(v0);
    }

    public fun grant_collection_admin(arg0: &StatsAdminCap, arg1: &Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_stats_admin(arg0);
        let v0 = CollectionAdminCap{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::id<Collection>(arg1),
        };
        0x2::transfer::public_transfer<CollectionAdminCap>(v0, arg2);
    }

    public fun grant_mint_cap(arg0: &CollectionAdminCap, arg1: &mut Collection, arg2: &RewardDefinition, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = new_mint_cap(arg0, arg1, arg2, arg4);
        let v1 = MintCapGranted{
            mint_cap_id   : 0x2::object::id<MintCap>(&v0),
            collection_id : 0x2::object::id<Collection>(arg1),
            reward_id     : 0x2::object::id<RewardDefinition>(arg2),
            recipient     : arg3,
        };
        0x2::event::emit<MintCapGranted>(v1);
        0x2::transfer::public_transfer<MintCap>(v0, arg3);
    }

    fun init(arg0: STATS_OBJECTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<STATS_OBJECTS>(arg0, arg1);
        let (v2, v3, v4) = create_protocol_objects(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = StatsAdminCap{
            id              : 0x2::object::new(arg1),
            package_version : 1,
        };
        let v9 = ProtocolInitialized{
            stats_admin_cap_id     : 0x2::object::id<StatsAdminCap>(&v8),
            display_id             : 0x2::object::id<0x2::display::Display<StatsObject>>(&v7),
            transfer_policy_id     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<StatsObject>>(&v6),
            transfer_policy_cap_id : 0x2::object::id<0x2::transfer_policy::TransferPolicyCap<StatsObject>>(&v5),
            package_version        : 1,
            default_royalty_bps    : 500,
        };
        0x2::event::emit<ProtocolInitialized>(v9);
        0x2::transfer::public_transfer<StatsAdminCap>(v8, v0);
        0x2::transfer::public_transfer<0x2::display::Display<StatsObject>>(v7, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<StatsObject>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<StatsObject>>(v5, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun issue_soulbound_to(arg0: &StatsAdminCap, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_stats_admin(arg0);
        assert_hash(&arg2);
        assert!(arg3 > 0, 18);
        let v0 = StatsSoulboundObject{
            id              : 0x2::object::new(arg4),
            subject         : arg1,
            provenance_hash : arg2,
            schema_version  : arg3,
            package_version : 1,
            issued_at_epoch : 0x2::tx_context::epoch(arg4),
        };
        let v1 = SoulboundObjectIssued{
            object_id       : 0x2::object::id<StatsSoulboundObject>(&v0),
            subject         : arg1,
            provenance_hash : clone_bytes(&v0.provenance_hash),
            schema_version  : arg3,
            package_version : 1,
        };
        0x2::event::emit<SoulboundObjectIssued>(v1);
        0x2::transfer::transfer<StatsSoulboundObject>(v0, arg1);
    }

    public fun mint_cap_collection_id(arg0: &MintCap) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun mint_cap_is_revoked(arg0: &Collection, arg1: &MintCap) : bool {
        if (!0x2::table::contains<0x2::object::ID, MintAuthorization>(&arg0.mint_caps, 0x2::object::id<MintCap>(arg1))) {
            return true
        };
        0x2::table::borrow<0x2::object::ID, MintAuthorization>(&arg0.mint_caps, 0x2::object::id<MintCap>(arg1)).revoked
    }

    public fun mint_cap_package_version(arg0: &MintCap) : u64 {
        arg0.package_version
    }

    public fun mint_cap_reward_id(arg0: &MintCap) : 0x2::object::ID {
        arg0.reward_id
    }

    fun mint_internal(arg0: &MintCap, arg1: &mut Collection, arg2: &mut RewardDefinition, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : StatsObject {
        assert_mint_authorized(arg0, arg1, arg2);
        assert!(arg1.activated, 6);
        assert!(!arg1.paused, 8);
        assert!(arg2.enabled, 9);
        assert!(arg1.minted < arg1.max_supply, 10);
        assert!(arg2.minted < arg2.edition_size, 11);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 14);
        let v0 = derive_redemption_hash(0x2::object::id<Collection>(arg1), 0x2::object::id<RewardDefinition>(arg2), &arg4);
        let v1 = 0x2::address::from_bytes(clone_bytes(&v0));
        assert!(!0x2::table::contains<address, bool>(&arg1.replay_registry, v1), 12);
        0x2::table::add<address, bool>(&mut arg1.replay_registry, v1, true);
        let v2 = arg1.next_serial;
        arg1.next_serial = v2 + 1;
        arg1.minted = arg1.minted + 1;
        arg2.minted = arg2.minted + 1;
        let v3 = StatsObject{
            id                 : 0x2::object::new(arg5),
            collection_id      : 0x2::object::id<Collection>(arg1),
            reward_id          : 0x2::object::id<RewardDefinition>(arg2),
            reward_key         : clone_bytes(&arg2.reward_key),
            redemption_hash    : v0,
            original_recipient : arg3,
            serial             : v2,
            edition_size       : arg2.edition_size,
            name               : arg2.name,
            description        : arg2.description,
            image_url          : arg2.image_url,
            metadata_uri       : arg2.metadata_uri,
            metadata_hash      : clone_bytes(&arg2.metadata_hash),
            schema_version     : arg2.schema_version,
            package_version    : 1,
            minted_at_epoch    : 0x2::tx_context::epoch(arg5),
        };
        let v4 = StatsObjectMinted{
            stats_object_id : 0x2::object::id<StatsObject>(&v3),
            collection_id   : 0x2::object::id<Collection>(arg1),
            reward_id       : 0x2::object::id<RewardDefinition>(arg2),
            redemption_hash : clone_bytes(&v3.redemption_hash),
            recipient       : arg3,
            serial          : v2,
            edition_size    : arg2.edition_size,
            metadata_hash   : clone_bytes(&v3.metadata_hash),
            schema_version  : arg2.schema_version,
            package_version : 1,
        };
        0x2::event::emit<StatsObjectMinted>(v4);
        v3
    }

    public fun mint_to(arg0: &MintCap, arg1: &mut Collection, arg2: &mut RewardDefinition, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<StatsObject>(mint_internal(arg0, arg1, arg2, arg3, arg4, arg5), arg3);
    }

    fun new_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (Collection, CollectionAdminCap) {
        assert!(0x1::vector::length<u8>(&arg0) > 0 && 0x1::vector::length<u8>(&arg1) > 0, 18);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 18);
        assert_hash(&arg4);
        assert!(arg5 > 0, 15);
        assert!(arg6 <= 10000, 16);
        let v0 = Collection{
            id              : 0x2::object::new(arg7),
            name            : 0x1::string::utf8(arg0),
            symbol          : 0x1::string::utf8(arg1),
            description     : 0x1::string::utf8(arg2),
            metadata_uri    : 0x1::string::utf8(arg3),
            metadata_hash   : arg4,
            max_supply      : arg5,
            minted          : 0,
            next_serial     : 1,
            activated       : false,
            paused          : true,
            royalty_bps     : arg6,
            royalty_locked  : false,
            package_version : 1,
            mint_caps       : 0x2::table::new<0x2::object::ID, MintAuthorization>(arg7),
            replay_registry : 0x2::table::new<address, bool>(arg7),
        };
        let v1 = CollectionAdminCap{
            id            : 0x2::object::new(arg7),
            collection_id : 0x2::object::id<Collection>(&v0),
        };
        (v0, v1)
    }

    fun new_mint_cap(arg0: &CollectionAdminCap, arg1: &mut Collection, arg2: &RewardDefinition, arg3: &mut 0x2::tx_context::TxContext) : MintCap {
        assert_reward_admin(arg0, arg1, arg2);
        let v0 = MintCap{
            id              : 0x2::object::new(arg3),
            collection_id   : 0x2::object::id<Collection>(arg1),
            reward_id       : 0x2::object::id<RewardDefinition>(arg2),
            package_version : 1,
        };
        let v1 = MintAuthorization{
            reward_id : 0x2::object::id<RewardDefinition>(arg2),
            revoked   : false,
        };
        0x2::table::add<0x2::object::ID, MintAuthorization>(&mut arg1.mint_caps, 0x2::object::id<MintCap>(&v0), v1);
        v0
    }

    fun new_reward(arg0: &CollectionAdminCap, arg1: &Collection, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : RewardDefinition {
        assert_collection_admin(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg3) > 0, 18);
        assert!(0x1::vector::length<u8>(&arg6) > 0, 18);
        assert_hash(&arg7);
        assert!(arg8 > 0, 18);
        assert!(arg9 > 0 && arg9 <= arg1.max_supply, 15);
        RewardDefinition{
            id              : 0x2::object::new(arg10),
            collection_id   : 0x2::object::id<Collection>(arg1),
            reward_key      : arg2,
            name            : 0x1::string::utf8(arg3),
            description     : 0x1::string::utf8(arg4),
            image_url       : 0x1::string::utf8(arg5),
            metadata_uri    : 0x1::string::utf8(arg6),
            metadata_hash   : arg7,
            schema_version  : arg8,
            package_version : 1,
            edition_size    : arg9,
            minted          : 0,
            enabled         : true,
        }
    }

    public fun package_version() : u64 {
        1
    }

    public fun pause_collection(arg0: &CollectionAdminCap, arg1: &mut Collection) {
        assert_collection_admin(arg0, arg1);
        assert!(arg1.activated, 6);
        arg1.paused = true;
        let v0 = CollectionPauseChanged{
            collection_id : 0x2::object::id<Collection>(arg1),
            paused        : true,
        };
        0x2::event::emit<CollectionPauseChanged>(v0);
    }

    public fun pay_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<StatsObject>, arg1: &Collection, arg2: &StatsObject, arg3: &mut 0x2::transfer_policy::TransferRequest<StatsObject>, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg1.activated && arg1.royalty_locked, 6);
        assert!(arg2.collection_id == 0x2::object::id<Collection>(arg1), 2);
        assert!(0x2::object::id<StatsObject>(arg2) == 0x2::transfer_policy::item<StatsObject>(arg3), 20);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == royalty_due(0x2::transfer_policy::paid<StatsObject>(arg3), arg1.royalty_bps), 19);
        let v0 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<StatsObject, RoyaltyRule>(v0, arg0, arg4);
        let v1 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<StatsObject, RoyaltyRule>(v1, arg3);
    }

    public fun resume_collection(arg0: &CollectionAdminCap, arg1: &mut Collection) {
        assert_collection_admin(arg0, arg1);
        assert!(arg1.activated, 6);
        arg1.paused = false;
        let v0 = CollectionPauseChanged{
            collection_id : 0x2::object::id<Collection>(arg1),
            paused        : false,
        };
        0x2::event::emit<CollectionPauseChanged>(v0);
    }

    public fun revoke_mint_cap(arg0: &CollectionAdminCap, arg1: &mut Collection, arg2: 0x2::object::ID) {
        assert_collection_admin(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, MintAuthorization>(&arg1.mint_caps, arg2), 4);
        0x2::table::borrow_mut<0x2::object::ID, MintAuthorization>(&mut arg1.mint_caps, arg2).revoked = true;
        let v0 = MintCapRevoked{
            mint_cap_id   : arg2,
            collection_id : 0x2::object::id<Collection>(arg1),
            reward_id     : 0x2::table::borrow<0x2::object::ID, MintAuthorization>(&arg1.mint_caps, arg2).reward_id,
        };
        0x2::event::emit<MintCapRevoked>(v0);
    }

    public fun reward_collection_id(arg0: &RewardDefinition) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun reward_edition_size(arg0: &RewardDefinition) : u64 {
        arg0.edition_size
    }

    public fun reward_id(arg0: &RewardDefinition) : 0x2::object::ID {
        0x2::object::id<RewardDefinition>(arg0)
    }

    public fun reward_is_enabled(arg0: &RewardDefinition) : bool {
        arg0.enabled
    }

    public fun reward_metadata_hash(arg0: &RewardDefinition) : &vector<u8> {
        &arg0.metadata_hash
    }

    public fun reward_minted(arg0: &RewardDefinition) : u64 {
        arg0.minted
    }

    public fun royalty_due(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 16);
        arg0 / 10000 * arg1 + arg0 % 10000 * arg1 / 10000
    }

    public fun schema_version() : u64 {
        1
    }

    public fun set_royalty_bps(arg0: &CollectionAdminCap, arg1: &mut Collection, arg2: u64) {
        assert_collection_admin(arg0, arg1);
        assert!(!arg1.royalty_locked, 17);
        assert!(arg2 <= 10000, 16);
        arg1.royalty_bps = arg2;
    }

    public fun stats_object_collection_id(arg0: &StatsObject) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun stats_object_edition_size(arg0: &StatsObject) : u64 {
        arg0.edition_size
    }

    public fun stats_object_metadata_hash(arg0: &StatsObject) : &vector<u8> {
        &arg0.metadata_hash
    }

    public fun stats_object_original_recipient(arg0: &StatsObject) : address {
        arg0.original_recipient
    }

    public fun stats_object_package_version(arg0: &StatsObject) : u64 {
        arg0.package_version
    }

    public fun stats_object_redemption_hash(arg0: &StatsObject) : &vector<u8> {
        &arg0.redemption_hash
    }

    public fun stats_object_reward_id(arg0: &StatsObject) : 0x2::object::ID {
        arg0.reward_id
    }

    public fun stats_object_schema_version(arg0: &StatsObject) : u64 {
        arg0.schema_version
    }

    public fun stats_object_serial(arg0: &StatsObject) : u64 {
        arg0.serial
    }

    // decompiled from Move bytecode v7
}

