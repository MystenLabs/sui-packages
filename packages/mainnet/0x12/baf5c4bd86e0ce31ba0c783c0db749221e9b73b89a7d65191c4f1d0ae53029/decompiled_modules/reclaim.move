module 0x12baf5c4bd86e0ce31ba0c783c0db749221e9b73b89a7d65191c4f1d0ae53029::reclaim {
    struct Witness has copy, drop, store {
        addr: vector<u8>,
        host: 0x1::string::String,
    }

    struct Epoch has store, key {
        id: 0x2::object::UID,
        epoch_number: u8,
        timestamp_start: u64,
        timestamp_end: u64,
        witnesses: vector<Witness>,
        minimum_witnesses_for_claim_creation: u128,
    }

    struct ClaimInfo has copy, drop, store {
        provider: 0x1::string::String,
        parameters: 0x1::string::String,
        context: 0x1::string::String,
    }

    struct SignedClaim has copy, drop, store {
        claim: CompleteClaimData,
        signatures: vector<vector<u8>>,
    }

    struct CompleteClaimData has copy, drop, store {
        identifier: 0x1::string::String,
        owner: 0x1::string::String,
        epoch: 0x1::string::String,
        timestamp_s: 0x1::string::String,
    }

    struct Proof has key {
        id: 0x2::object::UID,
        claim_info: ClaimInfo,
        signed_claim: SignedClaim,
    }

    struct ReclaimManager has key {
        id: 0x2::object::UID,
        owner: address,
        epoch_duration_s: u32,
        current_epoch: u8,
        epochs: vector<Epoch>,
        merkelized_user_params: 0x2::table::Table<vector<u8>, bool>,
        dapp_id_to_external_nullifier: 0x2::table::Table<vector<u8>, vector<u8>>,
    }

    public fun add_new_epoch(arg0: &mut ReclaimManager, arg1: vector<Witness>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = arg0.current_epoch + 1;
        let v1 = 0x2::tx_context::epoch(arg3);
        0x1::vector::push_back<Epoch>(&mut arg0.epochs, create_epoch(v0, v1, v1 + (arg0.epoch_duration_s as u64), arg1, arg2, arg3));
        arg0.current_epoch = v0;
    }

    public fun create_claim_data(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : CompleteClaimData {
        CompleteClaimData{
            identifier  : arg0,
            owner       : arg1,
            epoch       : arg2,
            timestamp_s : arg3,
        }
    }

    public fun create_claim_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : ClaimInfo {
        ClaimInfo{
            provider   : arg0,
            parameters : arg1,
            context    : arg2,
        }
    }

    public fun create_dapp(arg0: &mut ReclaimManager, arg1: vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::hash::keccak256(&v0);
        assert!(!0x2::table::contains<vector<u8>, vector<u8>>(&arg0.dapp_id_to_external_nullifier, v1), 0);
        0x2::table::add<vector<u8>, vector<u8>>(&mut arg0.dapp_id_to_external_nullifier, v1, arg1);
    }

    public fun create_epoch(arg0: u8, arg1: u64, arg2: u64, arg3: vector<Witness>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : Epoch {
        Epoch{
            id                                   : 0x2::object::new(arg5),
            epoch_number                         : arg0,
            timestamp_start                      : arg1,
            timestamp_end                        : arg2,
            witnesses                            : arg3,
            minimum_witnesses_for_claim_creation : arg4,
        }
    }

    public fun create_proof(arg0: ClaimInfo, arg1: SignedClaim, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Proof{
            id           : 0x2::object::new(arg2),
            claim_info   : arg0,
            signed_claim : arg1,
        };
        0x2::transfer::share_object<Proof>(v0);
    }

    public fun create_reclaim_manager(arg0: u32, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReclaimManager{
            id                            : 0x2::object::new(arg1),
            owner                         : 0x2::tx_context::sender(arg1),
            epoch_duration_s              : arg0,
            current_epoch                 : 0,
            epochs                        : 0x1::vector::empty<Epoch>(),
            merkelized_user_params        : 0x2::table::new<vector<u8>, bool>(arg1),
            dapp_id_to_external_nullifier : 0x2::table::new<vector<u8>, vector<u8>>(arg1),
        };
        0x2::transfer::share_object<ReclaimManager>(v0);
    }

    public fun create_signed_claim(arg0: CompleteClaimData, arg1: vector<vector<u8>>) : SignedClaim {
        SignedClaim{
            claim      : arg0,
            signatures : arg1,
        }
    }

    public fun create_witness(arg0: vector<u8>, arg1: 0x1::string::String) : Witness {
        Witness{
            addr : arg0,
            host : arg1,
        }
    }

    public fun fetch_epoch(arg0: &ReclaimManager) : &Epoch {
        0x1::vector::borrow<Epoch>(&arg0.epochs, ((arg0.current_epoch - 1) as u64))
    }

    fun fetch_witnesses_for_claim(arg0: &ReclaimManager, arg1: 0x1::string::String) : vector<vector<u8>> {
        let v0 = fetch_epoch(arg0);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, arg1);
        let v2 = 0x2::hash::keccak256(0x1::string::bytes(&v1));
        let v3 = v0.witnesses;
        let v4 = 0x1::vector::empty<vector<u8>>();
        let v5 = 0x1::vector::length<Witness>(&v3);
        let v6 = 0;
        let v7 = 0;
        while (v7 < v0.minimum_witnesses_for_claim_creation) {
            let v8 = 0x1::vector::remove<Witness>(&mut v3, ((*0x1::vector::borrow<u8>(&v2, 0) as u64) + v6) % v5);
            0x1::vector::push_back<vector<u8>>(&mut v4, v8.addr);
            let v9 = v6 + 4;
            v6 = v9 % 0x1::vector::length<u8>(&v2);
            v5 = v5 - 1;
            v7 = v7 + 1;
        };
        v4
    }

    public fun get_merkellized_user_params(arg0: &ReclaimManager, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.merkelized_user_params, hash_user_params(arg1, arg2))
    }

    public fun get_provider_from_proof(arg0: &Proof) : 0x1::string::String {
        arg0.claim_info.provider
    }

    fun hash_user_params(arg0: 0x1::string::String, arg1: 0x1::string::String) : vector<u8> {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, arg1);
        0x2::hash::keccak256(0x1::string::bytes(&v0))
    }

    fun recover_signers_of_signed_claim(arg0: SignedClaim) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = 0x1::string::utf8(x"0a");
        let v2 = 0x1::string::utf8(b"");
        let v3 = arg0.claim.timestamp_s;
        0x1::string::append(&mut v3, v1);
        0x1::string::append(&mut v3, arg0.claim.epoch);
        0x1::string::append(&mut v2, arg0.claim.identifier);
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, arg0.claim.owner);
        0x1::string::append(&mut v2, v1);
        0x1::string::append(&mut v2, v3);
        let v4 = 0x1::string::utf8(x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::string::append(&mut v4, 0x1::string::utf8(b"122"));
        0x1::string::append(&mut v4, v2);
        let v5 = 0x1::string::bytes(&v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg0.signatures)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x12baf5c4bd86e0ce31ba0c783c0db749221e9b73b89a7d65191c4f1d0ae53029::ecdsa::ecrecover_to_eth_address(*0x1::vector::borrow<vector<u8>>(&arg0.signatures, v6), *v5));
            v6 = v6 + 1;
        };
        v0
    }

    public fun verify_proof(arg0: &ReclaimManager, arg1: &Proof) : vector<vector<u8>> {
        assert!(0x1::vector::length<vector<u8>>(&arg1.signed_claim.signatures) > 0, 0);
        let v0 = SignedClaim{
            claim      : arg1.signed_claim.claim,
            signatures : arg1.signed_claim.signatures,
        };
        let v1 = fetch_witnesses_for_claim(arg0, arg1.signed_claim.claim.identifier);
        let v2 = recover_signers_of_signed_claim(v0);
        assert!(0x1::vector::length<vector<u8>>(&v2) == 0x1::vector::length<vector<u8>>(&v1), 0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&v2)) {
            let v4 = false;
            let v5 = 0;
            while (v5 < 0x1::vector::length<vector<u8>>(&v1)) {
                if (*0x1::vector::borrow<vector<u8>>(&v2, v3) == *0x1::vector::borrow<vector<u8>>(&v1, v5)) {
                    v4 = true;
                    break
                };
                v5 = v5 + 1;
            };
            assert!(v4, 0);
            v3 = v3 + 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

