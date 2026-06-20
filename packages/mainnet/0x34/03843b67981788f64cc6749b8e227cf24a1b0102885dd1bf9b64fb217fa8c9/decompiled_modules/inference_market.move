module 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::inference_market {
    struct ModelVersion has store {
        walrus_blob_id: 0x1::string::String,
        pass_rate_bps: u64,
        published_at: u64,
    }

    struct ModelRegistry has key {
        id: 0x2::object::UID,
        environment: 0x2::object::ID,
        creator: address,
        current_best: u64,
        versions: vector<ModelVersion>,
        fee_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_calls: u64,
        verifier_pk: vector<u8>,
        verified_calls: u64,
        last_pass_bps: u64,
        verified_ts: 0x2::table::Table<u64, bool>,
        version: u64,
    }

    struct PublisherCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct VerifiedReceipt has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        buyer: address,
        version: u64,
        task_id: u64,
        pass_bps: u64,
        judge0_token: 0x1::string::String,
        output_hash: vector<u8>,
    }

    struct VerdictIntent has copy, drop {
        intent: u8,
        buyer: address,
        version: u64,
        task_id: u64,
        pass_bps: u64,
        output_hash: vector<u8>,
        judge0_token: 0x1::string::String,
        ts: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        buyer: address,
        version: u64,
        theorem_id: u64,
        paid: u64,
    }

    fun assert_version(arg0: &ModelRegistry) {
        assert!(arg0.version == 1, 0);
    }

    public fun blob_of(arg0: &ModelRegistry, arg1: u64) : 0x1::string::String {
        clone_string(&0x1::vector::borrow<ModelVersion>(&arg0.versions, arg1).walrus_blob_id)
    }

    public fun buy_inference(arg0: &mut ModelRegistry, arg1: &mut 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::environment::Environment, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : Receipt {
        assert_version(arg0);
        assert!(!0x1::vector::is_empty<ModelVersion>(&arg0.versions), 3);
        assert!(0x2::object::id<0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::environment::Environment>(arg1) == arg0.environment, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = v0 * 3000 / 10000;
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::environment::deposit_fees(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg0.total_calls = arg0.total_calls + 1;
        let v2 = arg0.current_best;
        let v3 = 0x2::tx_context::sender(arg4);
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_inference_paid(0x2::object::id<ModelRegistry>(arg0), v3, v2, arg2, v0, v1, 0x2::coin::value<0x2::sui::SUI>(&arg3));
        Receipt{
            id         : 0x2::object::new(arg4),
            registry   : 0x2::object::id<ModelRegistry>(arg0),
            buyer      : v3,
            version    : v2,
            theorem_id : arg2,
            paid       : v0,
        }
    }

    entry fun buy_inference_entry(arg0: &mut ModelRegistry, arg1: &mut 0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::environment::Environment, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_inference(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Receipt>(v0, 0x2::tx_context::sender(arg4));
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        *arg0
    }

    fun clone_string(arg0: &0x1::string::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::string::as_bytes(arg0))
    }

    public fun create_registry(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : PublisherCap {
        let v0 = ModelRegistry{
            id             : 0x2::object::new(arg2),
            environment    : arg0,
            creator        : 0x2::tx_context::sender(arg2),
            current_best   : 0,
            versions       : 0x1::vector::empty<ModelVersion>(),
            fee_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_calls    : 0,
            verifier_pk    : arg1,
            verified_calls : 0,
            last_pass_bps  : 0,
            verified_ts    : 0x2::table::new<u64, bool>(arg2),
            version        : 1,
        };
        let v1 = 0x2::object::id<ModelRegistry>(&v0);
        let v2 = PublisherCap{
            id       : 0x2::object::new(arg2),
            registry : v1,
        };
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_registry_created(v1, arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<ModelRegistry>(v0);
        v2
    }

    entry fun create_registry_entry(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_registry(arg0, arg1, arg2);
        0x2::transfer::public_transfer<PublisherCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun current_best(arg0: &ModelRegistry) : u64 {
        arg0.current_best
    }

    public fun fee_pool_value(arg0: &ModelRegistry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_pool)
    }

    public fun last_pass_bps(arg0: &ModelRegistry) : u64 {
        arg0.last_pass_bps
    }

    public fun migrate(arg0: &mut ModelRegistry, arg1: &PublisherCap) {
        assert!(arg1.registry == 0x2::object::id<ModelRegistry>(arg0), 1);
        assert!(arg0.version < 1, 0);
        arg0.version = 1;
    }

    public fun pass_rate_of(arg0: &ModelRegistry, arg1: u64) : u64 {
        0x1::vector::borrow<ModelVersion>(&arg0.versions, arg1).pass_rate_bps
    }

    public fun publish_checkpoint(arg0: &mut ModelRegistry, arg1: &PublisherCap, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_version(arg0);
        assert!(arg1.registry == 0x2::object::id<ModelRegistry>(arg0), 1);
        let v0 = 0x1::vector::length<ModelVersion>(&arg0.versions);
        let v1 = ModelVersion{
            walrus_blob_id : arg2,
            pass_rate_bps  : arg3,
            published_at   : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<ModelVersion>(&mut arg0.versions, v1);
        arg0.current_best = v0;
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_checkpoint_published(0x2::object::id<ModelRegistry>(arg0), v0, clone_string(&arg2), arg3);
    }

    public fun receipt_paid(arg0: &Receipt) : u64 {
        arg0.paid
    }

    public fun receipt_version(arg0: &Receipt) : u64 {
        arg0.version
    }

    public fun record_verified_inference(arg0: &mut ModelRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x1::string::String, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!0x2::table::contains<u64, bool>(&arg0.verified_ts, arg8), 5);
        let v0 = VerdictIntent{
            intent       : 1,
            buyer        : arg2,
            version      : arg3,
            task_id      : arg4,
            pass_bps     : arg5,
            output_hash  : clone_bytes(&arg6),
            judge0_token : clone_string(&arg7),
            ts           : arg8,
        };
        let v1 = 0x1::bcs::to_bytes<VerdictIntent>(&v0);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg9, &arg0.verifier_pk, &v1, 1), 4);
        0x2::table::add<u64, bool>(&mut arg0.verified_ts, arg8, true);
        arg0.verified_calls = arg0.verified_calls + 1;
        arg0.last_pass_bps = arg5;
        0x3403843b67981788f64cc6749b8e227cf24a1b0102885dd1bf9b64fb217fa8c9::events::emit_inference_verified(0x2::object::id<ModelRegistry>(arg0), arg2, arg3, arg4, arg5, clone_string(&arg7), clone_bytes(&arg6));
        let v2 = VerifiedReceipt{
            id           : 0x2::object::new(arg10),
            registry     : 0x2::object::id<ModelRegistry>(arg0),
            buyer        : arg2,
            version      : arg3,
            task_id      : arg4,
            pass_bps     : arg5,
            judge0_token : arg7,
            output_hash  : arg6,
        };
        0x2::transfer::public_transfer<VerifiedReceipt>(v2, arg2);
    }

    public fun set_verifier(arg0: &mut ModelRegistry, arg1: &PublisherCap, arg2: vector<u8>) {
        assert_version(arg0);
        assert!(arg1.registry == 0x2::object::id<ModelRegistry>(arg0), 1);
        arg0.verifier_pk = arg2;
    }

    public fun total_calls(arg0: &ModelRegistry) : u64 {
        arg0.total_calls
    }

    public fun verified_calls(arg0: &ModelRegistry) : u64 {
        arg0.verified_calls
    }

    public fun verifier_pk(arg0: &ModelRegistry) : vector<u8> {
        arg0.verifier_pk
    }

    public fun version_count(arg0: &ModelRegistry) : u64 {
        0x1::vector::length<ModelVersion>(&arg0.versions)
    }

    public fun vreceipt_pass_bps(arg0: &VerifiedReceipt) : u64 {
        arg0.pass_bps
    }

    public fun vreceipt_token(arg0: &VerifiedReceipt) : 0x1::string::String {
        clone_string(&arg0.judge0_token)
    }

    // decompiled from Move bytecode v7
}

