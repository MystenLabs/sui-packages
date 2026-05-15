module 0xdf4f409344e5e90cb284a9b62b52504817afbecb432dce59cb1bbf08f69296dd::payments {
    struct MerchantRegistry has key {
        id: 0x2::object::UID,
        issuer_pubkey: vector<u8>,
        chain_id: u8,
        admin: address,
        entries: 0x2::table::Table<vector<u8>, MerchantEntry>,
        used_nonces: 0x2::table::Table<vector<u8>, bool>,
    }

    struct MerchantEntry has store {
        sui_address: address,
        claimed_at_ms: u64,
        uen_raw: vector<u8>,
        metadata_uri: 0x1::option::Option<0x1::string::String>,
        evidence_hash: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimMessage has copy, drop {
        domain_tag: vector<u8>,
        chain_id: u8,
        uen: vector<u8>,
        claimer: address,
        nonce: vector<u8>,
        expires_at_ms: u64,
        evidence_hash: vector<u8>,
    }

    struct MerchantRegistered has copy, drop {
        uen_hash: vector<u8>,
        sui_address: address,
        timestamp_ms: u64,
    }

    struct PaymentReceipt has copy, drop {
        receipt_id: vector<u8>,
        merchant: address,
        payer: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
        uen_hash: vector<u8>,
        timestamp_ms: u64,
        memo: 0x1::option::Option<vector<u8>>,
        sgd_minor_units: u64,
        quote_metadata: 0x1::option::Option<vector<u8>>,
    }

    struct RefundIssued has copy, drop {
        original_receipt_id: vector<u8>,
        merchant: address,
        payer: address,
        amount: u64,
        token_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct IssuerKeyRotated has copy, drop {
        old_pubkey: vector<u8>,
        new_pubkey: vector<u8>,
        timestamp_ms: u64,
    }

    struct MerchantAddressUpdated has copy, drop {
        uen_hash: vector<u8>,
        old_address: address,
        new_address: address,
        timestamp_ms: u64,
    }

    struct MerchantMetadataUpdated has copy, drop {
        uen_hash: vector<u8>,
        new_metadata_uri: 0x1::option::Option<0x1::string::String>,
        timestamp_ms: u64,
    }

    public fun chain_id(arg0: &MerchantRegistry) : u8 {
        arg0.chain_id
    }

    fun derive_uen_hash(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"PAYNOW_UEN_V1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = MerchantRegistry{
            id            : 0x2::object::new(arg0),
            issuer_pubkey : b"",
            chain_id      : 0,
            admin         : v0,
            entries       : 0x2::table::new<vector<u8>, MerchantEntry>(arg0),
            used_nonces   : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<MerchantRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
    }

    public fun is_registered(arg0: &MerchantRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, MerchantEntry>(&arg0.entries, derive_uen_hash(&arg1))
    }

    public fun issuer_pubkey(arg0: &MerchantRegistry) : vector<u8> {
        arg0.issuer_pubkey
    }

    public fun merchant_address(arg0: &MerchantRegistry, arg1: vector<u8>) : address {
        let v0 = derive_uen_hash(&arg1);
        assert!(0x2::table::contains<vector<u8>, MerchantEntry>(&arg0.entries, v0), 2);
        0x2::table::borrow<vector<u8>, MerchantEntry>(&arg0.entries, v0).sui_address
    }

    public fun pay<T0>(arg0: &MerchantRegistry, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: 0x1::option::Option<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = derive_uen_hash(&arg1);
        assert!(0x2::table::contains<vector<u8>, MerchantEntry>(&arg0.entries, v0), 2);
        let v1 = 0x2::table::borrow<vector<u8>, MerchantEntry>(&arg0.entries, v0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 > 0, 4);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = v1.sui_address;
        let v5 = 0x2::clock::timestamp_ms(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v4);
        let v6 = PaymentReceipt{
            receipt_id      : 0x2::hash::blake2b256(&v0),
            merchant        : v4,
            payer           : v3,
            amount          : v2,
            token_type      : 0x1::type_name::with_defining_ids<T0>(),
            uen_hash        : v0,
            timestamp_ms    : v5,
            memo            : arg3,
            sgd_minor_units : arg4,
            quote_metadata  : arg5,
        };
        0x2::event::emit<PaymentReceipt>(v6);
    }

    public fun refund<T0>(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1);
        let v1 = RefundIssued{
            original_receipt_id : arg0,
            merchant            : 0x2::tx_context::sender(arg4),
            payer               : arg1,
            amount              : v0,
            token_type          : 0x1::type_name::with_defining_ids<T0>(),
            timestamp_ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RefundIssued>(v1);
    }

    public fun register_merchant(arg0: &mut MerchantRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: 0x1::option::Option<0x1::string::String>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.issuer_pubkey), 8);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 <= arg4, 9);
        let v1 = derive_uen_hash(&arg1);
        assert!(!0x2::table::contains<vector<u8>, MerchantEntry>(&arg0.entries, v1), 1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg2), 6);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = ClaimMessage{
            domain_tag    : b"QUAY_CLAIM_V1",
            chain_id      : arg0.chain_id,
            uen           : arg1,
            claimer       : v2,
            nonce         : arg2,
            expires_at_ms : arg4,
            evidence_hash : arg6,
        };
        let v4 = 0x2::bcs::to_bytes<ClaimMessage>(&v3);
        let v5 = 0x2::hash::blake2b256(&v4);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.issuer_pubkey, &v5), 5);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_nonces, v3.nonce, true);
        let v6 = MerchantEntry{
            sui_address   : v2,
            claimed_at_ms : v0,
            uen_raw       : v3.uen,
            metadata_uri  : arg5,
            evidence_hash : v3.evidence_hash,
        };
        0x2::table::add<vector<u8>, MerchantEntry>(&mut arg0.entries, v1, v6);
        let v7 = MerchantRegistered{
            uen_hash     : v1,
            sui_address  : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<MerchantRegistered>(v7);
    }

    public fun rotate_issuer_pubkey(arg0: &AdminCap, arg1: &mut MerchantRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        arg1.issuer_pubkey = arg2;
        let v0 = IssuerKeyRotated{
            old_pubkey   : arg1.issuer_pubkey,
            new_pubkey   : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<IssuerKeyRotated>(v0);
    }

    public fun set_initial_issuer_pubkey(arg0: &mut MerchantRegistry, arg1: vector<u8>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 7);
        assert!(0x1::vector::is_empty<u8>(&arg0.issuer_pubkey), 11);
        arg0.issuer_pubkey = arg1;
        arg0.chain_id = arg2;
    }

    public fun update_merchant_address(arg0: &mut MerchantRegistry, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = derive_uen_hash(&arg1);
        assert!(0x2::table::contains<vector<u8>, MerchantEntry>(&arg0.entries, v0), 2);
        let v1 = 0x2::table::borrow_mut<vector<u8>, MerchantEntry>(&mut arg0.entries, v0);
        assert!(v1.sui_address == 0x2::tx_context::sender(arg4), 3);
        v1.sui_address = arg2;
        let v2 = MerchantAddressUpdated{
            uen_hash     : v0,
            old_address  : v1.sui_address,
            new_address  : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MerchantAddressUpdated>(v2);
    }

    public fun update_merchant_metadata(arg0: &mut MerchantRegistry, arg1: vector<u8>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = derive_uen_hash(&arg1);
        assert!(0x2::table::contains<vector<u8>, MerchantEntry>(&arg0.entries, v0), 2);
        let v1 = 0x2::table::borrow_mut<vector<u8>, MerchantEntry>(&mut arg0.entries, v0);
        assert!(v1.sui_address == 0x2::tx_context::sender(arg4), 3);
        v1.metadata_uri = arg2;
        let v2 = MerchantMetadataUpdated{
            uen_hash         : v0,
            new_metadata_uri : v1.metadata_uri,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MerchantMetadataUpdated>(v2);
    }

    // decompiled from Move bytecode v7
}

