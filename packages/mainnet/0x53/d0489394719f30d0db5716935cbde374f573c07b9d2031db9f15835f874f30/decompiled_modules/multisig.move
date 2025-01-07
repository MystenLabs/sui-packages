module 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::multisig {
    struct Executed has copy, drop {
        proposal_id: u64,
        command: 0x1::string::String,
    }

    struct Signer has drop, store {
        pub_key: vector<u8>,
        sui_address: address,
        weight: u8,
    }

    struct MultisigWallet has store {
        multisig_address: address,
        signers: vector<Signer>,
        threshold: u16,
    }

    struct MultiSignature has drop {
        signatures: vector<vector<u8>>,
        bitmap: u16,
        multi_pubkey: MultiPubKey,
    }

    struct MultiPubKey has drop {
        weighted_pubkey: vector<vector<u8>>,
        threshold: u16,
    }

    struct Proposal has copy, drop, store {
        id: u64,
        title: 0x1::string::String,
        multisig_address: address,
        tx_data: vector<u8>,
        is_digest: bool,
        approved: bool,
    }

    struct Vote has drop, store {
        signature: vector<u8>,
        voter: address,
    }

    struct VoteKey has copy, drop, store {
        proposal_id: u64,
        sui_address: address,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        wallets: 0x2::vec_map::VecMap<address, MultisigWallet>,
        wallet_proposals: 0x2::table::Table<address, vector<u64>>,
        proposals: 0x2::table::Table<u64, Proposal>,
        votes: 0x2::table::Table<VoteKey, Vote>,
        proposal_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun approve_proposal(arg0: &mut Storage, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::base64::decode(&arg2);
        let v1 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        let v2 = 0x2::vec_map::get<address, MultisigWallet>(&arg0.wallets, &v1.multisig_address);
        assert!(only_member(v2, 0x2::tx_context::sender(arg3)) == true, 12);
        let (v3, v4) = get_pubkey(v2, 0x2::tx_context::sender(arg3));
        let v5 = v4;
        assert!(v3 != 0, 9223372951682809855);
        assert!(verify_pubkey(&v5, &v1.tx_data, &v0, v1.is_digest) == true, 9223372955977777151);
        let v6 = VoteKey{
            proposal_id : arg1,
            sui_address : 0x2::tx_context::sender(arg3),
        };
        assert!(0x2::table::contains<VoteKey, Vote>(&arg0.votes, v6) == false, 10);
        let v7 = Vote{
            signature : v0,
            voter     : 0x2::tx_context::sender(arg3),
        };
        0x2::table::add<VoteKey, Vote>(&mut arg0.votes, v6, v7);
        let v8 = 0x1::vector::empty<vector<u8>>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<Signer>(&v2.signers)) {
            let v10 = VoteKey{
                proposal_id : arg1,
                sui_address : 0x1::vector::borrow<Signer>(&v2.signers, v9).sui_address,
            };
            if (0x2::table::contains<VoteKey, Vote>(&arg0.votes, v10)) {
                0x1::vector::push_back<vector<u8>>(&mut v8, 0x2::table::borrow<VoteKey, Vote>(&arg0.votes, v10).signature);
            };
            v9 = v9 + 1;
        };
        if (0x1::vector::length<vector<u8>>(&v8) >= (v2.threshold as u64)) {
            0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1).approved = true;
        };
    }

    public fun create_multi_signature(arg0: &vector<vector<u8>>, arg1: &vector<Signer>, arg2: u16) : MultiSignature {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0x1::vector::empty<vector<u8>>();
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let (v4, v5, v6) = split_signature(0x1::vector::borrow<vector<u8>>(arg0, v1));
            let v7 = get_pub_key_index(arg1, v5);
            assert!(v7 > 0, 9223373437014114303);
            let v8 = v0;
            v0 = v8 | 1 << v7 - 1;
            0x1::debug::print<u16>(&v0);
            let v9 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v9, v6);
            0x1::vector::append<u8>(&mut v9, v4);
            0x1::vector::push_back<vector<u8>>(&mut v2, v9);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<Signer>(arg1)) {
            let v10 = 0x1::vector::borrow<Signer>(arg1, v1).pub_key;
            0x1::vector::push_back<u8>(&mut v10, 0x1::vector::borrow<Signer>(arg1, v1).weight);
            0x1::vector::push_back<vector<u8>>(&mut v3, v10);
            v1 = v1 + 1;
        };
        let v11 = MultiPubKey{
            weighted_pubkey : v3,
            threshold       : arg2,
        };
        MultiSignature{
            signatures   : v2,
            bitmap       : v0,
            multi_pubkey : v11,
        }
    }

    public fun create_multisig_address(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: u16) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg2));
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg0, v1));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    entry fun create_proposal(arg0: &mut Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::base64::decode(&arg2);
        assert!(only_member(0x2::vec_map::get<address, MultisigWallet>(&arg0.wallets, &arg3), 0x2::tx_context::sender(arg4)) == true, 12);
        let v1 = get_proposal_id(arg0);
        let v2 = Proposal{
            id               : v1,
            title            : arg1,
            multisig_address : arg3,
            tx_data          : v0,
            is_digest        : 0x1::vector::length<u8>(&v0) == 32,
            approved         : false,
        };
        0x2::table::add<u64, Proposal>(&mut arg0.proposals, v1, v2);
        0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.wallet_proposals, arg3), v1);
    }

    entry fun execute_event(arg0: &Storage, arg1: u64) {
        let v0 = Executed{
            proposal_id : arg1,
            command     : get_execute_command(arg0, arg1),
        };
        0x2::event::emit<Executed>(v0);
    }

    public fun get_execute_command(arg0: &Storage, arg1: u64) : 0x1::string::String {
        let v0 = 0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1);
        let v1 = 0x2::vec_map::get<address, MultisigWallet>(&arg0.wallets, &v0.multisig_address);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<Signer>(&v1.signers)) {
            let v4 = VoteKey{
                proposal_id : arg1,
                sui_address : 0x1::vector::borrow<Signer>(&v1.signers, v3).sui_address,
            };
            if (0x2::table::contains<VoteKey, Vote>(&arg0.votes, v4)) {
                0x1::vector::push_back<vector<u8>>(&mut v2, 0x2::table::borrow<VoteKey, Vote>(&arg0.votes, v4).signature);
            };
            v3 = v3 + 1;
        };
        assert!(0x1::vector::length<vector<u8>>(&v2) >= (v1.threshold as u64), 11);
        let v5 = create_multi_signature(&v2, &v1.signers, v1.threshold);
        let v6 = serialize_multisig(&v5);
        let v7 = 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::base64::encode(&v6);
        let v8 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v8, b"sui client execute-signed-tx --tx-bytes ");
        let v9 = 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::base64::encode(&v0.tx_data);
        if (v0.is_digest) {
            0x1::vector::append<u8>(&mut v8, b"${ORIGINAL_TX_BYTES}");
        } else {
            0x1::vector::append<u8>(&mut v8, *0x1::string::as_bytes(&v9));
        };
        0x1::vector::append<u8>(&mut v8, b" --signatures ");
        0x1::vector::append<u8>(&mut v8, *0x1::string::as_bytes(&v7));
        0x1::string::utf8(v8)
    }

    fun get_intent_message(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, *arg0);
        v0
    }

    fun get_proposal_id(arg0: &mut Storage) : u64 {
        let v0 = arg0.proposal_count + 1;
        arg0.proposal_count = v0;
        v0
    }

    public fun get_proposals(arg0: &Storage) : vector<Proposal> {
        let v0 = 1;
        let v1 = 0x1::vector::empty<Proposal>();
        while (v0 <= arg0.proposal_count) {
            0x1::vector::push_back<Proposal>(&mut v1, *0x2::table::borrow<u64, Proposal>(&arg0.proposals, v0));
            v0 = v0 + 1;
        };
        v1
    }

    fun get_pub_key_index(arg0: &vector<Signer>, arg1: vector<u8>) : u8 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Signer>(arg0)) {
            let v1 = 0x1::vector::borrow<Signer>(arg0, v0).pub_key;
            if (slice_vector(&v1, 1, 0x1::vector::length<u8>(&v1) - 1) == arg1) {
                return ((v0 + 1) as u8)
            };
            v0 = v0 + 1;
        };
        0
    }

    fun get_pubkey(arg0: &MultisigWallet, arg1: address) : (u64, vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Signer>(&arg0.signers)) {
            if (0x1::vector::borrow<Signer>(&arg0.signers, v0).sui_address == arg1) {
                return (v0 + 1, 0x1::vector::borrow<Signer>(&arg0.signers, v0).pub_key)
            };
            v0 = v0 + 1;
        };
        (0, x"00")
    }

    public fun get_wallets(arg0: &Storage) : &0x2::vec_map::VecMap<address, MultisigWallet> {
        &arg0.wallets
    }

    public fun has_member_voted(arg0: &Storage, arg1: u64, arg2: address) : bool {
        let v0 = VoteKey{
            proposal_id : arg1,
            sui_address : arg2,
        };
        0x2::table::contains<VoteKey, Vote>(&arg0.votes, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Storage{
            id               : 0x2::object::new(arg0),
            wallets          : 0x2::vec_map::empty<address, MultisigWallet>(),
            wallet_proposals : 0x2::table::new<address, vector<u64>>(arg0),
            proposals        : 0x2::table::new<u64, Proposal>(arg0),
            votes            : 0x2::table::new<VoteKey, Vote>(arg0),
            proposal_count   : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Storage>(v1);
    }

    public fun multisig_address(arg0: &MultisigWallet) : address {
        arg0.multisig_address
    }

    public fun new_signer(arg0: vector<u8>, arg1: u8) : Signer {
        Signer{
            pub_key     : arg0,
            sui_address : 0x2::address::from_bytes(0x2::hash::blake2b256(&arg0)),
            weight      : arg1,
        }
    }

    fun only_member(arg0: &MultisigWallet, arg1: address) : bool {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<Signer>(&arg0.signers) && v1 == false) {
            if (0x1::vector::borrow<Signer>(&arg0.signers, v0).sui_address == arg1) {
                v1 = true;
            };
            v0 = v0 + 1;
        };
        v1
    }

    entry fun register_wallet(arg0: &mut Storage, arg1: &AdminCap, arg2: vector<0x1::string::String>, arg3: vector<u8>, arg4: u16) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u8>(&arg3), 9223372749819346943);
        assert!(arg4 > 0, 9223372754114314239);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0x1::vector::empty<Signer>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v3 = 0x53d0489394719f30d0db5716935cbde374f573c07b9d2031db9f15835f874f30::base64::decode(0x1::vector::borrow<0x1::string::String>(&arg2, v2));
            0x1::vector::push_back<vector<u8>>(&mut v0, v3);
            0x1::vector::push_back<Signer>(&mut v1, new_signer(v3, *0x1::vector::borrow<u8>(&arg3, v2)));
            v2 = v2 + 1;
        };
        let v4 = create_multisig_address(v0, arg3, arg4);
        let v5 = MultisigWallet{
            multisig_address : v4,
            signers          : v1,
            threshold        : arg4,
        };
        0x2::vec_map::insert<address, MultisigWallet>(&mut arg0.wallets, v4, v5);
        0x2::table::add<address, vector<u64>>(&mut arg0.wallet_proposals, v4, 0x1::vector::empty<u64>());
    }

    public fun serialize_multisig(arg0: &MultiSignature) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<vector<u8>>(&arg0.signatures) as u8));
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.signatures)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg0.signatures, v1));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u16>(&arg0.bitmap));
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<vector<u8>>(&arg0.multi_pubkey.weighted_pubkey) as u8));
        v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.multi_pubkey.weighted_pubkey)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg0.multi_pubkey.weighted_pubkey, v1));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u16>(&arg0.multi_pubkey.threshold));
        v0
    }

    public fun slice_vector(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun split_signature(arg0: &vector<u8>) : (vector<u8>, vector<u8>, u8) {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let v1 = if (v0 == 0) {
            32
        } else {
            33
        };
        (slice_vector(arg0, 1, 64), slice_vector(arg0, 0x1::vector::length<u8>(arg0) - v1, v1), v0)
    }

    public fun verify_pubkey(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: bool) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let v1 = slice_vector(arg0, 1, 0x1::vector::length<u8>(arg0) - 1);
        let (v2, v3, _) = split_signature(arg2);
        let v5 = v2;
        assert!(v1 == v3, 9223373746251759615);
        let v6 = if (arg3 == true) {
            arg1
        } else {
            let v7 = get_intent_message(arg1);
            let v8 = 0x2::hash::blake2b256(&v7);
            &v8
        };
        if (v0 == 0) {
            0x2::ed25519::ed25519_verify(&v5, &v1, v6)
        } else if (v0 == 1) {
            0x2::ecdsa_k1::secp256k1_verify(&v5, &v1, v6, 1)
        } else if (v0 == 2) {
            0x2::ecdsa_r1::secp256r1_verify(&v5, &v1, v6, 1)
        } else {
            return false
        }
    }

    // decompiled from Move bytecode v6
}

