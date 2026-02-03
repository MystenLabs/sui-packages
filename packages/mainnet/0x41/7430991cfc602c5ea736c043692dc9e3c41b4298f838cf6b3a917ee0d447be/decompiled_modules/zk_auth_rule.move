module 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::zk_auth_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has store {
        curve: 0x2::groth16::Curve,
        vk: 0x2::groth16::PreparedVerifyingKey,
        merkle_tree: MerkleTree,
        nullifiers: 0x2::table::Table<u256, bool>,
        vault_address: address,
    }

    struct MerkleTree has drop, store {
        next_index: u64,
        subtrees: vector<u256>,
        root_history: vector<u256>,
        root_index: u64,
    }

    struct AuthorizationProof has copy, drop {
        proof_points: vector<u8>,
        root: u256,
        nullifier: u256,
    }

    struct CommitmentAdded has copy, drop {
        policy_id: 0x2::object::ID,
        index: u64,
        commitment: u256,
    }

    struct NullifierSpent has copy, drop {
        policy_id: 0x2::object::ID,
        nullifier: u256,
    }

    public fun add(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::groth16::bn254();
        let v1 = Rule{dummy_field: false};
        let v2 = Config{
            curve         : v0,
            vk            : 0x2::groth16::prepare_verifying_key(&v0, &arg3),
            merkle_tree   : new_merkle_tree(),
            nullifiers    : 0x2::table::new<u256, bool>(arg4),
            vault_address : arg2,
        };
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::add_main_rule<Rule, Config>(v1, arg0, arg1, v2);
    }

    public fun add_authorized_user(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap, arg2: u256) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert!(1 << (26 as u8) > v1.merkle_tree.next_index, 0);
        let v2 = &mut v1.merkle_tree;
        append_commitment(v2, arg2);
        let v3 = CommitmentAdded{
            policy_id  : 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::policy_id(arg0),
            index      : v1.merkle_tree.next_index,
            commitment : arg2,
        };
        0x2::event::emit<CommitmentAdded>(v3);
    }

    fun append_commitment(arg0: &mut MerkleTree, arg1: u256) {
        let v0 = empty_subtree_hashes();
        let v1 = arg0.next_index;
        let v2 = arg1;
        let v3 = 0;
        while (v3 < 26) {
            let (v4, v5) = if (v1 % 2 == 0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.subtrees, v3) = v2;
                let v4 = v2;
                (v4, *0x1::vector::borrow<u256>(&v0, v3))
            } else {
                let v5 = v2;
                (*0x1::vector::borrow_mut<u256>(&mut arg0.subtrees, v3), v5)
            };
            v2 = poseidon2(v4, v5);
            v1 = v1 / 2;
            v3 = v3 + 1;
        };
        let v6 = (arg0.root_index + 1) % 100;
        arg0.root_index = v6;
        if (0x1::vector::length<u256>(&arg0.root_history) <= v6) {
            0x1::vector::push_back<u256>(&mut arg0.root_history, v2);
        } else {
            *0x1::vector::borrow_mut<u256>(&mut arg0.root_history, v6) = v2;
        };
        arg0.next_index = arg0.next_index + 1;
    }

    fun bn254_field_modulus() : u256 {
        21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    fun build_public_inputs(arg0: address, arg1: u256, arg2: u256) : 0x2::groth16::PublicProofInputs {
        let v0 = bn254_field_modulus();
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, to_field(0x2::address::to_u256(arg0), v0));
        0x1::vector::append<u8>(&mut v1, to_field(arg1, v0));
        0x1::vector::append<u8>(&mut v1, to_field(arg2, v0));
        0x2::groth16::public_proof_inputs_from_bytes(v1)
    }

    public fun current_root(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy) : u256 {
        let v0 = Rule{dummy_field: false};
        let v1 = &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0).merkle_tree;
        *0x1::vector::borrow<u256>(&v1.root_history, v1.root_index)
    }

    fun empty_subtree_hashes() : vector<u256> {
        vector[18688842432741139442778047327644092677418528270738216181718229581494125774932, 929670100605127589096201729966801143828059989180770638007278601230757123028, 20059153686521406362481271315473498068253845102360114882796737328118528819600, 667276972495892769517195136104358636854444397700904910347259067486374491460, 12333205860481369973758777121486440301866097422034925170601892818077919669856, 13265906118204670164732063746425660672195834675096811019428798251172285860978, 3254533810100792365765975246297999341668420141674816325048742255119776645299, 18309808253444361227126414342398728022042151803316641228967342967902364963927, 12126650299593052178871547753567584772895820192048806970138326036720774331291, 9949817351285988369728267498508465715570337443235086859122087250007803517342, 11208526958197959509185914785003803401681281543885952782991980697855275912368, 59685738145310886711325295148553591612803302297715439999772116453982910402, 20837058910394942465479261789141487609029093821244922450759151002393360448717, 8209451842087447702442792222326370366485985268583914555249981462794434142285, 19651337661238139284113069695072175498780734789512991455990330919229086149402, 11527931080332651861006914960138009072130600556413592683110711451245237795573, 20764556403192106825184782309105498322242675071639346714780565918367449744227, 10818178251908058160377157228631396071771716850372988172358158281935915764080, 21598305620835755437985090087223184201582363356396834169567261294737143234327, 16481295130402928965223624965091828506529631770925981912487987233811901391354, 17911512007742433173433956238979622028159186641781974955249650899638270671335, 5186032540459307640178997905000265487821097518169449170073506338735292796958, 19685513117592528774434273738957742787082069361009067298107167967352389473358, 10912258653908058948673432107359060806004349811796220228800269957283778663923, 19880031465088514794850462701773174075421406509504511537647395867323147191667, 18344394662872801094289264994998928886741543433797415760903591256277307773470, 4023688209857926016730691838838984168964497755397275208674494663143007853450]
    }

    public fun is_configured(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy) : bool {
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::has_rule<Rule>(arg0)
    }

    fun is_known_root(arg0: &MerkleTree, arg1: u256) : bool {
        if (arg1 == 0) {
            return false
        };
        let v0 = arg0.root_index;
        let v1 = 0x1::vector::length<u256>(&arg0.root_history);
        loop {
            if (v0 < v1 && *0x1::vector::borrow<u256>(&arg0.root_history, v0) == arg1) {
                return true
            };
            if (v0 == 0) {
                let v2 = if (v1 < 100) {
                    v1 - 1
                } else {
                    100 - 1
                };
                v0 = v2;
            } else {
                v0 = v0 - 1;
            };
            if (v0 == arg0.root_index) {
                break
            };
        };
        false
    }

    public fun is_nullifier_spent(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg1: u256) : bool {
        let v0 = Rule{dummy_field: false};
        0x2::table::contains<u256, bool>(&0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0).nullifiers, arg1)
    }

    fun new_merkle_tree() : MerkleTree {
        let v0 = empty_subtree_hashes();
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 26) {
            0x1::vector::push_back<u256>(&mut v1, *0x1::vector::borrow<u256>(&v0, v2));
            v2 = v2 + 1;
        };
        let v3 = vector[];
        0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&v0, 26));
        MerkleTree{
            next_index   : 0,
            subtrees     : v1,
            root_history : v3,
            root_index   : 0,
        }
    }

    public fun new_proof(arg0: vector<u8>, arg1: u256, arg2: u256) : AuthorizationProof {
        AuthorizationProof{
            proof_points : arg0,
            root         : arg1,
            nullifier    : arg2,
        }
    }

    public fun next_index(arg0: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy) : u64 {
        let v0 = Rule{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg0).merkle_tree.next_index
    }

    fun poseidon2(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    public fun prove(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessRequest, arg1: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg2: AuthorizationProof) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule<Rule, Config>(v0, arg1);
        assert!(is_known_root(&v1.merkle_tree, arg2.root), 3);
        assert!(!0x2::table::contains<u256, bool>(&v1.nullifiers, arg2.nullifier), 2);
        let v2 = build_public_inputs(v1.vault_address, arg2.root, arg2.nullifier);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg2.proof_points);
        assert!(0x2::groth16::verify_groth16_proof(&v1.curve, &v1.vk, &v2, &v3), 1);
        let v4 = Rule{dummy_field: false};
        0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::add_receipt<Rule>(v4, arg0);
    }

    public fun prove_and_spend(arg0: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessRequest, arg1: &mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicy, arg2: &0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::AccessPolicyCap, arg3: AuthorizationProof) {
        prove(arg0, arg1, arg3);
        let v0 = Rule{dummy_field: false};
        0x2::table::add<u256, bool>(&mut 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::get_rule_mut<Rule, Config>(v0, arg1, arg2).nullifiers, arg3.nullifier, true);
        let v1 = NullifierSpent{
            policy_id : 0x417430991cfc602c5ea736c043692dc9e3c41b4298f838cf6b3a917ee0d447be::access_policy::policy_id(arg1),
            nullifier : arg3.nullifier,
        };
        0x2::event::emit<NullifierSpent>(v1);
    }

    fun to_field(arg0: u256, arg1: u256) : vector<u8> {
        let v0 = arg0 % arg1;
        0x2::bcs::to_bytes<u256>(&v0)
    }

    // decompiled from Move bytecode v6
}

