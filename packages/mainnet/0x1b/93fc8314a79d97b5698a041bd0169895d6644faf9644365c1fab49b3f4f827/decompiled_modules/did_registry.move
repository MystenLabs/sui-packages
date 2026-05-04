module 0x1b93fc8314a79d97b5698a041bd0169895d6644faf9644365c1fab49b3f4f827::did_registry {
    struct UserDID has store, key {
        id: 0x2::object::UID,
        owner: address,
        did_type: u8,
        verification_status: u8,
        verification_timestamp: u64,
        expiry_epoch: u64,
        blob_id: 0x1::string::String,
        nautilus_signature: vector<u8>,
        signature_timestamp_ms: u64,
        evidence_hash: vector<u8>,
        claimed: bool,
    }

    struct DIDRegistry has key {
        id: 0x2::object::UID,
        user_verifications: 0x2::table::Table<address, 0x2::table::Table<u8, 0x2::object::ID>>,
        admin_addresses: 0x2::table::Table<address, bool>,
    }

    struct RegistryCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct DIDSoulBoundNFT has key {
        id: 0x2::object::UID,
        owner: address,
        did_type: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: 0x1::string::String,
        nautilus_signature: vector<u8>,
        signature_timestamp_ms: u64,
        evidence_hash: vector<u8>,
        expiry_epoch: u64,
        minted_at: u64,
    }

    struct VerificationStarted has copy, drop {
        registry_id: 0x2::object::ID,
        user_address: address,
        did_type: u8,
        user_did_id: 0x2::object::ID,
    }

    struct VerificationCompleted has copy, drop {
        registry_id: 0x2::object::ID,
        user_address: address,
        did_type: u8,
        user_did_id: 0x2::object::ID,
        status: u8,
        nautilus_signature: vector<u8>,
        signature_timestamp_ms: u64,
        evidence_hash: vector<u8>,
    }

    struct DIDClaimed has copy, drop {
        registry_id: 0x2::object::ID,
        user_address: address,
        did_type: u8,
        user_did_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &mut DIDRegistry, arg1: &RegistryCap, arg2: address) {
        assert!(arg1.registry_id == 0x2::object::id<DIDRegistry>(arg0), 1);
        0x2::table::add<address, bool>(&mut arg0.admin_addresses, arg2, true);
    }

    public fun claim_did_nft(arg0: &DIDRegistry, arg1: &mut UserDID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.verification_status == 1, 4);
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(!arg1.claimed, 3);
        assert!(0x2::tx_context::epoch(arg4) < arg1.expiry_epoch, 4);
        let (v0, v1, _, _) = get_did_type_info(arg1.did_type);
        let v4 = DIDSoulBoundNFT{
            id                     : 0x2::object::new(arg4),
            owner                  : arg1.owner,
            did_type               : arg1.did_type,
            name                   : v0,
            description            : v1,
            blob_id                : arg2,
            nautilus_signature     : arg1.nautilus_signature,
            signature_timestamp_ms : arg1.signature_timestamp_ms,
            evidence_hash          : arg1.evidence_hash,
            expiry_epoch           : arg1.expiry_epoch,
            minted_at              : 0x2::clock::timestamp_ms(arg3),
        };
        let v5 = 0x2::object::id<DIDSoulBoundNFT>(&v4);
        arg1.claimed = true;
        arg1.blob_id = arg2;
        0x2::transfer::transfer<DIDSoulBoundNFT>(v4, arg1.owner);
        let v6 = DIDClaimed{
            registry_id  : 0x2::object::id<DIDRegistry>(arg0),
            user_address : arg1.owner,
            did_type     : arg1.did_type,
            user_did_id  : 0x2::object::id<UserDID>(arg1),
            nft_id       : v5,
        };
        0x2::event::emit<DIDClaimed>(v6);
        v5
    }

    public fun create_did_registry(arg0: &mut 0x2::tx_context::TxContext) : (RegistryCap, DIDRegistry) {
        let v0 = DIDRegistry{
            id                 : 0x2::object::new(arg0),
            user_verifications : 0x2::table::new<address, 0x2::table::Table<u8, 0x2::object::ID>>(arg0),
            admin_addresses    : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = RegistryCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<DIDRegistry>(&v0),
        };
        (v1, v0)
    }

    entry fun create_did_registry_entry(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_did_registry(arg0);
        0x2::transfer::share_object<DIDRegistry>(v1);
        0x2::transfer::transfer<RegistryCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_did_type_info(arg0: u8) : (0x1::string::String, 0x1::string::String, vector<0x1::string::String>, u64) {
        if (arg0 == 1) {
            let v4 = 0x1::vector::empty<0x1::string::String>();
            let v5 = &mut v4;
            0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"aadhar_qr"));
            0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"face_capture"));
            (0x1::string::utf8(b"18+ Age Verification"), 0x1::string::utf8(b"Verify user is 18 years or older using Aadhar and face verification"), v4, 365)
        } else {
            assert!(arg0 == 2, 5);
            let v6 = 0x1::vector::empty<0x1::string::String>();
            let v7 = &mut v6;
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"aadhar_qr"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"face_capture"));
            (0x1::string::utf8(b"Indian Citizenship Verification"), 0x1::string::utf8(b"Verify Indian citizenship using Aadhar document verification"), v6, 730)
        }
    }

    entry fun get_nautilus_signature(arg0: &DIDSoulBoundNFT) : vector<u8> {
        arg0.nautilus_signature
    }

    entry fun get_nft_metadata(arg0: &DIDSoulBoundNFT) : (0x1::string::String, 0x1::string::String, u8, u64, 0x1::string::String, vector<u8>) {
        (arg0.name, arg0.description, arg0.did_type, arg0.expiry_epoch, arg0.blob_id, arg0.nautilus_signature)
    }

    public fun get_user_did_status(arg0: &DIDRegistry, arg1: address, arg2: u8) : u8 {
        if (!0x2::table::contains<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg1)) {
            return 255
        };
        if (!0x2::table::contains<u8, 0x2::object::ID>(0x2::table::borrow<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg1), arg2)) {
            return 255
        };
        0
    }

    public fun has_verified_did(arg0: &DIDRegistry, arg1: address, arg2: u8) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg1)) {
            return false
        };
        if (!0x2::table::contains<u8, 0x2::object::ID>(0x2::table::borrow<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg1), arg2)) {
            return false
        };
        true
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DIDRegistry{
            id                 : 0x2::object::new(arg0),
            user_verifications : 0x2::table::new<address, 0x2::table::Table<u8, 0x2::object::ID>>(arg0),
            admin_addresses    : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = RegistryCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<DIDRegistry>(&v0),
        };
        0x2::transfer::share_object<DIDRegistry>(v0);
        0x2::transfer::transfer<RegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun is_nft_expired(arg0: &DIDSoulBoundNFT, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) >= arg0.expiry_epoch
    }

    public fun start_verification(arg0: &mut DIDRegistry, arg1: &RegistryCap, arg2: address, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.registry_id == 0x2::object::id<DIDRegistry>(arg0), 1);
        assert!(arg3 == 1 || arg3 == 2, 5);
        if (0x2::table::contains<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg2)) {
            assert!(!0x2::table::contains<u8, 0x2::object::ID>(0x2::table::borrow<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg2), arg3), 6);
        };
        let v0 = UserDID{
            id                     : 0x2::object::new(arg5),
            owner                  : arg2,
            did_type               : arg3,
            verification_status    : 0,
            verification_timestamp : 0x2::clock::timestamp_ms(arg4),
            expiry_epoch           : 0,
            blob_id                : 0x1::string::utf8(b""),
            nautilus_signature     : 0x1::vector::empty<u8>(),
            signature_timestamp_ms : 0,
            evidence_hash          : 0x1::vector::empty<u8>(),
            claimed                : false,
        };
        let v1 = 0x2::object::id<UserDID>(&v0);
        if (!0x2::table::contains<address, 0x2::table::Table<u8, 0x2::object::ID>>(&arg0.user_verifications, arg2)) {
            0x2::table::add<address, 0x2::table::Table<u8, 0x2::object::ID>>(&mut arg0.user_verifications, arg2, 0x2::table::new<u8, 0x2::object::ID>(arg5));
        };
        0x2::table::add<u8, 0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::table::Table<u8, 0x2::object::ID>>(&mut arg0.user_verifications, arg2), arg3, v1);
        0x2::transfer::share_object<UserDID>(v0);
        let v2 = VerificationStarted{
            registry_id  : 0x2::object::id<DIDRegistry>(arg0),
            user_address : arg2,
            did_type     : arg3,
            user_did_id  : v1,
        };
        0x2::event::emit<VerificationStarted>(v2);
        v1
    }

    public fun update_verification_status(arg0: &mut DIDRegistry, arg1: &RegistryCap, arg2: &mut UserDID, arg3: bool, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<DIDRegistry>(arg0), 1);
        let v0 = if (arg3) {
            1
        } else {
            2
        };
        arg2.verification_status = v0;
        arg2.verification_timestamp = 0x2::clock::timestamp_ms(arg7);
        arg2.nautilus_signature = arg4;
        arg2.signature_timestamp_ms = arg5;
        arg2.evidence_hash = arg6;
        if (arg3) {
            let (_, _, _, v4) = get_did_type_info(arg2.did_type);
            arg2.expiry_epoch = 0x2::tx_context::epoch(arg8) + v4;
        };
        let v5 = VerificationCompleted{
            registry_id            : 0x2::object::id<DIDRegistry>(arg0),
            user_address           : arg2.owner,
            did_type               : arg2.did_type,
            user_did_id            : 0x2::object::id<UserDID>(arg2),
            status                 : v0,
            nautilus_signature     : arg4,
            signature_timestamp_ms : arg5,
            evidence_hash          : arg6,
        };
        0x2::event::emit<VerificationCompleted>(v5);
    }

    public fun verify_did_for_protocol(arg0: &UserDID, arg1: &0x2::tx_context::TxContext) : bool {
        if (arg0.verification_status != 1 || !arg0.claimed) {
            return false
        };
        if (0x2::tx_context::epoch(arg1) >= arg0.expiry_epoch) {
            return false
        };
        true
    }

    // decompiled from Move bytecode v6
}

