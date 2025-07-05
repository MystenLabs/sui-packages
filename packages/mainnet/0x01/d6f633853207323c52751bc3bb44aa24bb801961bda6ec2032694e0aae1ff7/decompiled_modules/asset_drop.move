module 0x1d6f633853207323c52751bc3bb44aa24bb801961bda6ec2032694e0aae1ff7::asset_drop {
    struct ASSET_DROP has drop {
        dummy_field: bool,
    }

    struct DropAdminCap has store, key {
        id: 0x2::object::UID,
        drop_id: 0x2::object::ID,
    }

    struct PaymentRegistry has key {
        id: 0x2::object::UID,
        payments: 0x2::table::Table<vector<u8>, PaymentRecord>,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PaymentRecord has store {
        payment_id: vector<u8>,
        drop_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        timestamp: u64,
        processed: bool,
    }

    struct AssetDrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        max_supply: u64,
        max_per_claim: u64,
        claimed_amount: u64,
        token_balance: 0x2::balance::Balance<T0>,
        is_active: bool,
        start_time: u64,
        end_time: 0x1::option::Option<u64>,
        used_nonces: vector<u64>,
        backend_public_key: vector<u8>,
        is_random_amount: bool,
        price_per_token: 0x1::option::Option<u64>,
    }

    struct ClaimReceipt has key {
        id: 0x2::object::UID,
        drop_id: 0x2::object::ID,
        drop_title: 0x1::string::String,
        claimer: address,
        amount: u64,
        timestamp: u64,
        nonce: u64,
        claim_type: 0x1::string::String,
        payment_id: 0x1::option::Option<vector<u8>>,
    }

    struct ClaimRecord has store, key {
        id: 0x2::object::UID,
        drop_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        timestamp: u64,
        nonce: u64,
    }

    struct DropCreated has copy, drop {
        drop_id: 0x2::object::ID,
        title: 0x1::string::String,
        max_supply: u64,
        max_per_claim: u64,
    }

    struct ClaimFulfilled has copy, drop {
        drop_id: 0x2::object::ID,
        drop_title: 0x1::string::String,
        claimer: address,
        amount: u64,
        nonce: u64,
        timestamp: u64,
        claim_type: 0x1::string::String,
        payment_id: 0x1::option::Option<vector<u8>>,
        payment_amount: 0x1::option::Option<u64>,
        receipt_id: 0x2::object::ID,
        remaining_supply: u64,
        total_claimed: u64,
    }

    struct TokensClaimed has copy, drop {
        drop_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        nonce: u64,
        timestamp: u64,
    }

    struct TokensDeposited has copy, drop {
        drop_id: 0x2::object::ID,
        amount: u64,
        total_balance: u64,
    }

    struct DropStatusChanged has copy, drop {
        drop_id: 0x2::object::ID,
        is_active: bool,
    }

    struct PaymentLogged has copy, drop {
        payment_id: vector<u8>,
        drop_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        timestamp: u64,
    }

    struct PaymentProcessed has copy, drop {
        payment_id: vector<u8>,
        drop_id: 0x2::object::ID,
        claimer: address,
    }

    public fun admin_random_claim<T0>(arg0: &mut AssetDrop<T0>, arg1: &DropAdminCap, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_random_amount, 1);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg0.is_active, 3);
        if (0x1::option::is_some<u64>(&arg0.end_time)) {
            assert!(v0 <= *0x1::option::borrow<u64>(&arg0.end_time), 4);
        };
        assert!(v0 >= arg0.start_time, 3);
        assert!(v0 <= arg4, 7);
        assert!(!0x1::vector::contains<u64>(&arg0.used_nonces, &arg3), 5);
        let v1 = create_claim_message(0x2::object::uid_to_inner(&arg0.id), arg2, 0, arg3, arg4);
        let v2 = 0x2::hash::keccak256(&v1);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg5, &arg0.backend_public_key, &v2, 1), 6);
        let v3 = 0x2::random::new_generator(arg6, arg8);
        let v4 = 1000000000 * 0x2::random::generate_u64_in_range(&mut v3, 1, 10000);
        let v5 = if (arg0.max_supply > arg0.claimed_amount) {
            arg0.max_supply - arg0.claimed_amount
        } else {
            0
        };
        let v6 = 0x2::balance::value<T0>(&arg0.token_balance);
        let v7 = if (v4 > v5) {
            v5
        } else if (v4 > v6) {
            v6
        } else {
            v4
        };
        assert!(v7 > 0, 2);
        0x1::vector::push_back<u64>(&mut arg0.used_nonces, arg3);
        arg0.claimed_amount = arg0.claimed_amount + v7;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v7), arg8), arg2);
        let v8 = ClaimRecord{
            id        : 0x2::object::new(arg8),
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer   : arg2,
            amount    : v7,
            timestamp : v0,
            nonce     : arg3,
        };
        mint_claim_receipt_and_emit<T0>(arg0, arg2, v7, arg3, v0, 0x1::string::utf8(b"random"), 0x1::option::none<vector<u8>>(), 0x1::option::none<u64>(), arg8);
        let v9 = TokensClaimed{
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer   : arg2,
            amount    : v7,
            nonce     : arg3,
            timestamp : v0,
        };
        0x2::event::emit<TokensClaimed>(v9);
        0x2::transfer::public_transfer<ClaimRecord>(v8, arg2);
    }

    public fun calculate_total_cost<T0>(arg0: &AssetDrop<T0>, arg1: u64) : u64 {
        if (0x1::option::is_some<u64>(&arg0.price_per_token)) {
            arg1 * *0x1::option::borrow<u64>(&arg0.price_per_token)
        } else {
            0
        }
    }

    public fun claim_tokens<T0>(arg0: &mut AssetDrop<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_random_amount) {
            abort 1
        };
        claim_tokens_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun claim_tokens_internal<T0>(arg0: &mut AssetDrop<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg0.is_active, 3);
        if (0x1::option::is_some<u64>(&arg0.end_time)) {
            assert!(v0 <= *0x1::option::borrow<u64>(&arg0.end_time), 4);
        };
        assert!(v0 >= arg0.start_time, 3);
        assert!(v0 <= arg3, 7);
        assert!(!0x1::vector::contains<u64>(&arg0.used_nonces, &arg2), 5);
        if (arg0.is_random_amount) {
            assert!(arg1 > 0, 1);
        } else {
            assert!(arg1 > 0 && arg1 <= arg0.max_per_claim, 1);
        };
        assert!(arg0.claimed_amount + arg1 <= arg0.max_supply, 2);
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= arg1, 2);
        let v2 = create_claim_message(0x2::object::uid_to_inner(&arg0.id), v1, arg1, arg2, arg3);
        let v3 = 0x2::hash::keccak256(&v2);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg4, &arg0.backend_public_key, &v3, 1), 6);
        0x1::vector::push_back<u64>(&mut arg0.used_nonces, arg2);
        arg0.claimed_amount = arg0.claimed_amount + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg1), arg6), v1);
        let v4 = ClaimRecord{
            id        : 0x2::object::new(arg6),
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer   : v1,
            amount    : arg1,
            timestamp : v0,
            nonce     : arg2,
        };
        mint_claim_receipt_and_emit<T0>(arg0, v1, arg1, arg2, v0, 0x1::string::utf8(b"regular"), 0x1::option::none<vector<u8>>(), 0x1::option::none<u64>(), arg6);
        let v5 = TokensClaimed{
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer   : v1,
            amount    : arg1,
            nonce     : arg2,
            timestamp : v0,
        };
        0x2::event::emit<TokensClaimed>(v5);
        0x2::transfer::public_transfer<ClaimRecord>(v4, v1);
    }

    public fun claim_tokens_random<T0>(arg0: &mut AssetDrop<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_random_amount, 8);
        0x2::clock::timestamp_ms(arg5);
        let v0 = create_claim_message(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg6), 0, arg1, arg2);
        let v1 = 0x2::hash::keccak256(&v0);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg3, &arg0.backend_public_key, &v1, 1), 6);
        abort 8
    }

    public fun count_unprocessed_payments(arg0: &PaymentRegistry) : u64 {
        0
    }

    fun create_claim_message(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun create_drop<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x2::coin::Coin<T0>, arg7: vector<u8>, arg8: bool, arg9: 0x1::option::Option<u64>, arg10: &mut 0x2::tx_context::TxContext) : DropAdminCap {
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = AssetDrop<T0>{
            id                 : v0,
            title              : 0x1::string::utf8(arg0),
            description        : 0x1::string::utf8(arg1),
            max_supply         : arg2,
            max_per_claim      : arg3,
            claimed_amount     : 0,
            token_balance      : 0x2::coin::into_balance<T0>(arg6),
            is_active          : true,
            start_time         : arg4,
            end_time           : arg5,
            used_nonces        : 0x1::vector::empty<u64>(),
            backend_public_key : arg7,
            is_random_amount   : arg8,
            price_per_token    : arg9,
        };
        let v3 = DropAdminCap{
            id      : 0x2::object::new(arg10),
            drop_id : v1,
        };
        let v4 = DropCreated{
            drop_id       : v1,
            title         : v2.title,
            max_supply    : arg2,
            max_per_claim : arg3,
        };
        0x2::event::emit<DropCreated>(v4);
        0x2::transfer::share_object<AssetDrop<T0>>(v2);
        v3
    }

    public fun deposit_tokens<T0>(arg0: &mut AssetDrop<T0>, arg1: &DropAdminCap, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = TokensDeposited{
            drop_id       : 0x2::object::uid_to_inner(&arg0.id),
            amount        : 0x2::coin::value<T0>(&arg2),
            total_balance : 0x2::balance::value<T0>(&arg0.token_balance),
        };
        0x2::event::emit<TokensDeposited>(v0);
    }

    public fun get_backend_public_key<T0>(arg0: &AssetDrop<T0>) : vector<u8> {
        arg0.backend_public_key
    }

    public fun get_claim_info(arg0: &ClaimRecord) : (0x2::object::ID, address, u64, u64, u64) {
        (arg0.drop_id, arg0.claimer, arg0.amount, arg0.timestamp, arg0.nonce)
    }

    public fun get_claim_receipt_info(arg0: &ClaimReceipt) : (0x2::object::ID, 0x1::string::String, address, u64, u64, u64, 0x1::string::String, 0x1::option::Option<vector<u8>>) {
        (arg0.drop_id, arg0.drop_title, arg0.claimer, arg0.amount, arg0.timestamp, arg0.nonce, arg0.claim_type, arg0.payment_id)
    }

    public fun get_drop_info<T0>(arg0: &AssetDrop<T0>) : (0x1::string::String, 0x1::string::String, u64, u64, u64, bool, u64) {
        (arg0.title, arg0.description, arg0.max_supply, arg0.claimed_amount, 0x2::balance::value<T0>(&arg0.token_balance), arg0.is_active, arg0.start_time)
    }

    public fun get_payment_record(arg0: &PaymentRegistry, arg1: vector<u8>) : 0x1::option::Option<PaymentRecord> {
        if (0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1)) {
            let v1 = 0x2::table::borrow<vector<u8>, PaymentRecord>(&arg0.payments, arg1);
            let v2 = PaymentRecord{
                payment_id : v1.payment_id,
                drop_id    : v1.drop_id,
                payer      : v1.payer,
                amount     : v1.amount,
                timestamp  : v1.timestamp,
                processed  : v1.processed,
            };
            0x1::option::some<PaymentRecord>(v2)
        } else {
            0x1::option::none<PaymentRecord>()
        }
    }

    public fun get_price_per_token<T0>(arg0: &AssetDrop<T0>) : 0x1::option::Option<u64> {
        arg0.price_per_token
    }

    public fun get_treasury_balance(arg0: &PaymentRegistry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_balance)
    }

    public fun has_claim_receipt_for_drop(arg0: address, arg1: 0x2::object::ID) : bool {
        false
    }

    fun init(arg0: ASSET_DROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentRegistry{
            id               : 0x2::object::new(arg1),
            payments         : 0x2::table::new<vector<u8>, PaymentRecord>(arg1),
            treasury_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PaymentRegistry>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"DropKit Claim Receipt - {drop_title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Proof of claim for {amount} tokens from {drop_title} drop. This is a soulbound receipt that cannot be transferred."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIyMDAiIGhlaWdodD0iMjAwIiByeD0iMTAiIGZpbGw9IiNmMGY5ZmYiLz4KPHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4PSI4MCIgeT0iNDAiPgo8cGF0aCBkPSJNOSAxMkwyLjI1IDUuMjVMMy43IDMuOEw5IDlMMjAuMyAtMi4zTDIxLjc1IC0wLjg1TDkgMTJaIiBmaWxsPSIjMTBiOTgxIi8+Cjwvc3ZnPgo8dGV4dCB4PSIxMDAiIHk9IjEwMCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzFmMjkzNyIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjE0Ij5DbGFpbSBSZWNlaXB0PC90ZXh0Pgo8dGV4dCB4PSIxMDAiIHk9IjEyMCIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZmlsbD0iIzZiNzI4MCIgZm9udC1mYW1pbHk9IkFyaWFsIiBmb250LXNpemU9IjEwIj5Tb3VsYm91bmQgVG9rZW48L3RleHQ+CjwvZz4KPC9zdmc+"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://dropkit.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"DropKit"));
        let v5 = 0x2::package::claim<ASSET_DROP>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<ClaimReceipt>(&v5, v1, v3, arg1);
        0x2::display::update_version<ClaimReceipt>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ClaimReceipt>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_nonce_used<T0>(arg0: &AssetDrop<T0>, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.used_nonces, &arg1)
    }

    public fun is_paid_drop<T0>(arg0: &AssetDrop<T0>) : bool {
        0x1::option::is_some<u64>(&arg0.price_per_token)
    }

    public entry fun log_claim_payment(arg0: &mut PaymentRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(!0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg3), 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = PaymentRecord{
            payment_id : arg3,
            drop_id    : arg2,
            payer      : v0,
            amount     : v1,
            timestamp  : v2,
            processed  : false,
        };
        0x2::table::add<vector<u8>, PaymentRecord>(&mut arg0.payments, arg3, v3);
        let v4 = PaymentLogged{
            payment_id : arg3,
            drop_id    : arg2,
            payer      : v0,
            amount     : v1,
            timestamp  : v2,
        };
        0x2::event::emit<PaymentLogged>(v4);
    }

    fun mint_claim_receipt_and_emit<T0>(arg0: &AssetDrop<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::option::Option<vector<u8>>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = ClaimReceipt{
            id         : 0x2::object::new(arg8),
            drop_id    : v0,
            drop_title : arg0.title,
            claimer    : arg1,
            amount     : arg2,
            timestamp  : arg4,
            nonce      : arg3,
            claim_type : arg5,
            payment_id : arg6,
        };
        let v2 = if (arg0.max_supply > arg0.claimed_amount) {
            arg0.max_supply - arg0.claimed_amount
        } else {
            0
        };
        let v3 = ClaimFulfilled{
            drop_id          : v0,
            drop_title       : arg0.title,
            claimer          : arg1,
            amount           : arg2,
            nonce            : arg3,
            timestamp        : arg4,
            claim_type       : arg5,
            payment_id       : arg6,
            payment_amount   : arg7,
            receipt_id       : 0x2::object::uid_to_inner(&v1.id),
            remaining_supply : v2,
            total_claimed    : arg0.claimed_amount,
        };
        0x2::event::emit<ClaimFulfilled>(v3);
        0x2::transfer::transfer<ClaimReceipt>(v1, arg1);
    }

    public fun mint_tokens<T0>(arg0: &mut AssetDrop<T0>, arg1: &DropAdminCap, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.is_active, 3);
        if (0x1::option::is_some<u64>(&arg0.end_time)) {
            assert!(v0 <= *0x1::option::borrow<u64>(&arg0.end_time), 4);
        };
        assert!(v0 >= arg0.start_time, 3);
        assert!(!0x1::vector::contains<u64>(&arg0.used_nonces, &arg4), 5);
        assert!(arg3 > 0 && arg3 <= arg0.max_per_claim, 1);
        assert!(arg0.claimed_amount + arg3 <= arg0.max_supply, 2);
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= arg3, 2);
        0x1::vector::push_back<u64>(&mut arg0.used_nonces, arg4);
        arg0.claimed_amount = arg0.claimed_amount + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg3), arg6), arg2);
        let v1 = ClaimRecord{
            id        : 0x2::object::new(arg6),
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer   : arg2,
            amount    : arg3,
            timestamp : v0,
            nonce     : arg4,
        };
        mint_claim_receipt_and_emit<T0>(arg0, arg2, arg3, arg4, v0, 0x1::string::utf8(b"admin"), 0x1::option::none<vector<u8>>(), 0x1::option::none<u64>(), arg6);
        let v2 = TokensClaimed{
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer   : arg2,
            amount    : arg3,
            nonce     : arg4,
            timestamp : v0,
        };
        0x2::event::emit<TokensClaimed>(v2);
        0x2::transfer::public_transfer<ClaimRecord>(v1, arg2);
    }

    public fun set_active_status<T0>(arg0: &mut AssetDrop<T0>, arg1: &DropAdminCap, arg2: bool) {
        arg0.is_active = arg2;
        let v0 = DropStatusChanged{
            drop_id   : 0x2::object::uid_to_inner(&arg0.id),
            is_active : arg2,
        };
        0x2::event::emit<DropStatusChanged>(v0);
    }

    public fun set_backend_public_key<T0>(arg0: &mut AssetDrop<T0>, arg1: &DropAdminCap, arg2: vector<u8>) {
        arg0.backend_public_key = arg2;
    }

    public fun verify_and_process_payment(arg0: &mut PaymentRegistry, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: address, arg4: u64) : PaymentRecord {
        assert!(0x2::table::contains<vector<u8>, PaymentRecord>(&arg0.payments, arg1), 10);
        let v0 = 0x2::table::borrow_mut<vector<u8>, PaymentRecord>(&mut arg0.payments, arg1);
        assert!(v0.drop_id == arg2, 6);
        assert!(v0.payer == arg3, 8);
        assert!(v0.amount >= arg4, 11);
        assert!(!v0.processed, 5);
        v0.processed = true;
        let v1 = PaymentProcessed{
            payment_id : arg1,
            drop_id    : arg2,
            claimer    : arg3,
        };
        0x2::event::emit<PaymentProcessed>(v1);
        PaymentRecord{
            payment_id : v0.payment_id,
            drop_id    : v0.drop_id,
            payer      : v0.payer,
            amount     : v0.amount,
            timestamp  : v0.timestamp,
            processed  : v0.processed,
        }
    }

    public fun withdraw_tokens<T0>(arg0: &mut AssetDrop<T0>, arg1: &DropAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.token_balance) >= arg2, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

