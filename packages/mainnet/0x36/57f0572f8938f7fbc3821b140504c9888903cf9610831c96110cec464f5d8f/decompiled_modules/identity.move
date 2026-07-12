module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity {
    struct ProofOfGenesis has store {
        creation_mode: u8,
        persona_commitment: vector<u8>,
        source_commitment: vector<u8>,
        creator: address,
        schema_version: u64,
        recorded_at_ms: u64,
    }

    struct ProfileRef has copy, drop, store {
        uri: 0x1::string::String,
        content_hash: vector<u8>,
        schema_version: u64,
    }

    struct ManifestRef has copy, drop, store {
        uri: 0x1::string::String,
        content_hash: vector<u8>,
        schema_version: u64,
    }

    struct FundingWalletRef has copy, drop, store {
        chain_namespace: 0x1::string::String,
        wallet_ref: 0x1::string::String,
        purpose: 0x1::string::String,
    }

    struct ProviderPolicyRef has copy, drop, store {
        provider: address,
        policy_uri: 0x1::string::String,
        policy_hash: vector<u8>,
        schema_version: u64,
    }

    struct LivingCharacter has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        protocol_version: u64,
        paused: bool,
        proof: ProofOfGenesis,
        profile: ProfileRef,
        manifest: ManifestRef,
        funding_wallets: vector<FundingWalletRef>,
        provider_policies: vector<ProviderPolicyRef>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct CharacterMinted has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        creator: address,
        creation_mode: u8,
        profile_uri: 0x1::string::String,
        manifest_uri: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ProfileUpdated has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        profile_uri: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ManifestUpdated has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        manifest_uri: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct PauseUpdated has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        paused: bool,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct FundingWalletAdded has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        chain_namespace: 0x1::string::String,
        wallet_ref: 0x1::string::String,
        purpose: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ProviderPolicyAdded has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        provider: address,
        policy_uri: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct OwnerTransferred has copy, drop {
        character_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        timestamp_ms: u64,
    }

    struct OwnerTransferredWithRotation has copy, drop {
        character_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        previous_secrets_hash: vector<u8>,
        new_secrets_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct OwnerReassignedInPlace has copy, drop {
        character_id: 0x2::object::ID,
        previous_owner: address,
        new_owner: address,
        previous_secrets_hash: vector<u8>,
        new_secrets_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct GenesisConsent has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        character_kind: u8,
        consent_ref: 0x1::string::String,
        consent_hash: vector<u8>,
        creator: address,
        schema_version: u64,
        recorded_at_ms: u64,
    }

    struct GenesisConsentRecorded has copy, drop {
        consent_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        character_kind: u8,
        consent_ref: 0x1::string::String,
        creator: address,
        timestamp_ms: u64,
    }

    struct CharacterHub has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        paused: bool,
        owner_nonce: u64,
        recovery_epoch: u64,
        revocation_registry_id: 0x1::option::Option<0x2::object::ID>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct HubRegistrationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CharacterHubCreated has copy, drop {
        hub_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        paused: bool,
        timestamp_ms: u64,
    }

    struct CharacterHubUpdated has copy, drop {
        hub_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        previous_owner: address,
        owner: address,
        paused: bool,
        owner_nonce: u64,
        recovery_epoch: u64,
        source: u8,
        timestamp_ms: u64,
    }

    entry fun add_funding_wallet(arg0: &mut LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg5));
        assert_not_paused(arg0);
        assert_valid_ref(&arg1, 11);
        assert_valid_ref(&arg2, 11);
        assert_valid_ref(&arg3, 11);
        let v0 = FundingWalletRef{
            chain_namespace : 0x1::string::utf8(arg1),
            wallet_ref      : 0x1::string::utf8(arg2),
            purpose         : 0x1::string::utf8(arg3),
        };
        0x1::vector::push_back<FundingWalletRef>(&mut arg0.funding_wallets, v0);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::vector::borrow<FundingWalletRef>(&arg0.funding_wallets, 0x1::vector::length<FundingWalletRef>(&arg0.funding_wallets) - 1);
        let v2 = FundingWalletAdded{
            character_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner           : arg0.owner,
            chain_namespace : v1.chain_namespace,
            wallet_ref      : v1.wallet_ref,
            purpose         : v1.purpose,
            timestamp_ms    : arg0.updated_at_ms,
        };
        0x2::event::emit<FundingWalletAdded>(v2);
    }

    entry fun add_provider_policy(arg0: &mut LivingCharacter, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg6));
        assert_not_paused(arg0);
        assert_valid_ref(&arg2, 12);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 6);
        assert!(0x1::vector::length<u8>(&arg3) <= 128, 10);
        let v0 = ProviderPolicyRef{
            provider       : arg1,
            policy_uri     : 0x1::string::utf8(arg2),
            policy_hash    : arg3,
            schema_version : arg4,
        };
        0x1::vector::push_back<ProviderPolicyRef>(&mut arg0.provider_policies, v0);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v1 = ProviderPolicyAdded{
            character_id : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            provider     : arg1,
            policy_uri   : 0x1::vector::borrow<ProviderPolicyRef>(&arg0.provider_policies, 0x1::vector::length<ProviderPolicyRef>(&arg0.provider_policies) - 1).policy_uri,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<ProviderPolicyAdded>(v1);
    }

    public fun assert_hub_character(arg0: &CharacterHub, arg1: 0x2::object::ID) {
        assert!(arg0.character_id == arg1, 18);
    }

    public fun assert_hub_not_paused(arg0: &CharacterHub) {
        assert!(!arg0.paused, 2);
    }

    public fun assert_hub_owner(arg0: &CharacterHub, arg1: address) {
        assert!(arg0.owner == arg1, 1);
    }

    public fun assert_hub_registry(arg0: &CharacterHub, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.revocation_registry_id), 22);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.revocation_registry_id) == arg1, 23);
    }

    public fun assert_not_paused(arg0: &LivingCharacter) {
        assert!(!arg0.paused, 2);
    }

    public fun assert_owner(arg0: &LivingCharacter, arg1: address) {
        assert!(arg0.owner == arg1, 1);
    }

    fun assert_valid_character_kind(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 16);
    }

    fun assert_valid_mint_args(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>) {
        assert!(arg0 == 1 || arg0 == 2, 7);
        assert!(0x1::vector::length<u8>(arg1) > 0, 3);
        assert!(0x1::vector::length<u8>(arg1) <= 128, 8);
        assert!(0x1::vector::length<u8>(arg2) > 0, 6);
        assert_valid_uri_hash(arg3, arg4, 4);
        assert_valid_uri_hash(arg5, arg6, 5);
    }

    fun assert_valid_ref(arg0: &vector<u8>, arg1: u64) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 6);
        assert!(0x1::vector::length<u8>(arg0) <= 512, arg1);
    }

    fun assert_valid_uri_hash(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) {
        assert!(0x1::vector::length<u8>(arg0) > 0, arg2);
        assert!(0x1::vector::length<u8>(arg0) <= 2048, 9);
        assert!(0x1::vector::length<u8>(arg1) > 0, 6);
        assert!(0x1::vector::length<u8>(arg1) <= 128, 10);
    }

    public(friend) fun bind_hub_revocation_registry_id(arg0: &mut CharacterHub, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.revocation_registry_id), 21);
        0x1::option::fill<0x2::object::ID>(&mut arg0.revocation_registry_id, arg1);
    }

    public fun character_kind_preserved_person() : u8 {
        1
    }

    public fun character_kind_standard() : u8 {
        0
    }

    public fun character_kind_voice_clone() : u8 {
        2
    }

    public fun consent_character_id(arg0: &GenesisConsent) : 0x2::object::ID {
        arg0.character_id
    }

    public fun consent_character_kind(arg0: &GenesisConsent) : u8 {
        arg0.character_kind
    }

    public fun consent_creator(arg0: &GenesisConsent) : address {
        arg0.creator
    }

    public fun consent_ref(arg0: &GenesisConsent) : 0x1::string::String {
        arg0.consent_ref
    }

    fun consent_required(arg0: u8) : bool {
        arg0 == 1 || arg0 == 2
    }

    fun create(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : LivingCharacter {
        assert_valid_mint_args(arg0, &arg1, &arg2, &arg4, &arg5, &arg6, &arg7);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = ProfileRef{
            uri            : 0x1::string::utf8(arg4),
            content_hash   : arg5,
            schema_version : 1,
        };
        let v3 = ManifestRef{
            uri            : 0x1::string::utf8(arg6),
            content_hash   : arg7,
            schema_version : 1,
        };
        let v4 = ProofOfGenesis{
            creation_mode      : arg0,
            persona_commitment : arg2,
            source_commitment  : arg3,
            creator            : v0,
            schema_version     : 1,
            recorded_at_ms     : v1,
        };
        let v5 = LivingCharacter{
            id                : 0x2::object::new(arg9),
            owner             : v0,
            name              : 0x1::string::utf8(arg1),
            protocol_version  : 2,
            paused            : false,
            proof             : v4,
            profile           : v2,
            manifest          : v3,
            funding_wallets   : 0x1::vector::empty<FundingWalletRef>(),
            provider_policies : 0x1::vector::empty<ProviderPolicyRef>(),
            created_at_ms     : v1,
            updated_at_ms     : v1,
        };
        let v6 = CharacterMinted{
            character_id  : 0x2::object::uid_to_inner(&v5.id),
            owner         : v0,
            creator       : v0,
            creation_mode : arg0,
            profile_uri   : v5.profile.uri,
            manifest_uri  : v5.manifest.uri,
            timestamp_ms  : v1,
        };
        0x2::event::emit<CharacterMinted>(v6);
        v5
    }

    public fun create_classified_prompt(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : LivingCharacter {
        create(2, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun create_direct_prompt(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : LivingCharacter {
        create(1, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    fun do_reassign_owner_with_rotation(arg0: &mut LivingCharacter, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg5));
        assert_not_paused(arg0);
        assert!(0x1::vector::length<u8>(&arg2) <= 128, 10);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 13);
        assert!(0x1::vector::length<u8>(&arg3) <= 128, 10);
        assert!(arg3 != arg2, 13);
        arg0.owner = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = OwnerReassignedInPlace{
            character_id          : 0x2::object::uid_to_inner(&arg0.id),
            previous_owner        : arg0.owner,
            new_owner             : arg1,
            previous_secrets_hash : arg2,
            new_secrets_hash      : arg3,
            timestamp_ms          : arg0.updated_at_ms,
        };
        0x2::event::emit<OwnerReassignedInPlace>(v0);
    }

    fun do_transfer_with_rotation(arg0: LivingCharacter, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner(&arg0, 0x2::tx_context::sender(arg5));
        assert_not_paused(&arg0);
        assert!(0x1::vector::length<u8>(&arg2) <= 128, 10);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 13);
        assert!(0x1::vector::length<u8>(&arg3) <= 128, 10);
        assert!(arg3 != arg2, 13);
        arg0.owner = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = OwnerTransferredWithRotation{
            character_id          : 0x2::object::uid_to_inner(&arg0.id),
            previous_owner        : arg0.owner,
            new_owner             : arg1,
            previous_secrets_hash : arg2,
            new_secrets_hash      : arg3,
            timestamp_ms          : arg0.updated_at_ms,
        };
        0x2::event::emit<OwnerTransferredWithRotation>(v0);
        0x2::transfer::public_transfer<LivingCharacter>(arg0, arg1);
    }

    public fun funding_wallet_count(arg0: &LivingCharacter) : u64 {
        0x1::vector::length<FundingWalletRef>(&arg0.funding_wallets)
    }

    public(friend) fun guardian_rotate_hub_owner(arg0: &mut CharacterHub, arg1: address, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg0.owner == arg1, 1);
        arg0.owner = arg2;
        arg0.owner_nonce = arg0.owner_nonce + 1;
        arg0.recovery_epoch = arg0.recovery_epoch + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = CharacterHubUpdated{
            hub_id         : 0x2::object::uid_to_inner(&arg0.id),
            character_id   : arg0.character_id,
            previous_owner : arg1,
            owner          : arg2,
            paused         : arg0.paused,
            owner_nonce    : arg0.owner_nonce,
            recovery_epoch : arg0.recovery_epoch,
            source         : 3,
            timestamp_ms   : arg0.updated_at_ms,
        };
        0x2::event::emit<CharacterHubUpdated>(v0);
    }

    public(friend) fun guardian_transfer_owner(arg0: &mut LivingCharacter, arg1: address, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg0.owner == arg1, 1);
        assert_not_paused(arg0);
        arg0.owner = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = OwnerTransferred{
            character_id   : 0x2::object::uid_to_inner(&arg0.id),
            previous_owner : arg1,
            new_owner      : arg2,
            timestamp_ms   : arg0.updated_at_ms,
        };
        0x2::event::emit<OwnerTransferred>(v0);
    }

    public fun hub_character_id(arg0: &CharacterHub) : 0x2::object::ID {
        arg0.character_id
    }

    public fun hub_is_paused(arg0: &CharacterHub) : bool {
        arg0.paused
    }

    public fun hub_owner(arg0: &CharacterHub) : address {
        arg0.owner
    }

    public fun hub_owner_nonce(arg0: &CharacterHub) : u64 {
        arg0.owner_nonce
    }

    public fun hub_recovery_epoch(arg0: &CharacterHub) : u64 {
        arg0.recovery_epoch
    }

    public fun hub_revocation_registry_id(arg0: &CharacterHub) : 0x1::option::Option<0x2::object::ID> {
        arg0.revocation_registry_id
    }

    public fun is_paused(arg0: &LivingCharacter) : bool {
        arg0.paused
    }

    public fun manifest_uri(arg0: &LivingCharacter) : 0x1::string::String {
        arg0.manifest.uri
    }

    entry fun mint_classified_prompt(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = create_classified_prompt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = &mut v0;
        register_hub_internal(v1, arg7, arg8);
        0x2::transfer::public_transfer<LivingCharacter>(v0, 0x2::tx_context::sender(arg8));
    }

    entry fun mint_direct_prompt(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = create_direct_prompt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = &mut v0;
        register_hub_internal(v1, arg7, arg8);
        0x2::transfer::public_transfer<LivingCharacter>(v0, 0x2::tx_context::sender(arg8));
    }

    entry fun mint_with_consent(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_valid_character_kind(arg7);
        if (consent_required(arg7)) {
            assert!(0x1::vector::length<u8>(&arg8) > 0, 15);
            assert!(0x1::vector::length<u8>(&arg8) <= 512, 15);
            assert!(0x1::vector::length<u8>(&arg9) > 0, 15);
            assert!(0x1::vector::length<u8>(&arg9) <= 128, 15);
        };
        let v0 = create_direct_prompt(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11);
        let v1 = &mut v0;
        register_hub_internal(v1, arg10, arg11);
        let v2 = 0x2::object::id<LivingCharacter>(&v0);
        let v3 = 0x2::tx_context::sender(arg11);
        let v4 = 0x2::clock::timestamp_ms(arg10);
        let v5 = GenesisConsent{
            id             : 0x2::object::new(arg11),
            character_id   : v2,
            character_kind : arg7,
            consent_ref    : 0x1::string::utf8(arg8),
            consent_hash   : arg9,
            creator        : v3,
            schema_version : 1,
            recorded_at_ms : v4,
        };
        let v6 = GenesisConsentRecorded{
            consent_id     : 0x2::object::uid_to_inner(&v5.id),
            character_id   : v2,
            character_kind : arg7,
            consent_ref    : v5.consent_ref,
            creator        : v3,
            timestamp_ms   : v4,
        };
        0x2::event::emit<GenesisConsentRecorded>(v6);
        0x2::transfer::freeze_object<GenesisConsent>(v5);
        0x2::transfer::public_transfer<LivingCharacter>(v0, v3);
    }

    public fun name(arg0: &LivingCharacter) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &LivingCharacter) : address {
        arg0.owner
    }

    public fun profile_uri(arg0: &LivingCharacter) : 0x1::string::String {
        arg0.profile.uri
    }

    public fun proof_creation_mode(arg0: &LivingCharacter) : u8 {
        arg0.proof.creation_mode
    }

    public fun proof_creator(arg0: &LivingCharacter) : address {
        arg0.proof.creator
    }

    public fun protocol_version(arg0: &LivingCharacter) : u64 {
        arg0.protocol_version
    }

    public fun provider_policy_count(arg0: &LivingCharacter) : u64 {
        0x1::vector::length<ProviderPolicyRef>(&arg0.provider_policies)
    }

    entry fun reassign_owner_with_rotation(arg0: &mut LivingCharacter, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        do_reassign_owner_with_rotation(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun reassign_owner_with_rotation_synced(arg0: &mut LivingCharacter, arg1: &mut CharacterHub, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.character_id == 0x2::object::uid_to_inner(&arg0.id), 18);
        assert!(arg1.owner == arg0.owner, 20);
        let v0 = arg0.owner;
        do_reassign_owner_with_rotation(arg0, arg2, arg3, arg4, arg5, arg6);
        arg1.owner = arg2;
        arg1.owner_nonce = arg1.owner_nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v1 = CharacterHubUpdated{
            hub_id         : 0x2::object::uid_to_inner(&arg1.id),
            character_id   : arg1.character_id,
            previous_owner : v0,
            owner          : arg2,
            paused         : arg1.paused,
            owner_nonce    : arg1.owner_nonce,
            recovery_epoch : arg1.recovery_epoch,
            source         : 2,
            timestamp_ms   : arg1.updated_at_ms,
        };
        0x2::event::emit<CharacterHubUpdated>(v1);
    }

    entry fun register_character_hub(arg0: &mut LivingCharacter, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert_not_paused(arg0);
        register_hub_internal(arg0, arg1, arg2);
    }

    fun register_hub_internal(arg0: &mut LivingCharacter, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = HubRegistrationKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<HubRegistrationKey>(&arg0.id, v0), 17);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = CharacterHub{
            id                     : 0x2::object::new(arg2),
            character_id           : 0x2::object::uid_to_inner(&arg0.id),
            owner                  : arg0.owner,
            paused                 : arg0.paused,
            owner_nonce            : 0,
            recovery_epoch         : 0,
            revocation_registry_id : 0x1::option::none<0x2::object::ID>(),
            created_at_ms          : v1,
            updated_at_ms          : v1,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = HubRegistrationKey{dummy_field: false};
        0x2::dynamic_field::add<HubRegistrationKey, 0x2::object::ID>(&mut arg0.id, v4, v3);
        let v5 = CharacterHubCreated{
            hub_id       : v3,
            character_id : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            paused       : arg0.paused,
            timestamp_ms : v1,
        };
        0x2::event::emit<CharacterHubCreated>(v5);
        0x2::transfer::share_object<CharacterHub>(v2);
    }

    entry fun set_hub_paused(arg0: &mut CharacterHub, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        arg0.paused = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = CharacterHubUpdated{
            hub_id         : 0x2::object::uid_to_inner(&arg0.id),
            character_id   : arg0.character_id,
            previous_owner : arg0.owner,
            owner          : arg0.owner,
            paused         : arg1,
            owner_nonce    : arg0.owner_nonce,
            recovery_epoch : arg0.recovery_epoch,
            source         : 4,
            timestamp_ms   : arg0.updated_at_ms,
        };
        0x2::event::emit<CharacterHubUpdated>(v0);
    }

    entry fun set_pause(arg0: &mut LivingCharacter, arg1: bool, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x1::vector::length<u8>(&arg2) <= 128, 10);
        arg0.paused = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = PauseUpdated{
            character_id : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            paused       : arg1,
            reason_hash  : arg2,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<PauseUpdated>(v0);
    }

    public(friend) fun set_paused_from_breaker(arg0: &mut LivingCharacter, arg1: bool, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) <= 128, 10);
        arg0.paused = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = PauseUpdated{
            character_id : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            paused       : arg1,
            reason_hash  : arg2,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<PauseUpdated>(v0);
    }

    entry fun sync_character_hub(arg0: &LivingCharacter, arg1: &mut CharacterHub, arg2: &0x2::clock::Clock) {
        assert!(arg1.character_id == 0x2::object::uid_to_inner(&arg0.id), 18);
        assert!(arg1.recovery_epoch == 0, 19);
        let v0 = arg1.owner != arg0.owner;
        if (!v0 && !(arg1.paused != arg0.paused)) {
            return
        };
        arg1.owner = arg0.owner;
        arg1.paused = arg0.paused;
        if (v0) {
            arg1.owner_nonce = arg1.owner_nonce + 1;
        };
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = CharacterHubUpdated{
            hub_id         : 0x2::object::uid_to_inner(&arg1.id),
            character_id   : arg1.character_id,
            previous_owner : arg1.owner,
            owner          : arg1.owner,
            paused         : arg1.paused,
            owner_nonce    : arg1.owner_nonce,
            recovery_epoch : arg1.recovery_epoch,
            source         : 1,
            timestamp_ms   : arg1.updated_at_ms,
        };
        0x2::event::emit<CharacterHubUpdated>(v1);
    }

    entry fun transfer_owner(arg0: LivingCharacter, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<LivingCharacter>(arg0, 0x2::tx_context::sender(arg3));
        abort 14
    }

    entry fun transfer_with_rotation(arg0: LivingCharacter, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        do_transfer_with_rotation(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun transfer_with_rotation_synced(arg0: LivingCharacter, arg1: &mut CharacterHub, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.character_id == 0x2::object::id<LivingCharacter>(&arg0), 18);
        assert!(arg1.owner == arg0.owner, 20);
        do_transfer_with_rotation(arg0, arg2, arg3, arg4, arg5, arg6);
        arg1.owner = arg2;
        arg1.owner_nonce = arg1.owner_nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = CharacterHubUpdated{
            hub_id         : 0x2::object::uid_to_inner(&arg1.id),
            character_id   : arg1.character_id,
            previous_owner : arg0.owner,
            owner          : arg2,
            paused         : arg1.paused,
            owner_nonce    : arg1.owner_nonce,
            recovery_epoch : arg1.recovery_epoch,
            source         : 2,
            timestamp_ms   : arg1.updated_at_ms,
        };
        0x2::event::emit<CharacterHubUpdated>(v0);
    }

    entry fun update_manifest(arg0: &mut LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_not_paused(arg0);
        assert_valid_uri_hash(&arg1, &arg2, 5);
        let v0 = ManifestRef{
            uri            : 0x1::string::utf8(arg1),
            content_hash   : arg2,
            schema_version : 1,
        };
        arg0.manifest = v0;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v1 = ManifestUpdated{
            character_id : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            manifest_uri : arg0.manifest.uri,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<ManifestUpdated>(v1);
    }

    entry fun update_profile(arg0: &mut LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_not_paused(arg0);
        assert_valid_uri_hash(&arg1, &arg2, 4);
        let v0 = ProfileRef{
            uri            : 0x1::string::utf8(arg1),
            content_hash   : arg2,
            schema_version : 1,
        };
        arg0.profile = v0;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v1 = ProfileUpdated{
            character_id : 0x2::object::uid_to_inner(&arg0.id),
            owner        : arg0.owner,
            profile_uri  : arg0.profile.uri,
            timestamp_ms : arg0.updated_at_ms,
        };
        0x2::event::emit<ProfileUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

