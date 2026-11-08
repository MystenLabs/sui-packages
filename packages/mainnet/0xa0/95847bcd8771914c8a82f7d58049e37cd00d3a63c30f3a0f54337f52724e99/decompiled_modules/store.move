module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::store {
    struct Store has key {
        id: 0x2::object::UID,
        helm_key: 0x1::option::Option<vector<u8>>,
        resolver_keys: vector<vector<u8>>,
        nonces: 0x2::table::Table<address, bool>,
        retired_unseen: 0x2::table::Table<address, bool>,
        succession: 0x2::table::Table<address, address>,
        grants: 0x2::table::Table<address, 0x2::object::ID>,
        reservations: 0x2::table::Table<address, 0x2::object::ID>,
        revocations: 0x2::table::Table<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation>,
        receipts: 0x2::table::Table<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>,
        decisions: u64,
        payer_count: u64,
        charter: 0x1::option::Option<address>,
        agreement: 0x1::option::Option<address>,
        roots: 0x2::table::Table<address, bool>,
    }

    struct PayerKey has copy, drop, store {
        envelope_id: address,
        effector: 0x1::string::String,
    }

    struct EffectorKey has copy, drop, store {
        effector: 0x1::string::String,
    }

    struct EnvelopeKey has copy, drop, store {
        envelope_id: address,
    }

    struct PlaceKey has copy, drop, store {
        holder: address,
    }

    struct Payer has copy, drop, store {
        effector: 0x1::string::String,
        envelope_id: address,
        terms_hash: address,
        terms: vector<u8>,
        retired: bool,
    }

    public fun receipt(arg0: &Store, arg1: address) : &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment {
        0x2::table::borrow<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&arg0.receipts, arg1)
    }

    public fun revocation(arg0: &Store, arg1: address) : &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation {
        0x2::table::borrow<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation>(&arg0.revocations, arg1)
    }

    public(friend) fun add_grant(arg0: &mut Store, arg1: &0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant) {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::envelope_id(arg1);
        if (0x1::option::is_none<address>(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::parent(arg1)) && !0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::is_floor(arg1)) {
            let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::grant_effectors(0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::record(arg1));
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v1)) {
                let v3 = 0x1::vector::borrow<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::EffectorGrant>(v1, v2);
                if (0x1::option::is_some<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_terms_hash(v3))) {
                    let v4 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::terms_for(arg1, 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v3));
                    if (0x1::option::is_some<vector<u8>>(&v4)) {
                        add_payer(arg0, v0, *0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_id(v3), *0x1::option::borrow<address>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::effector_terms_hash(v3)), 0x1::option::destroy_some<vector<u8>>(v4), 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::retired(arg1));
                    } else {
                        0x1::option::destroy_none<vector<u8>>(v4);
                    };
                };
                v2 = v2 + 1;
            };
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.grants, v0, 0x2::object::id<0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::grant::Grant>(arg1));
    }

    fun add_payer(arg0: &mut Store, arg1: address, arg2: 0x1::string::String, arg3: address, arg4: vector<u8>, arg5: bool) {
        let v0 = PayerKey{
            envelope_id : arg1,
            effector    : arg2,
        };
        if (!0x2::dynamic_field::exists_<PayerKey>(&arg0.id, v0)) {
            let v1 = Payer{
                effector    : arg2,
                envelope_id : arg1,
                terms_hash  : arg3,
                terms       : arg4,
                retired     : arg5,
            };
            0x2::dynamic_field::add<PayerKey, Payer>(&mut arg0.id, v0, v1);
            arg0.payer_count = arg0.payer_count + 1;
            let v2 = EnvelopeKey{envelope_id: arg1};
            if (0x2::dynamic_field::exists_<EnvelopeKey>(&arg0.id, v2)) {
                0x1::vector::push_back<0x1::string::String>(0x2::dynamic_field::borrow_mut<EnvelopeKey, vector<0x1::string::String>>(&mut arg0.id, v2), arg2);
            } else {
                let v3 = 0x1::vector::empty<0x1::string::String>();
                0x1::vector::push_back<0x1::string::String>(&mut v3, arg2);
                0x2::dynamic_field::add<EnvelopeKey, vector<0x1::string::String>>(&mut arg0.id, v2, v3);
            };
        };
        if (arg5) {
            return
        };
        let v4 = EffectorKey{effector: arg2};
        if (0x2::dynamic_field::exists_<EffectorKey>(&arg0.id, v4)) {
            0x1::vector::push_back<address>(0x2::dynamic_field::borrow_mut<EffectorKey, vector<address>>(&mut arg0.id, v4), arg1);
        } else {
            let v5 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v5, arg1);
            0x2::dynamic_field::add<EffectorKey, vector<address>>(&mut arg0.id, v4, v5);
        };
    }

    public(friend) fun add_reservation(arg0: &mut Store, arg1: address, arg2: 0x2::object::ID) {
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.reservations, arg1, arg2);
    }

    public(friend) fun add_resolver_key(arg0: &mut Store, arg1: vector<u8>) {
        if (!0x1::vector::contains<vector<u8>>(&arg0.resolver_keys, &arg1)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.resolver_keys, arg1);
        };
    }

    public(friend) fun add_retired_unseen(arg0: &mut Store, arg1: address) {
        if (!0x2::table::contains<address, bool>(&arg0.retired_unseen, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.retired_unseen, arg1, true);
        };
    }

    public(friend) fun add_revocation(arg0: &mut Store, arg1: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation) {
        let v0 = 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::envelope_id(&arg1);
        if (!0x2::table::contains<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation>(&arg0.revocations, v0)) {
            0x2::table::add<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation>(&mut arg0.revocations, v0, arg1);
        };
    }

    public fun agreement(arg0: &Store) : &0x1::option::Option<address> {
        &arg0.agreement
    }

    public fun charter(arg0: &Store) : &0x1::option::Option<address> {
        &arg0.charter
    }

    public(friend) fun consume_nonce(arg0: &mut Store, arg1: address) {
        0x2::table::add<address, bool>(&mut arg0.nonces, arg1, true);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Store {
        Store{
            id             : 0x2::object::new(arg0),
            helm_key       : 0x1::option::none<vector<u8>>(),
            resolver_keys  : vector[],
            nonces         : 0x2::table::new<address, bool>(arg0),
            retired_unseen : 0x2::table::new<address, bool>(arg0),
            succession     : 0x2::table::new<address, address>(arg0),
            grants         : 0x2::table::new<address, 0x2::object::ID>(arg0),
            reservations   : 0x2::table::new<address, 0x2::object::ID>(arg0),
            revocations    : 0x2::table::new<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation>(arg0),
            receipts       : 0x2::table::new<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(arg0),
            decisions      : 0,
            payer_count    : 0,
            charter        : 0x1::option::none<address>(),
            agreement      : 0x1::option::none<address>(),
            roots          : 0x2::table::new<address, bool>(arg0),
        }
    }

    public fun decisions(arg0: &Store) : u64 {
        arg0.decisions
    }

    public(friend) fun free_place(arg0: &mut Store, arg1: address) {
        let v0 = PlaceKey{holder: arg1};
        if (0x2::dynamic_field::exists_<PlaceKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<PlaceKey, bool>(&mut arg0.id, v0);
        };
    }

    public(friend) fun give(arg0: Store, arg1: address) {
        0x2::transfer::transfer<Store>(arg0, arg1);
    }

    public fun grant_object(arg0: &Store, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.grants, arg1)
    }

    public fun has_grant(arg0: &Store, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.grants, arg1)
    }

    public fun has_receipt(arg0: &Store, arg1: address) : bool {
        0x2::table::contains<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&arg0.receipts, arg1)
    }

    public fun has_reservation(arg0: &Store, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.reservations, arg1)
    }

    public fun has_resolver_key(arg0: &Store, arg1: &vector<u8>) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.resolver_keys, arg1)
    }

    public fun has_revocation(arg0: &Store, arg1: address) : bool {
        0x2::table::contains<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation::Revocation>(&arg0.revocations, arg1)
    }

    public fun helm_key(arg0: &Store) : &0x1::option::Option<vector<u8>> {
        &arg0.helm_key
    }

    public fun holds_place(arg0: &Store, arg1: address) : bool {
        let v0 = PlaceKey{holder: arg1};
        0x2::dynamic_field::exists_<PlaceKey>(&arg0.id, v0)
    }

    public fun is_retired_unseen(arg0: &Store, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.retired_unseen, arg1)
    }

    public fun nonce_consumed(arg0: &Store, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.nonces, arg1)
    }

    public(friend) fun note_root(arg0: &mut Store, arg1: address) : bool {
        if (0x2::table::contains<address, bool>(&arg0.roots, arg1)) {
            return false
        };
        0x2::table::add<address, bool>(&mut arg0.roots, arg1, true);
        true
    }

    public fun payer_count(arg0: &Store) : u64 {
        arg0.payer_count
    }

    public fun payer_effector(arg0: &Payer) : &0x1::string::String {
        &arg0.effector
    }

    public fun payer_envelope_id(arg0: &Payer) : address {
        arg0.envelope_id
    }

    public fun payer_for(arg0: &Store, arg1: &0x1::string::String) : 0x1::option::Option<Payer> {
        let v0 = EffectorKey{effector: *arg1};
        if (!0x2::dynamic_field::exists_<EffectorKey>(&arg0.id, v0)) {
            return 0x1::option::none<Payer>()
        };
        let v1 = 0x2::dynamic_field::borrow<EffectorKey, vector<address>>(&arg0.id, v0);
        if (0x1::vector::length<address>(v1) != 1) {
            return 0x1::option::none<Payer>()
        };
        let v2 = PayerKey{
            envelope_id : *0x1::vector::borrow<address>(v1, 0),
            effector    : *arg1,
        };
        0x1::option::some<Payer>(*0x2::dynamic_field::borrow<PayerKey, Payer>(&arg0.id, v2))
    }

    public fun payer_retired(arg0: &Payer) : bool {
        arg0.retired
    }

    public fun payer_terms(arg0: &Payer) : &vector<u8> {
        &arg0.terms
    }

    public fun payer_terms_hash(arg0: &Payer) : address {
        arg0.terms_hash
    }

    public(friend) fun record_receipt(arg0: &mut Store, arg1: address, arg2: 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment) {
        0x2::table::add<address, 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::receipt::ReceiptCommitment>(&mut arg0.receipts, arg1, arg2);
        arg0.decisions = arg0.decisions + 1;
    }

    public fun reservation_object(arg0: &Store, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.reservations, arg1)
    }

    public fun resolve(arg0: &Store, arg1: address) : address {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 8 && 0x2::table::contains<address, address>(&arg0.succession, v0)) {
            let v2 = 0x2::table::borrow<address, address>(&arg0.succession, v0);
            v0 = *v2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun resolver_keys(arg0: &Store) : &vector<vector<u8>> {
        &arg0.resolver_keys
    }

    public(friend) fun retire_payer(arg0: &mut Store, arg1: address) {
        let v0 = EnvelopeKey{envelope_id: arg1};
        if (!0x2::dynamic_field::exists_<EnvelopeKey>(&arg0.id, v0)) {
            return
        };
        let v1 = *0x2::dynamic_field::borrow<EnvelopeKey, vector<0x1::string::String>>(&arg0.id, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&v1, v2);
            let v4 = PayerKey{
                envelope_id : arg1,
                effector    : v3,
            };
            0x2::dynamic_field::borrow_mut<PayerKey, Payer>(&mut arg0.id, v4).retired = true;
            let v5 = EffectorKey{effector: v3};
            if (0x2::dynamic_field::exists_<EffectorKey>(&arg0.id, v5)) {
                let v6 = 0x2::dynamic_field::borrow_mut<EffectorKey, vector<address>>(&mut arg0.id, v5);
                let v7 = 0;
                while (v7 < 0x1::vector::length<address>(v6)) {
                    if (*0x1::vector::borrow<address>(v6, v7) == arg1) {
                        0x1::vector::remove<address>(v6, v7);
                        continue
                    };
                    v7 = v7 + 1;
                };
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun set_agreement(arg0: &mut Store, arg1: address) {
        arg0.agreement = 0x1::option::some<address>(arg1);
    }

    public(friend) fun set_charter(arg0: &mut Store, arg1: address) {
        arg0.charter = 0x1::option::some<address>(arg1);
    }

    public(friend) fun set_helm_key(arg0: &mut Store, arg1: vector<u8>) {
        arg0.helm_key = 0x1::option::some<vector<u8>>(arg1);
    }

    public(friend) fun succeed(arg0: &mut Store, arg1: address, arg2: address) {
        if (0x2::table::contains<address, address>(&arg0.succession, arg1)) {
            *0x2::table::borrow_mut<address, address>(&mut arg0.succession, arg1) = arg2;
        } else {
            0x2::table::add<address, address>(&mut arg0.succession, arg1, arg2);
        };
    }

    public(friend) fun take_place(arg0: &mut Store, arg1: address) {
        let v0 = PlaceKey{holder: arg1};
        if (!0x2::dynamic_field::exists_<PlaceKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<PlaceKey, bool>(&mut arg0.id, v0, true);
        };
    }

    public(friend) fun take_retired_unseen(arg0: &mut Store, arg1: address) : bool {
        if (0x2::table::contains<address, bool>(&arg0.retired_unseen, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.retired_unseen, arg1);
            true
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

