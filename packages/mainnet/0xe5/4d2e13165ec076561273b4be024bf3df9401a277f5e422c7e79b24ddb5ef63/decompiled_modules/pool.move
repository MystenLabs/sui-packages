module 0xe54d2e13165ec076561273b4be024bf3df9401a277f5e422c7e79b24ddb5ef63::pool {
    struct Tree has store {
        filled: vector<u256>,
        zeros: vector<u256>,
        tree: u64,
        next_index: u64,
        current_root: u256,
        root_at: 0x2::table::Table<u64, u256>,
        roots: 0x2::table::Table<u256, u64>,
        calls: u64,
        oldest: u64,
        time_at: 0x2::table::Table<u64, u64>,
        closed: 0x2::table::Table<u256, u64>,
        last_root: 0x2::table::Table<u64, u256>,
    }

    struct Account has store {
        h: u256,
        sx: u256,
        sy: u256,
        box: vector<u8>,
        ident: vector<u8>,
        index: u64,
        epoch: u64,
        state: u8,
        active_at: u64,
    }

    struct Request has drop, store {
        by: address,
        opens_at: u64,
    }

    struct RootInfo has copy, drop, store {
        version: u64,
        replaced_at: u64,
    }

    struct Registry has store {
        nodes: 0x2::table::Table<u64, u256>,
        zeros: vector<u256>,
        count: u64,
        root: u256,
        version: u64,
        root_at: 0x2::table::Table<u64, u256>,
        roots: 0x2::table::Table<u256, RootInfo>,
        oldest: u64,
    }

    struct Asset has store {
        id: u256,
        cap: u64,
        min_deposit: u64,
        total: u64,
        open: bool,
        fees_collected: u128,
        relay_fees_paid: u128,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        reserves: 0x2::bag::Bag,
        assets: 0x2::table::Table<0x1::type_name::TypeName, Asset>,
        notes: Tree,
        nullifiers: 0x2::table::Table<u256, bool>,
        vk: 0x2::groth16::PreparedVerifyingKey,
        account_vk: 0x2::groth16::PreparedVerifyingKey,
        registry: Registry,
        accounts: 0x2::table::Table<u256, Account>,
        requests: 0x2::table::Table<u256, Request>,
        wait_ms: u64,
        servers: vector<address>,
        server_pks: vector<vector<u8>>,
        threshold: u8,
        vk_digest: vector<u8>,
        account_vk_digest: vector<u8>,
        deposits_open: bool,
        fee_in_bps: u64,
        treasury: address,
        spends: u64,
        seq: u64,
    }

    struct PoolAdmin has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct Note has copy, drop {
        pool: 0x2::object::ID,
        seq: u64,
        tree: u64,
        index: u64,
        commitment: u256,
        ephemeral: vector<u8>,
        view_tag: u8,
        cipher: vector<u8>,
        sender_note: vector<u8>,
    }

    struct Deposited has copy, drop {
        pool: 0x2::object::ID,
        seq: u64,
        asset: 0x1::ascii::String,
        asset_id: u256,
        value: u64,
        fee: u64,
        from: address,
        account: u256,
        r: u256,
        owner: u256,
        commitment: u256,
        tree: u64,
        index: u64,
    }

    struct Spent has copy, drop {
        pool: 0x2::object::ID,
        seq: u64,
        nullifier: u256,
    }

    struct Exited has copy, drop {
        pool: 0x2::object::ID,
        seq: u64,
        asset: 0x1::ascii::String,
        value: u64,
        to: address,
    }

    struct Relayed has copy, drop {
        pool: 0x2::object::ID,
        seq: u64,
        asset: 0x1::ascii::String,
        fee: u64,
        relayer: address,
    }

    struct AssetAdded has copy, drop {
        pool: 0x2::object::ID,
        after_seq: u64,
        asset: 0x1::ascii::String,
        asset_id: u256,
    }

    struct Registered has copy, drop {
        pool: 0x2::object::ID,
        account: u256,
        h: u256,
        sx: u256,
        sy: u256,
        index: u64,
        epoch: u64,
        active_at: u64,
        box: vector<u8>,
        ident: vector<u8>,
    }

    struct Activated has copy, drop {
        pool: 0x2::object::ID,
        account: u256,
        epoch: u64,
    }

    struct Requested has copy, drop {
        pool: 0x2::object::ID,
        account: u256,
        by: address,
        opens_at: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        vk_digest: vector<u8>,
        account_vk_digest: vector<u8>,
        servers: vector<address>,
        server_pks: vector<vector<u8>>,
        threshold: u8,
    }

    struct RequestWithdrawn has copy, drop {
        pool: 0x2::object::ID,
        account: u256,
    }

    struct Blocked has copy, drop {
        pool: 0x2::object::ID,
        account: u256,
        epoch: u64,
    }

    struct WaitSet has copy, drop {
        pool: 0x2::object::ID,
        wait_ms: u64,
    }

    struct PoolMaker has key {
        id: 0x2::object::UID,
    }

    fun to_bytes(arg0: u256) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun threshold(arg0: &Pool) : u8 {
        arg0.threshold
    }

    public fun account_box(arg0: &Pool, arg1: u256) : vector<u8> {
        0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).box
    }

    public fun account_epoch(arg0: &Pool, arg1: u256) : u64 {
        0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).epoch
    }

    public fun account_h(arg0: &Pool, arg1: u256) : u256 {
        0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).h
    }

    public fun account_ident(arg0: &Pool, arg1: u256) : vector<u8> {
        0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).ident
    }

    public fun account_scan_key(arg0: &Pool, arg1: u256) : (u256, u256) {
        let v0 = 0x2::table::borrow<u256, Account>(&arg0.accounts, arg1);
        (v0.sx, v0.sy)
    }

    public fun account_state(arg0: &Pool, arg1: u256) : u8 {
        0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).state
    }

    public fun account_vk_digest(arg0: &Pool) : vector<u8> {
        arg0.account_vk_digest
    }

    public fun activate(arg0: &mut Pool, arg1: u256, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u256, Account>(&arg0.accounts, arg1), 32);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::table::borrow_mut<u256, Account>(&mut arg0.accounts, arg1);
        assert!(v1.state == 2, 33);
        assert!(v0 >= v1.active_at, 42);
        v1.state = 0;
        let v2 = leaf_of(arg1, v1.h, v1.sx, v1.sy);
        let v3 = v1.epoch;
        let v4 = &mut arg0.registry;
        set_leaf(v4, v1.index, v2, v0);
        let v5 = Activated{
            pool    : 0x2::object::id<Pool>(arg0),
            account : arg1,
            epoch   : v3,
        };
        0x2::event::emit<Activated>(v5);
    }

    public fun add_asset<T0>(arg0: &mut Pool, arg1: &PoolAdmin, arg2: u64, arg3: u64) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg0.assets, v0), 20);
        let v1 = Asset{
            id              : asset_id<T0>(),
            cap             : arg2,
            min_deposit     : arg3,
            total           : 0,
            open            : true,
            fees_collected  : 0,
            relay_fees_paid : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, Asset>(&mut arg0.assets, v0, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserves, v0, 0x2::balance::zero<T0>());
        let v2 = AssetAdded{
            pool      : 0x2::object::id<Pool>(arg0),
            after_seq : arg0.seq,
            asset     : 0x1::type_name::into_string(v0),
            asset_id  : asset_id<T0>(),
        };
        0x2::event::emit<AssetAdded>(v2);
    }

    public fun asset_id<T0>() : u256 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x2::hash::blake2b256(0x1::ascii::as_bytes(&v0));
        to_u256(&v1) % 21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    fun asset_mut<T0>(arg0: &mut Pool) : &mut Asset {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg0.assets, v0), 19);
        0x2::table::borrow_mut<0x1::type_name::TypeName, Asset>(&mut arg0.assets, v0)
    }

    public fun aux_raw(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: &vector<vector<u8>>, arg5: &vector<vector<u8>>, arg6: &vector<vector<u8>>, arg7: &vector<u8>, arg8: &vector<vector<u8>>) : u256 {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, le8(arg3));
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg4)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg4, v1));
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg6, v1));
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg7, v1));
            0x1::vector::append<u8>(&mut v0, le8(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg5, v1))));
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg5, v1));
            0x1::vector::append<u8>(&mut v0, le8(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg8, v1))));
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg8, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::hash::blake2b256(&v0);
        to_u256(&v2) % 21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    public fun box_id(arg0: 0x2::object::ID, arg1: u256, arg2: u64) : vector<u8> {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        0x1::vector::append<u8>(&mut v0, to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, le8(arg2));
        v0
    }

    fun box_is_bad(arg0: &vector<u8>, arg1: u256, arg2: address, arg3: vector<u8>, arg4: &vector<vector<u8>>, arg5: &vector<address>, arg6: &vector<address>, arg7: &vector<vector<u8>>) : bool {
        assert!(0x1::vector::length<address>(arg5) == 0x1::vector::length<vector<u8>>(arg4), 11);
        let v0 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::parse_encrypted_object(*arg0);
        let v1 = 0x1::vector::empty<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(arg5)) {
            let v3 = 0x1::vector::borrow<address>(arg5, v2);
            let v4 = &mut v1;
            let (v5, v6) = 0x1::vector::index_of<address>(arg6, v3);
            assert!(v5, 41);
            0x1::vector::push_back<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>(v4, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::new_public_key(0x2::object::id_from_address(*v3), *0x1::vector::borrow<vector<u8>>(arg7, v6)));
            v2 = v2 + 1;
        };
        let v7 = 0x1::vector::empty<0x2::group_ops::Element<0x2::bls12381::G1>>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<vector<u8>>(arg4)) {
            0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::G1>>(&mut v7, 0x2::bls12381::g1_from_bytes(0x1::vector::borrow<vector<u8>>(arg4, v8)));
            v8 = v8 + 1;
        };
        let v9 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::verify_derived_keys(&v7, arg2, arg3, &v1);
        let v10 = 0x1::vector::empty<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>();
        let v11 = 0x1::vector::length<address>(arg6);
        assert!(v11 == 0x1::vector::length<vector<u8>>(arg7), 13906836532280426495);
        let v12 = 0;
        while (v12 < v11) {
            0x1::vector::push_back<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>(&mut v10, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::new_public_key(0x2::object::id_from_address(*0x1::vector::borrow<address>(arg6, v12)), *0x1::vector::borrow<vector<u8>>(arg7, v12)));
            v12 = v12 + 1;
        };
        let v13 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::decrypt(&v0, &v9, &v10);
        if (0x1::option::is_none<vector<u8>>(&v13)) {
            return true
        };
        let v14 = 0x1::option::destroy_some<vector<u8>>(v13);
        if (0x1::vector::length<u8>(&v14) != 32) {
            return true
        };
        let v15 = to_u256(&v14);
        if (v15 >= 21888242871839275222246405745257275088548364400416034343698204186575808495617) {
            true
        } else {
            let v17 = 0x1::vector::empty<u256>();
            0x1::vector::push_back<u256>(&mut v17, v15);
            0x2::poseidon::poseidon_bn254(&v17) != arg1
        }
    }

    public fun calls(arg0: &Pool) : u64 {
        arg0.notes.calls
    }

    fun canonical(arg0: u256) : u256 {
        assert!(arg0 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 13);
        arg0
    }

    fun check_box(arg0: &Pool, arg1: &vector<u8>, arg2: 0x2::object::ID, arg3: u256, arg4: u64) : vector<u8> {
        let v0 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::parse_encrypted_object(*arg1);
        let v1 = *0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::id(&v0);
        let v2 = box_id(arg2, arg3, arg4);
        assert!(*0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::package_id(&v0) == package_address() && 0x1::vector::length<u8>(&v1) == 104, 30);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            assert!(*0x1::vector::borrow<u8>(&v1, v3) == *0x1::vector::borrow<u8>(&v2, v3), 30);
            v3 = v3 + 1;
        };
        assert!(*0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::services(&v0) == arg0.servers && 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::threshold(&v0) == arg0.threshold, 30);
        assert!(0x1::vector::length<u8>(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::blob(&v0)) == 32, 30);
        assert!(*0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::nonce(&v0) != 0x2::bls12381::g2_identity(), 30);
        v1
    }

    public fun closed_root(arg0: &Pool, arg1: u64) : u256 {
        *0x2::table::borrow<u64, u256>(&arg0.notes.last_root, arg1)
    }

    entry fun create_pool(arg0: PoolMaker, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = make_pool(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::transfer<PoolAdmin>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun deposit<T0>(arg0: &mut Pool, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposits_open, 15);
        assert!(0x2::table::contains<u256, Account>(&arg0.accounts, arg2), 32);
        assert!(0x2::table::borrow<u256, Account>(&arg0.accounts, arg2).state == 0, 33);
        let v0 = fee_in(arg0, 0x2::coin::value<T0>(&arg1));
        assert!(0x2::coin::value<T0>(&arg1) > v0, 7);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg5), arg0.treasury);
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg3, 27);
        arg0.seq = arg0.seq + 1;
        let v2 = arg0.seq;
        let v3 = 0x2::object::id<Pool>(arg0);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        let v5 = asset_mut<T0>(arg0);
        assert!(v5.open, 15);
        assert!(v1 >= v5.min_deposit, 10);
        if (v5.cap > 0) {
            assert!((v5.total as u128) + (v1 as u128) <= (v5.cap as u128), 2);
        };
        v5.total = v5.total + v1;
        v5.fees_collected = v5.fees_collected + (v0 as u128);
        let v6 = v5.id;
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserves, v4), 0x2::coin::into_balance<T0>(arg1));
        let v7 = (v2 as u256);
        let v8 = hash2(arg2, v7);
        let v9 = 0x1::vector::empty<u256>();
        let v10 = &mut v9;
        0x1::vector::push_back<u256>(v10, v6);
        0x1::vector::push_back<u256>(v10, (v1 as u256));
        0x1::vector::push_back<u256>(v10, v8);
        let v11 = 0x2::poseidon::poseidon_bn254(&v9);
        let v12 = &mut arg0.notes;
        make_room(v12, 1);
        let v13 = &mut arg0.notes;
        let v14 = insert(v13, v11);
        let v15 = &mut arg0.notes;
        push_root(v15, 0x2::clock::timestamp_ms(arg4));
        let v16 = Deposited{
            pool       : v3,
            seq        : v2,
            asset      : 0x1::type_name::into_string(v4),
            asset_id   : v6,
            value      : v1,
            fee        : v0,
            from       : 0x2::tx_context::sender(arg5),
            account    : arg2,
            r          : v7,
            owner      : v8,
            commitment : v11,
            tree       : arg0.notes.tree,
            index      : v14,
        };
        0x2::event::emit<Deposited>(v16);
        let v17 = Note{
            pool        : v3,
            seq         : v2,
            tree        : arg0.notes.tree,
            index       : v14,
            commitment  : v11,
            ephemeral   : b"",
            view_tag    : 0,
            cipher      : b"",
            sender_note : b"",
        };
        0x2::event::emit<Note>(v17);
    }

    public fun deposits_open(arg0: &Pool) : bool {
        arg0.deposits_open
    }

    fun fee_at(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((((arg1 as u128) * (arg0 as u128) + 9999) / 10000) as u64)
    }

    public fun fee_in(arg0: &Pool, arg1: u64) : u64 {
        fee_at(arg0.fee_in_bps, arg1)
    }

    public fun fee_in_bps(arg0: &Pool) : u64 {
        arg0.fee_in_bps
    }

    public fun fees_collected<T0>(arg0: &Pool) : u128 {
        0x2::table::borrow<0x1::type_name::TypeName, Asset>(&arg0.assets, 0x1::type_name::with_defining_ids<T0>()).fees_collected
    }

    public fun give_up(arg0: PoolAdmin) {
        let PoolAdmin {
            id   : v0,
            pool : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun hand_over(arg0: PoolAdmin, arg1: address) {
        0x2::transfer::transfer<PoolAdmin>(arg0, arg1);
    }

    public fun has_asset<T0>(arg0: &Pool) : bool {
        0x2::table::contains<0x1::type_name::TypeName, Asset>(&arg0.assets, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun has_request(arg0: &Pool, arg1: u256) : bool {
        0x2::table::contains<u256, Request>(&arg0.requests, arg1)
    }

    fun hash2(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolMaker{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolMaker>(v0, 0x2::tx_context::sender(arg0));
    }

    fun insert(arg0: &mut Tree, arg1: u256) : u64 {
        let v0 = arg0.next_index;
        let v1 = arg1;
        let v2 = 0;
        while (v2 < 20) {
            if (v0 % 2 == 0) {
                *0x1::vector::borrow_mut<u256>(&mut arg0.filled, v2) = v1;
                v1 = hash2(v1, *0x1::vector::borrow<u256>(&arg0.zeros, v2));
            } else {
                v1 = hash2(*0x1::vector::borrow<u256>(&arg0.filled, v2), v1);
            };
            v0 = v0 / 2;
            v2 = v2 + 1;
        };
        arg0.next_index = v0 + 1;
        arg0.current_root = v1;
        v0
    }

    public fun is_account(arg0: &Pool, arg1: u256) : bool {
        0x2::table::contains<u256, Account>(&arg0.accounts, arg1)
    }

    public fun is_known_registry_root(arg0: &Pool, arg1: u256, arg2: u64) : bool {
        knows(&arg0.registry, arg1, arg2)
    }

    public fun is_known_root(arg0: &Pool, arg1: u256, arg2: u64) : bool {
        knows_in(&arg0.notes, arg1, arg2)
    }

    public fun is_spent(arg0: &Pool, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.nullifiers, arg1)
    }

    fun knows(arg0: &Registry, arg1: u256, arg2: u64) : bool {
        if (arg1 == *0x1::vector::borrow<u256>(&arg0.zeros, 32)) {
            return false
        };
        if (arg1 == arg0.root) {
            return true
        };
        if (!0x2::table::contains<u256, RootInfo>(&arg0.roots, arg1)) {
            return false
        };
        0x2::table::borrow<u256, RootInfo>(&arg0.roots, arg1).replaced_at + 3600000 > arg2
    }

    fun knows_in(arg0: &Tree, arg1: u256, arg2: u64) : bool {
        if (arg1 == *0x1::vector::borrow<u256>(&arg0.zeros, 20)) {
            return false
        };
        if (0x2::table::contains<u256, u64>(&arg0.closed, arg1) && *0x2::table::borrow<u256, u64>(&arg0.closed, arg1) == arg2) {
            return true
        };
        0x2::table::contains<u256, u64>(&arg0.roots, arg1) && *0x2::table::borrow<u256, u64>(&arg0.roots, arg1) / 4294967296 == arg2
    }

    fun le8(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun leaf_of(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x1::vector::push_back<u256>(v1, arg2);
        0x1::vector::push_back<u256>(v1, arg3);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    public fun make_pool(arg0: PoolMaker, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<address>, arg4: vector<vector<u8>>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : PoolAdmin {
        let PoolMaker { id: v0 } = arg0;
        0x2::object::delete(v0);
        new_pool(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun make_room(arg0: &mut Tree, arg1: u64) {
        if (arg0.next_index + arg1 <= 1 << (20 as u8)) {
            return
        };
        let v0 = arg0.current_root;
        if (!0x2::table::contains<u256, u64>(&arg0.closed, v0)) {
            0x2::table::add<u256, u64>(&mut arg0.closed, v0, arg0.tree);
        };
        0x2::table::add<u64, u256>(&mut arg0.last_root, arg0.tree, v0);
        arg0.current_root = *0x1::vector::borrow<u256>(&arg0.zeros, 20);
        let v1 = 0;
        while (v1 < 20) {
            *0x1::vector::borrow_mut<u256>(&mut arg0.filled, v1) = *0x1::vector::borrow<u256>(&arg0.zeros, v1);
            v1 = v1 + 1;
        };
        arg0.tree = arg0.tree + 1;
        arg0.next_index = 0;
    }

    public(friend) fun new_pool(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<address>, arg3: vector<vector<u8>>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : PoolAdmin {
        assert!(0x1::vector::length<u8>(&arg0) == 296 && 0x1::vector::length<u8>(&arg1) == 424, 18);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = if (v0 > 0) {
            if (v0 <= 16) {
                if (0x1::vector::length<vector<u8>>(&arg3) == v0) {
                    if (arg4 > 0) {
                        (arg4 as u64) <= v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 41);
        let v2 = 0;
        while (v2 < v0) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg3, v2)) == 96, 41);
            0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::new_public_key(0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg2, v2)), *0x1::vector::borrow<vector<u8>>(&arg3, v2));
            let v3 = v2 + 1;
            while (v3 < v0) {
                assert!(*0x1::vector::borrow<address>(&arg2, v3) != *0x1::vector::borrow<address>(&arg2, v2), 41);
                assert!(*0x1::vector::borrow<vector<u8>>(&arg3, v3) != *0x1::vector::borrow<vector<u8>>(&arg3, v2), 44);
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        let v4 = 0x2::object::new(arg5);
        let v5 = 0x2::bag::new(arg5);
        let v6 = 0x2::table::new<0x1::type_name::TypeName, Asset>(arg5);
        let v7 = new_tree(arg5);
        let v8 = 0x2::table::new<u256, bool>(arg5);
        let v9 = 0x2::groth16::bn254();
        let v10 = 0x2::groth16::bn254();
        let v11 = new_registry(arg5);
        let v12 = Pool{
            id                : v4,
            reserves          : v5,
            assets            : v6,
            notes             : v7,
            nullifiers        : v8,
            vk                : 0x2::groth16::prepare_verifying_key(&v9, &arg0),
            account_vk        : 0x2::groth16::prepare_verifying_key(&v10, &arg1),
            registry          : v11,
            accounts          : 0x2::table::new<u256, Account>(arg5),
            requests          : 0x2::table::new<u256, Request>(arg5),
            wait_ms           : 604800000,
            servers           : arg2,
            server_pks        : arg3,
            threshold         : arg4,
            vk_digest         : 0x2::hash::blake2b256(&arg0),
            account_vk_digest : 0x2::hash::blake2b256(&arg1),
            deposits_open     : true,
            fee_in_bps        : 40,
            treasury          : 0x2::tx_context::sender(arg5),
            spends            : 0,
            seq               : 0,
        };
        let v13 = PoolAdmin{
            id   : 0x2::object::new(arg5),
            pool : 0x2::object::id<Pool>(&v12),
        };
        let v14 = PoolCreated{
            pool              : 0x2::object::id<Pool>(&v12),
            vk_digest         : v12.vk_digest,
            account_vk_digest : v12.account_vk_digest,
            servers           : v12.servers,
            server_pks        : v12.server_pks,
            threshold         : arg4,
        };
        0x2::event::emit<PoolCreated>(v14);
        0x2::transfer::share_object<Pool>(v12);
        v13
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        let v0 = vector[0];
        let v1 = 1;
        while (v1 <= 32) {
            let v2 = *0x1::vector::borrow<u256>(&v0, v1 - 1);
            0x1::vector::push_back<u256>(&mut v0, hash2(v2, v2));
            v1 = v1 + 1;
        };
        Registry{
            nodes   : 0x2::table::new<u64, u256>(arg0),
            zeros   : v0,
            count   : 0,
            root    : *0x1::vector::borrow<u256>(&v0, 32),
            version : 0,
            root_at : 0x2::table::new<u64, u256>(arg0),
            roots   : 0x2::table::new<u256, RootInfo>(arg0),
            oldest  : 1,
        }
    }

    fun new_tree(arg0: &mut 0x2::tx_context::TxContext) : Tree {
        let v0 = vector[0];
        let v1 = 1;
        while (v1 <= 20) {
            let v2 = *0x1::vector::borrow<u256>(&v0, v1 - 1);
            0x1::vector::push_back<u256>(&mut v0, hash2(v2, v2));
            v1 = v1 + 1;
        };
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 20) {
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&v0, v4));
            v4 = v4 + 1;
        };
        Tree{
            filled       : v3,
            zeros        : v0,
            tree         : 0,
            next_index   : 0,
            current_root : *0x1::vector::borrow<u256>(&v0, 20),
            root_at      : 0x2::table::new<u64, u256>(arg0),
            roots        : 0x2::table::new<u256, u64>(arg0),
            calls        : 0,
            oldest       : 0,
            time_at      : 0x2::table::new<u64, u64>(arg0),
            closed       : 0x2::table::new<u256, u64>(arg0),
            last_root    : 0x2::table::new<u64, u256>(arg0),
        }
    }

    public fun next_index(arg0: &Pool) : u64 {
        arg0.notes.next_index
    }

    fun node(arg0: &Registry, arg1: u64, arg2: u64) : u256 {
        let v0 = arg1 << 32 | arg2;
        if (0x2::table::contains<u64, u256>(&arg0.nodes, v0)) {
            *0x2::table::borrow<u64, u256>(&arg0.nodes, v0)
        } else {
            *0x1::vector::borrow<u256>(&arg0.zeros, arg1)
        }
    }

    public fun package_address() : address {
        let v0 = 0x1::type_name::with_original_ids<Pool>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    public fun place_of(arg0: u64, arg1: u64) : u256 {
        ((arg0 as u256) << (20 as u8)) + (arg1 as u256)
    }

    public fun pool_field(arg0: 0x2::object::ID) : u256 {
        let v0 = 0x2::object::id_to_bytes(&arg0);
        to_u256(&v0) % 21888242871839275222246405745257275088548364400416034343698204186575808495617
    }

    public fun prove_bad_box(arg0: &mut Pool, arg1: u256, arg2: vector<vector<u8>>, arg3: vector<address>, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u256, Account>(&arg0.accounts, arg1), 32);
        let v0 = 0x2::table::borrow<u256, Account>(&arg0.accounts, arg1);
        let v1 = v0.state;
        let v2 = v0.index;
        assert!(v1 != 1, 33);
        assert!(box_is_bad(&0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).box, 0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).h, package_address(), 0x2::table::borrow<u256, Account>(&arg0.accounts, arg1).ident, &arg2, &arg3, &arg0.servers, &arg0.server_pks), 40);
        0x2::table::borrow_mut<u256, Account>(&mut arg0.accounts, arg1).state = 1;
        if (v1 == 0) {
            let v3 = &mut arg0.registry;
            set_leaf(v3, v2, 0, 0x2::clock::timestamp_ms(arg4));
        };
        let v4 = Blocked{
            pool    : 0x2::object::id<Pool>(arg0),
            account : arg1,
            epoch   : v0.epoch,
        };
        0x2::event::emit<Blocked>(v4);
    }

    fun push_root(arg0: &mut Tree, arg1: u64) {
        let v0 = arg0.current_root;
        let v1 = arg0.tree;
        record_root(arg0, v0, v1, arg1);
    }

    fun put(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u256) {
        let v0 = arg1 << 32 | arg2;
        if (0x2::table::contains<u64, u256>(&arg0.nodes, v0)) {
            0x2::table::remove<u64, u256>(&mut arg0.nodes, v0);
        };
        if (arg3 != *0x1::vector::borrow<u256>(&arg0.zeros, arg1)) {
            0x2::table::add<u64, u256>(&mut arg0.nodes, v0, arg3);
        };
    }

    fun record_root(arg0: &mut Tree, arg1: u256, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 2 && arg0.calls - arg0.oldest >= 4096) {
            let v1 = arg0.oldest;
            let v2 = (v1 / 64 + 1) * 64;
            if (!0x2::table::contains<u64, u64>(&arg0.time_at, v2) || *0x2::table::borrow<u64, u64>(&arg0.time_at, v2) + 600000 > arg3) {
                break
            };
            let v3 = 0x2::table::remove<u64, u256>(&mut arg0.root_at, v1);
            let v4 = 0x2::table::remove<u256, u64>(&mut arg0.roots, v3);
            if (v4 % 4294967296 > 1) {
                0x2::table::add<u256, u64>(&mut arg0.roots, v3, v4 - 1);
            };
            if (v1 + 1 == v2) {
                0x2::table::remove<u64, u64>(&mut arg0.time_at, v2);
            };
            arg0.oldest = v1 + 1;
            v0 = v0 + 1;
        };
        if (arg0.calls > 0 && arg0.calls % 64 == 0) {
            0x2::table::add<u64, u64>(&mut arg0.time_at, arg0.calls, arg3);
        };
        0x2::table::add<u64, u256>(&mut arg0.root_at, arg0.calls, arg1);
        if (0x2::table::contains<u256, u64>(&arg0.roots, arg1)) {
            0x2::table::add<u256, u64>(&mut arg0.roots, arg1, 0x2::table::remove<u256, u64>(&mut arg0.roots, arg1) + 1);
        } else {
            0x2::table::add<u256, u64>(&mut arg0.roots, arg1, arg2 * 4294967296 + 1);
        };
        arg0.calls = arg0.calls + 1;
    }

    public fun register(arg0: &mut Pool, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        let v0 = if (arg1 != 0) {
            if (arg1 < 21888242871839275222246405745257275088548364400416034343698204186575808495617) {
                if (arg2 < 21888242871839275222246405745257275088548364400416034343698204186575808495617) {
                    if (arg3 < 21888242871839275222246405745257275088548364400416034343698204186575808495617) {
                        arg4 < 21888242871839275222246405745257275088548364400416034343698204186575808495617
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 43);
        assert!(arg2 != 19014214495641488759237505126948346942972912379615652741039992445865937985820, 43);
        assert!(0x1::vector::length<u8>(&arg5) <= 2048, 30);
        let v1 = to_bytes(arg1);
        0x1::vector::append<u8>(&mut v1, to_bytes(arg2));
        0x1::vector::append<u8>(&mut v1, to_bytes(arg3));
        0x1::vector::append<u8>(&mut v1, to_bytes(arg4));
        let v2 = 0x2::hash::blake2b256(&arg5);
        0x1::vector::append<u8>(&mut v1, to_bytes(to_u256(&v2) % 21888242871839275222246405745257275088548364400416034343698204186575808495617));
        let v3 = 0x2::groth16::bn254();
        let v4 = 0x2::groth16::public_proof_inputs_from_bytes(v1);
        let v5 = 0x2::groth16::proof_points_from_bytes(arg6);
        assert!(0x2::groth16::verify_groth16_proof(&v3, &arg0.account_vk, &v4, &v5), 0);
        let v6 = 0x2::object::id<Pool>(arg0);
        let v7 = 0x2::clock::timestamp_ms(arg7);
        if (!0x2::table::contains<u256, Account>(&arg0.accounts, arg1)) {
            assert!(arg0.registry.count < 1 << (32 as u8), 34);
            let v8 = check_box(arg0, &arg5, v6, arg1, 0);
            let v9 = arg0.registry.count;
            arg0.registry.count = v9 + 1;
            let v10 = &mut arg0.registry;
            set_leaf(v10, v9, leaf_of(arg1, arg2, arg3, arg4), v7);
            let v11 = Account{
                h         : arg2,
                sx        : arg3,
                sy        : arg4,
                box       : arg5,
                ident     : v8,
                index     : v9,
                epoch     : 0,
                state     : 0,
                active_at : v7,
            };
            0x2::table::add<u256, Account>(&mut arg0.accounts, arg1, v11);
            let v12 = Registered{
                pool      : v6,
                account   : arg1,
                h         : arg2,
                sx        : arg3,
                sy        : arg4,
                index     : v9,
                epoch     : 0,
                active_at : v7,
                box       : arg5,
                ident     : v8,
            };
            0x2::event::emit<Registered>(v12);
        } else {
            let v13 = 0x2::table::borrow<u256, Account>(&arg0.accounts, arg1);
            let v14 = if (v13.h == arg2) {
                if (v13.sx == arg3) {
                    v13.sy == arg4
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v14, 43);
            let v15 = v13.epoch + 1;
            let v16 = v13.index;
            assert!(v13.state == 1, 31);
            let v17 = check_box(arg0, &arg5, v6, arg1, v15);
            let v18 = 0x2::table::borrow_mut<u256, Account>(&mut arg0.accounts, arg1);
            v18.box = arg5;
            v18.ident = v17;
            v18.epoch = v15;
            v18.state = 2;
            v18.active_at = v7 + 86400000;
            let v19 = Registered{
                pool      : v6,
                account   : arg1,
                h         : arg2,
                sx        : arg3,
                sy        : arg4,
                index     : v16,
                epoch     : v15,
                active_at : v7 + 86400000,
                box       : arg5,
                ident     : v17,
            };
            0x2::event::emit<Registered>(v19);
        };
    }

    public fun registry_count(arg0: &Pool) : u64 {
        arg0.registry.count
    }

    public fun registry_root(arg0: &Pool) : u256 {
        arg0.registry.root
    }

    public fun registry_root_valid_until(arg0: &Pool, arg1: u256) : u64 {
        let v0 = &arg0.registry;
        if (arg1 == *0x1::vector::borrow<u256>(&v0.zeros, 32)) {
            return 0
        };
        if (arg1 == v0.root) {
            return 18446744073709551615
        };
        if (!0x2::table::contains<u256, RootInfo>(&v0.roots, arg1)) {
            return 0
        };
        0x2::table::borrow<u256, RootInfo>(&v0.roots, arg1).replaced_at + 3600000
    }

    public fun relay_fees_paid<T0>(arg0: &Pool) : u128 {
        0x2::table::borrow<0x1::type_name::TypeName, Asset>(&arg0.assets, 0x1::type_name::with_defining_ids<T0>()).relay_fees_paid
    }

    public fun request(arg0: &mut Pool, arg1: &PoolAdmin, arg2: u256, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        assert!(0x2::table::contains<u256, Account>(&arg0.accounts, arg2), 32);
        assert!(!0x2::table::contains<u256, Request>(&arg0.requests, arg2), 36);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg0.wait_ms;
        let v1 = Request{
            by       : 0x2::tx_context::sender(arg4),
            opens_at : v0,
        };
        0x2::table::add<u256, Request>(&mut arg0.requests, arg2, v1);
        let v2 = Requested{
            pool     : 0x2::object::id<Pool>(arg0),
            account  : arg2,
            by       : 0x2::tx_context::sender(arg4),
            opens_at : v0,
        };
        0x2::event::emit<Requested>(v2);
    }

    public fun request_by(arg0: &Pool, arg1: u256) : address {
        0x2::table::borrow<u256, Request>(&arg0.requests, arg1).by
    }

    public fun request_opens_at(arg0: &Pool, arg1: u256) : u64 {
        0x2::table::borrow<u256, Request>(&arg0.requests, arg1).opens_at
    }

    public fun reserve<T0>(arg0: &Pool) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reserves, 0x1::type_name::with_defining_ids<T0>()))
    }

    public fun root(arg0: &Pool) : u256 {
        arg0.notes.current_root
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Pool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 104, 39);
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, 32 + v1));
            v1 = v1 + 1;
        };
        let v2 = to_u256(&v0);
        assert!(0x2::table::contains<u256, Account>(&arg1.accounts, v2) && 0x2::table::borrow<u256, Account>(&arg1.accounts, v2).ident == arg0, 39);
        assert!(0x2::table::contains<u256, Request>(&arg1.requests, v2), 39);
        let v3 = 0x2::table::borrow<u256, Request>(&arg1.requests, v2);
        assert!(v3.by == 0x2::tx_context::sender(arg3) && 0x2::clock::timestamp_ms(arg2) >= v3.opens_at, 39);
    }

    public fun seq(arg0: &Pool) : u64 {
        arg0.seq
    }

    public fun server_pks(arg0: &Pool) : vector<vector<u8>> {
        arg0.server_pks
    }

    public fun servers(arg0: &Pool) : vector<address> {
        arg0.servers
    }

    public fun set_asset<T0>(arg0: &mut Pool, arg1: &PoolAdmin, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        let v0 = asset_mut<T0>(arg0);
        v0.cap = arg2;
        v0.min_deposit = arg3;
        v0.open = arg4;
    }

    public fun set_deposits_open(arg0: &mut Pool, arg1: &PoolAdmin, arg2: bool) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        arg0.deposits_open = arg2;
    }

    public fun set_fee(arg0: &mut Pool, arg1: &PoolAdmin, arg2: u64, arg3: address) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        assert!(arg2 <= 500, 6);
        arg0.fee_in_bps = arg2;
        arg0.treasury = arg3;
    }

    fun set_leaf(arg0: &mut Registry, arg1: u64, arg2: u256, arg3: u64) {
        let v0 = arg2;
        let v1 = 0;
        while (v1 < 32) {
            put(arg0, v1, arg1, v0);
            let v2 = if (arg1 % 2 == 0) {
                hash2(v0, node(arg0, v1, arg1 ^ 1))
            } else {
                hash2(node(arg0, v1, arg1 ^ 1), v0)
            };
            v0 = v2;
            arg1 = arg1 / 2;
            v1 = v1 + 1;
        };
        let v3 = arg0.root;
        if (0x2::table::contains<u256, RootInfo>(&arg0.roots, v3)) {
            0x2::table::borrow_mut<u256, RootInfo>(&mut arg0.roots, v3).replaced_at = arg3;
        };
        let v4 = 0;
        while (v4 < 2 && arg0.oldest < arg0.version) {
            let v5 = arg0.oldest;
            let v6 = *0x2::table::borrow<u64, u256>(&arg0.root_at, v5);
            if (0x2::table::contains<u256, RootInfo>(&arg0.roots, v6) && 0x2::table::borrow<u256, RootInfo>(&arg0.roots, v6).version == v5) {
                if (0x2::table::borrow<u256, RootInfo>(&arg0.roots, v6).replaced_at + 3600000 > arg3) {
                    break
                };
                0x2::table::remove<u256, RootInfo>(&mut arg0.roots, v6);
            };
            0x2::table::remove<u64, u256>(&mut arg0.root_at, v5);
            arg0.oldest = v5 + 1;
            v4 = v4 + 1;
        };
        arg0.version = arg0.version + 1;
        arg0.root = v0;
        if (0x2::table::contains<u256, RootInfo>(&arg0.roots, v0)) {
            0x2::table::remove<u256, RootInfo>(&mut arg0.roots, v0);
        };
        let v7 = RootInfo{
            version     : arg0.version,
            replaced_at : 0,
        };
        0x2::table::add<u256, RootInfo>(&mut arg0.roots, v0, v7);
        0x2::table::add<u64, u256>(&mut arg0.root_at, arg0.version, v0);
    }

    public fun set_wait(arg0: &mut Pool, arg1: &PoolAdmin, arg2: u64) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        assert!(arg2 >= 259200000 && arg2 <= 2592000000, 38);
        arg0.wait_ms = arg2;
        let v0 = WaitSet{
            pool    : 0x2::object::id<Pool>(arg0),
            wait_ms : arg2,
        };
        0x2::event::emit<WaitSet>(v0);
    }

    public fun spend<T0, T1>(arg0: &mut Pool, arg1: vector<u256>, arg2: vector<u64>, arg3: u256, arg4: vector<u256>, arg5: u64, arg6: address, arg7: u64, arg8: address, arg9: u64, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<u8>, arg14: vector<vector<u8>>, arg15: vector<u8>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::length<u256>(&arg1) == 2) {
            if (0x1::vector::length<u64>(&arg2) == 2) {
                0x1::vector::length<u256>(&arg4) == 8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        let v1 = if (0x1::vector::length<vector<u8>>(&arg10) == 4) {
            if (0x1::vector::length<vector<u8>>(&arg11) == 4) {
                if (0x1::vector::length<vector<u8>>(&arg12) == 4) {
                    if (0x1::vector::length<u8>(&arg13) == 4) {
                        0x1::vector::length<vector<u8>>(&arg14) == 4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 11);
        assert!(arg5 == 0 || arg6 != @0x0, 14);
        assert!(arg7 == 0 || arg8 != @0x0, 16);
        assert!(0x2::clock::timestamp_ms(arg16) <= arg9, 28);
        assert!(knows_in(&arg0.notes, canonical(*0x1::vector::borrow<u256>(&arg1, 0)), *0x1::vector::borrow<u64>(&arg2, 0)) && knows_in(&arg0.notes, canonical(*0x1::vector::borrow<u256>(&arg1, 1)), *0x1::vector::borrow<u64>(&arg2, 1)), 8);
        assert!(knows(&arg0.registry, canonical(arg3), 0x2::clock::timestamp_ms(arg16)), 35);
        let v2 = 0;
        while (v2 < 8) {
            let v3 = canonical(*0x1::vector::borrow<u256>(&arg4, v2));
            assert!(!0x2::table::contains<u256, bool>(&arg0.nullifiers, v3), 9);
            let v4 = v2 + 1;
            while (v4 < 8) {
                assert!(*0x1::vector::borrow<u256>(&arg4, v4) != v3, 17);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 4) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg10, v6)) == 32, 1);
            0x1::vector::push_back<u256>(&mut v5, canonical(to_u256(0x1::vector::borrow<vector<u8>>(&arg10, v6))));
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg11, v6)) == 80, 5);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg12, v6)) == 32, 3);
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg14, v6)) == 112, 26);
            v6 = v6 + 1;
        };
        let v7 = 0x2::object::id<Pool>(arg0);
        arg0.seq = arg0.seq + 1;
        let v8 = arg0.seq;
        let v9 = 0x1::vector::empty<u256>();
        let v10 = &mut v9;
        0x1::vector::push_back<u256>(v10, *0x1::vector::borrow<u256>(&arg1, 0));
        0x1::vector::push_back<u256>(v10, (*0x1::vector::borrow<u64>(&arg2, 0) as u256));
        0x1::vector::push_back<u256>(v10, *0x1::vector::borrow<u256>(&arg1, 1));
        0x1::vector::push_back<u256>(v10, (*0x1::vector::borrow<u64>(&arg2, 1) as u256));
        0x1::vector::push_back<u256>(v10, 0x2::poseidon::poseidon_bn254(&arg4));
        0x1::vector::push_back<u256>(v10, 0x2::poseidon::poseidon_bn254(&v5));
        0x1::vector::push_back<u256>(v10, asset_id<T0>());
        0x1::vector::push_back<u256>(v10, (arg5 as u256));
        0x1::vector::push_back<u256>(v10, asset_id<T1>());
        0x1::vector::push_back<u256>(v10, (arg7 as u256));
        0x1::vector::push_back<u256>(v10, aux_raw(v7, arg6, arg8, arg9, &arg10, &arg11, &arg12, &arg13, &arg14));
        0x1::vector::push_back<u256>(v10, pool_field(v7));
        0x1::vector::push_back<u256>(v10, arg3);
        let v11 = 0x2::groth16::bn254();
        let v12 = 0x2::groth16::public_proof_inputs_from_bytes(to_bytes(0x2::poseidon::poseidon_bn254(&v9)));
        let v13 = 0x2::groth16::proof_points_from_bytes(arg15);
        assert!(0x2::groth16::verify_groth16_proof(&v11, &arg0.vk, &v12, &v13), 0);
        let v14 = 0;
        while (v14 < 8) {
            0x2::table::add<u256, bool>(&mut arg0.nullifiers, *0x1::vector::borrow<u256>(&arg4, v14), true);
            let v15 = Spent{
                pool      : v7,
                seq       : v8,
                nullifier : *0x1::vector::borrow<u256>(&arg4, v14),
            };
            0x2::event::emit<Spent>(v15);
            v14 = v14 + 1;
        };
        let v16 = &mut arg0.notes;
        make_room(v16, 4);
        let v17 = 0;
        while (v17 < 4) {
            let v18 = &mut arg0.notes;
            let v19 = Note{
                pool        : v7,
                seq         : v8,
                tree        : arg0.notes.tree,
                index       : insert(v18, *0x1::vector::borrow<u256>(&v5, v17)),
                commitment  : *0x1::vector::borrow<u256>(&v5, v17),
                ephemeral   : *0x1::vector::borrow<vector<u8>>(&arg12, v17),
                view_tag    : *0x1::vector::borrow<u8>(&arg13, v17),
                cipher      : *0x1::vector::borrow<vector<u8>>(&arg11, v17),
                sender_note : *0x1::vector::borrow<vector<u8>>(&arg14, v17),
            };
            0x2::event::emit<Note>(v19);
            v17 = v17 + 1;
        };
        let v20 = &mut arg0.notes;
        push_root(v20, 0x2::clock::timestamp_ms(arg16));
        arg0.spends = arg0.spends + 1;
        if (arg7 > 0) {
            let v21 = take<T1>(arg0, arg7, arg17);
            let v22 = asset_mut<T1>(arg0);
            v22.relay_fees_paid = v22.relay_fees_paid + (arg7 as u128);
            let v23 = Relayed{
                pool    : v7,
                seq     : v8,
                asset   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
                fee     : arg7,
                relayer : arg8,
            };
            0x2::event::emit<Relayed>(v23);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v21, arg8);
        };
        if (arg5 > 0) {
            let v24 = Exited{
                pool  : v7,
                seq   : v8,
                asset : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                value : arg5,
                to    : arg6,
            };
            0x2::event::emit<Exited>(v24);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg5, arg17), arg6);
        };
    }

    public fun spends(arg0: &Pool) : u64 {
        arg0.spends
    }

    fun take<T0>(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = asset_mut<T0>(arg0);
        assert!(v0.total >= arg1, 12);
        v0.total = v0.total - arg1;
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserves, 0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::balance::value<T0>(v1) >= arg1, 12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    fun to_u256(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
        let v0 = 0;
        let v1 = 32;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, v2) as u256);
        };
        v0
    }

    public fun total<T0>(arg0: &Pool) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, Asset>(&arg0.assets, 0x1::type_name::with_defining_ids<T0>()).total
    }

    public fun tree(arg0: &Pool) : u64 {
        arg0.notes.tree
    }

    public fun vk_digest(arg0: &Pool) : vector<u8> {
        arg0.vk_digest
    }

    public fun wait_ms(arg0: &Pool) : u64 {
        arg0.wait_ms
    }

    public fun withdraw_request(arg0: &mut Pool, arg1: &PoolAdmin, arg2: u256) {
        assert!(arg1.pool == 0x2::object::id<Pool>(arg0), 4);
        assert!(0x2::table::contains<u256, Request>(&arg0.requests, arg2), 37);
        0x2::table::remove<u256, Request>(&mut arg0.requests, arg2);
        let v0 = RequestWithdrawn{
            pool    : 0x2::object::id<Pool>(arg0),
            account : arg2,
        };
        0x2::event::emit<RequestWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

