module 0x52c6fbe9452d5a8f3072c5f9b395ac47af344a3c8872962ea6bf5d2f5e80a212::registry {
    struct FormRegistry has key {
        id: 0x2::object::UID,
        form_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        banner: 0x1::string::String,
        logo: 0x1::string::String,
        creator: address,
        submission_blob_ids: vector<0x1::string::String>,
        created_at: u64,
        archived: bool,
        closed: bool,
        wallet_verify_required: bool,
    }

    struct TokenGate<phantom T0> has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        creator: address,
        min_balance: u64,
        active: bool,
        created_at: u64,
    }

    struct FormCreated has copy, drop {
        registry_id: 0x2::object::ID,
        form_blob_id: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        banner: 0x1::string::String,
        logo: 0x1::string::String,
        creator: address,
        created_at: u64,
        wallet_verify_required: bool,
    }

    struct FormMetadataUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        banner: 0x1::string::String,
        logo: 0x1::string::String,
    }

    struct FormArchiveChanged has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
        archived: bool,
    }

    struct FormClosedChanged has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
        closed: bool,
    }

    struct FormWalletVerificationChanged has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
        wallet_verify_required: bool,
    }

    struct FormDeleted has copy, drop {
        registry_id: 0x2::object::ID,
        creator: address,
    }

    struct SubmissionAdded has copy, drop {
        registry_id: 0x2::object::ID,
        submitter: address,
        submission_blob_id: 0x1::string::String,
        submitted_at: u64,
        submission_count: u64,
        wallet_verified: bool,
        verified_wallet: address,
    }

    struct TokenGateCreated has copy, drop {
        gate_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        creator: address,
        min_balance: u64,
        created_at: u64,
    }

    struct TokenGateChanged has copy, drop {
        gate_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        creator: address,
        min_balance: u64,
        active: bool,
    }

    struct TokenGateDeleted has copy, drop {
        gate_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        creator: address,
    }

    public fun add_submission(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.wallet_verify_required, 5);
        add_submission_internal(arg0, arg1, false, @0x0, arg2);
    }

    fun add_submission_internal(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: bool, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.archived && !arg0.closed, 1);
        let v0 = SubmissionAdded{
            registry_id        : 0x2::object::uid_to_inner(&arg0.id),
            submitter          : 0x2::tx_context::sender(arg4),
            submission_blob_id : arg1,
            submitted_at       : 0x2::tx_context::epoch_timestamp_ms(arg4),
            submission_count   : 0x1::vector::length<0x1::string::String>(&arg0.submission_blob_ids) + 1,
            wallet_verified    : arg2,
            verified_wallet    : arg3,
        };
        0x2::event::emit<SubmissionAdded>(v0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.submission_blob_ids, arg1);
    }

    public fun add_verified_submission(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0x2::tx_context::sender(arg3), 6);
        add_submission_internal(arg0, arg1, true, arg2, arg3);
    }

    public fun create_registry(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        create_registry_with_metadata(arg0, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), false, arg1, arg2);
    }

    public fun create_registry_with_metadata(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) != @0x0, 2);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = FormCreated{
            registry_id            : 0x2::object::uid_to_inner(&v0),
            form_blob_id           : arg0,
            title                  : arg1,
            description            : arg2,
            banner                 : arg3,
            logo                   : arg4,
            creator                : v1,
            created_at             : arg6,
            wallet_verify_required : arg5,
        };
        0x2::event::emit<FormCreated>(v2);
        let v3 = FormRegistry{
            id                     : v0,
            form_blob_id           : arg0,
            title                  : arg1,
            description            : arg2,
            banner                 : arg3,
            logo                   : arg4,
            creator                : v1,
            submission_blob_ids    : 0x1::vector::empty<0x1::string::String>(),
            created_at             : arg6,
            archived               : false,
            closed                 : false,
            wallet_verify_required : arg5,
        };
        0x2::transfer::share_object<FormRegistry>(v3);
    }

    public fun create_token_gate<T0>(arg0: &FormRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_creator(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(arg1 > 0, 7);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v4 = TokenGateCreated{
            gate_id     : 0x2::object::uid_to_inner(&v0),
            registry_id : v1,
            creator     : v2,
            min_balance : arg1,
            created_at  : v3,
        };
        0x2::event::emit<TokenGateCreated>(v4);
        let v5 = TokenGate<T0>{
            id          : v0,
            registry_id : v1,
            creator     : v2,
            min_balance : arg1,
            active      : true,
            created_at  : v3,
        };
        0x2::transfer::share_object<TokenGate<T0>>(v5);
    }

    public fun delete_registry(arg0: FormRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_creator(&arg0, 0x2::tx_context::sender(arg1)), 0);
        let v0 = FormDeleted{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            creator     : arg0.creator,
        };
        0x2::event::emit<FormDeleted>(v0);
        let FormRegistry {
            id                     : v1,
            form_blob_id           : _,
            title                  : _,
            description            : _,
            banner                 : _,
            logo                   : _,
            creator                : _,
            submission_blob_ids    : _,
            created_at             : _,
            archived               : _,
            closed                 : _,
            wallet_verify_required : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun delete_token_gate<T0>(arg0: TokenGate<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 0);
        let v0 = TokenGateDeleted{
            gate_id     : 0x2::object::uid_to_inner(&arg0.id),
            registry_id : arg0.registry_id,
            creator     : arg0.creator,
        };
        0x2::event::emit<TokenGateDeleted>(v0);
        let TokenGate {
            id          : v1,
            registry_id : _,
            creator     : _,
            min_balance : _,
            active      : _,
            created_at  : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_registry_info(arg0: &FormRegistry) : (0x1::string::String, address, vector<0x1::string::String>, u64, bool) {
        (arg0.form_blob_id, arg0.creator, arg0.submission_blob_ids, arg0.created_at, arg0.archived)
    }

    public fun get_registry_metadata(arg0: &FormRegistry) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.title, arg0.description, arg0.banner, arg0.logo)
    }

    public fun get_registry_status(arg0: &FormRegistry) : (bool, bool, bool) {
        (arg0.archived, arg0.closed, arg0.wallet_verify_required)
    }

    public fun get_submission_blob_id(arg0: &FormRegistry, arg1: u64) : 0x1::string::String {
        *0x1::vector::borrow<0x1::string::String>(&arg0.submission_blob_ids, arg1)
    }

    public fun get_submission_count(arg0: &FormRegistry) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.submission_blob_ids)
    }

    public fun get_token_gate_info<T0>(arg0: &TokenGate<T0>) : (0x2::object::ID, address, u64, bool, u64) {
        (arg0.registry_id, arg0.creator, arg0.min_balance, arg0.active, arg0.created_at)
    }

    public fun is_archived(arg0: &FormRegistry) : bool {
        arg0.archived
    }

    public fun is_closed(arg0: &FormRegistry) : bool {
        arg0.closed
    }

    public fun is_creator(arg0: &FormRegistry, arg1: address) : bool {
        arg0.creator == arg1
    }

    public fun is_wallet_verify_required(arg0: &FormRegistry) : bool {
        arg0.wallet_verify_required
    }

    entry fun seal_approve_creator_only(arg0: vector<u8>, arg1: &FormRegistry, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(arg0 == 0x1::bcs::to_bytes<0x2::object::ID>(&v0), 4);
        assert!(is_creator(arg1, 0x2::tx_context::sender(arg2)), 3);
    }

    entry fun seal_approve_token_gated<T0>(arg0: vector<u8>, arg1: &FormRegistry, arg2: &TokenGate<T0>, arg3: &0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(arg0 == 0x1::bcs::to_bytes<0x2::object::ID>(&v0), 4);
        assert!(arg2.registry_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        assert!(arg2.active, 8);
        assert!(0x2::coin::value<T0>(arg3) >= arg2.min_balance, 3);
        assert!(0x2::tx_context::sender(arg4) != @0x0, 2);
    }

    public fun set_archived(arg0: &mut FormRegistry, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_creator(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.archived = arg1;
        let v0 = FormArchiveChanged{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            creator     : arg0.creator,
            archived    : arg1,
        };
        0x2::event::emit<FormArchiveChanged>(v0);
    }

    public fun set_closed(arg0: &mut FormRegistry, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_creator(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.closed = arg1;
        let v0 = FormClosedChanged{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            creator     : arg0.creator,
            closed      : arg1,
        };
        0x2::event::emit<FormClosedChanged>(v0);
    }

    public fun set_metadata(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_creator(arg0, 0x2::tx_context::sender(arg5)), 0);
        arg0.title = arg1;
        arg0.description = arg2;
        arg0.banner = arg3;
        arg0.logo = arg4;
        let v0 = FormMetadataUpdated{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            creator     : arg0.creator,
            title       : arg1,
            description : arg2,
            banner      : arg3,
            logo        : arg4,
        };
        0x2::event::emit<FormMetadataUpdated>(v0);
    }

    public fun set_token_gate<T0>(arg0: &mut TokenGate<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 0);
        assert!(arg1 > 0, 7);
        arg0.min_balance = arg1;
        arg0.active = arg2;
        let v0 = TokenGateChanged{
            gate_id     : 0x2::object::uid_to_inner(&arg0.id),
            registry_id : arg0.registry_id,
            creator     : arg0.creator,
            min_balance : arg1,
            active      : arg2,
        };
        0x2::event::emit<TokenGateChanged>(v0);
    }

    public fun set_wallet_verify_required(arg0: &mut FormRegistry, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_creator(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.wallet_verify_required = arg1;
        let v0 = FormWalletVerificationChanged{
            registry_id            : 0x2::object::uid_to_inner(&arg0.id),
            creator                : arg0.creator,
            wallet_verify_required : arg1,
        };
        0x2::event::emit<FormWalletVerificationChanged>(v0);
    }

    public fun try_get_submission_blob_id(arg0: &FormRegistry, arg1: u64) : 0x1::option::Option<0x1::string::String> {
        if (arg1 < 0x1::vector::length<0x1::string::String>(&arg0.submission_blob_ids)) {
            0x1::option::some<0x1::string::String>(*0x1::vector::borrow<0x1::string::String>(&arg0.submission_blob_ids, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    // decompiled from Move bytecode v7
}

