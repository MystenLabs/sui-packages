module 0x8ae95b923d575577ea18978e27efb11c652898244839920d28c0851631c34857::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ItemData has store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        size: u64,
        minted: u64,
        drawn: u64,
        seeded: u64,
        onchain_registry: bool,
        registry: 0x2::table::Table<u64, ItemData>,
        seeded_flags: 0x2::table::Table<u64, bool>,
        shuffle: 0x2::table::Table<u64, u64>,
    }

    struct Phase has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        gated: bool,
        max_per_wallet: u64,
        is_open: bool,
    }

    struct SplitShare has copy, drop, store {
        recipient: address,
        bps: u64,
    }

    struct MintKey has copy, drop, store {
        phase: u64,
        who: address,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        platform_fee_bps: u64,
        platform_treasury: address,
        is_open: bool,
        splits: vector<SplitShare>,
        fixed_fee: u64,
        fixed_fee_recipient: address,
        phases: vector<Phase>,
        allowlist: 0x2::table::Table<address, bool>,
        minted_per_wallet: 0x2::table::Table<MintKey, u64>,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        number: u64,
        index: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        metadata_version: u64,
    }

    struct ItemMinted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        recipient: address,
    }

    struct MintConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        treasury: address,
    }

    struct RevenueSplitSet has copy, drop {
        config_id: 0x2::object::ID,
        recipients: vector<address>,
        bps: vector<u64>,
        fixed_fee: u64,
        fixed_fee_recipient: address,
    }

    struct ItemRevealed has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        index: u64,
        owner: address,
    }

    struct ProvenanceSet has copy, drop {
        provenance: 0x2::object::ID,
        hash: vector<u8>,
    }

    struct ItemMetadataFixed has copy, drop {
        object_id: 0x2::object::ID,
        index: u64,
        owner: address,
        metadata_version: u64,
    }

    struct CorrectionsSealed has copy, drop {
        corrections_id: 0x2::object::ID,
    }

    struct RoyaltySplitter has key {
        id: 0x2::object::UID,
        cap: 0x2::transfer_policy::TransferPolicyCap<Item>,
        shares: vector<SplitShare>,
    }

    struct RoyaltyDistributed has copy, drop {
        splitter_id: 0x2::object::ID,
        total: u64,
        recipients: vector<address>,
    }

    struct ClaimGate has key {
        id: 0x2::object::UID,
        gate_type: 0x1::type_name::TypeName,
        cap: u64,
        used: u64,
        price: u64,
        treasury: address,
        is_open: bool,
        redeemed: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct ClaimGateCreated has copy, drop {
        gate_id: 0x2::object::ID,
        gate_type: 0x1::type_name::TypeName,
        cap: u64,
        price: u64,
    }

    struct Claimed has copy, drop {
        gate_id: 0x2::object::ID,
        token_id: 0x2::object::ID,
        who: address,
        used: u64,
    }

    struct Provenance has key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        scheme: 0x1::string::String,
    }

    struct Corrections has key {
        id: 0x2::object::UID,
        fixes: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        sealed: bool,
    }

    public fun add_to_allowlist(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.allowlist, v1)) {
                0x2::table::add<address, bool>(&mut arg1.allowlist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    entry fun admin_mint(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert_mint_ready(arg1);
        assert_supply(arg1, arg2);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        let v1 = &mut v0;
        draw_and_mint(arg1, arg2, arg3, v1, arg5);
    }

    entry fun admin_mint_many_recipients(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<address>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert_mint_ready(arg1);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0, 4);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 25, 6);
        assert!(arg1.minted + arg2 * v0 <= arg1.size, 8);
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = &mut v1;
            draw_and_mint(arg1, arg2, *0x1::vector::borrow<address>(&arg3, v2), v3, arg5);
            v2 = v2 + 1;
        };
    }

    fun assert_mint_ready(arg0: &Collection) {
        if (arg0.onchain_registry) {
            assert!(arg0.seeded == arg0.size, 11);
        };
    }

    fun assert_supply(arg0: &Collection, arg1: u64) {
        assert!(arg1 > 0, 4);
        assert!(arg1 <= 25, 6);
        assert!(arg0.minted + arg1 <= arg0.size, 8);
    }

    public fun attributes(arg0: &Item) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun available(arg0: &Collection) : u64 {
        arg0.size - arg0.minted
    }

    fun build_attributes(arg0: &vector<vector<u8>>, arg1: &vector<vector<u8>>, arg2: u64, arg3: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < arg3) {
            let v2 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(arg0, arg2 + v1));
            assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v2), 19);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, v2, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(arg1, arg2 + v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun build_shares(arg0: vector<address>, arg1: vector<u64>) : vector<SplitShare> {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 12);
        assert!(!0x1::vector::is_empty<address>(&arg0), 24);
        let v0 = 0x1::vector::empty<SplitShare>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0)) {
            let v3 = *0x1::vector::borrow<address>(&arg0, v2);
            assert!(v3 != @0x0, 24);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1, v2);
            let v4 = SplitShare{
                recipient : v3,
                bps       : *0x1::vector::borrow<u64>(&arg1, v2),
            };
            0x1::vector::push_back<SplitShare>(&mut v0, v4);
            v2 = v2 + 1;
        };
        assert!(v1 == 10000, 24);
        v0
    }

    fun charge_and_check(arg0: &mut MintConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.is_open, 0);
        assert!(arg3 > 0, 4);
        assert!(arg3 <= 25, 6);
        assert!(arg2 < 0x1::vector::length<Phase>(&arg0.phases), 5);
        let v0 = *0x1::vector::borrow<Phase>(&arg0.phases, arg2);
        assert!(v0.is_open, 16);
        assert!(v0.price <= arg4, 18);
        let v1 = 0x2::tx_context::sender(arg5);
        if (v0.gated) {
            assert!(0x2::table::contains<address, bool>(&arg0.allowlist, v1), 1);
        };
        let v2 = MintKey{
            phase : arg2,
            who   : v1,
        };
        let v3 = if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v2)) {
            *0x2::table::borrow<MintKey, u64>(&arg0.minted_per_wallet, v2)
        } else {
            0
        };
        if (v0.max_per_wallet > 0) {
            assert!(v3 + arg3 <= v0.max_per_wallet, 2);
        };
        let v4 = v0.price * arg3;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v4, 3);
        if (v4 > 0) {
            let v5 = v4 * arg0.platform_fee_bps / 10000;
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v5, arg5), arg0.platform_treasury);
            };
            let v6 = v4 - v5;
            let v7 = v6;
            if (0x1::vector::is_empty<SplitShare>(&arg0.splits)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg5), arg0.treasury);
            } else {
                let v8 = arg0.fixed_fee * arg3;
                assert!(v8 <= v6, 24);
                if (v8 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v8, arg5), arg0.fixed_fee_recipient);
                    v7 = v6 - v8;
                };
                let v9 = 0x1::vector::length<SplitShare>(&arg0.splits);
                let v10 = 0;
                let v11 = 0;
                while (v10 < v9) {
                    let v12 = *0x1::vector::borrow<SplitShare>(&arg0.splits, v10);
                    let v13 = if (v10 + 1 == v9) {
                        v7 - v11
                    } else {
                        v7 * v12.bps / 10000
                    };
                    if (v13 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v13, arg5), v12.recipient);
                    };
                    v11 = v11 + v13;
                    v10 = v10 + 1;
                };
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v2)) {
            *0x2::table::borrow_mut<MintKey, u64>(&mut arg0.minted_per_wallet, v2) = v3 + arg3;
        } else {
            0x2::table::add<MintKey, u64>(&mut arg0.minted_per_wallet, v2, v3 + arg3);
        };
        v1
    }

    public fun claim_cap(arg0: &ClaimGate) : u64 {
        arg0.cap
    }

    entry fun claim_mint<T0: key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        do_claim(arg0, arg1, 0x2::object::id<T0>(arg2), arg3, arg4, arg5);
    }

    entry fun claim_mint_from_kiosk<T0: store + key>(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg0.gate_type, 25);
        0x2::kiosk::borrow<T0>(arg2, arg3, arg4);
        do_claim(arg0, arg1, arg4, arg5, arg6, arg7);
    }

    public fun claim_used(arg0: &ClaimGate) : u64 {
        arg0.used
    }

    public fun corrections_sealed(arg0: &Corrections) : bool {
        arg0.sealed
    }

    public fun create_claim_gate<T0: key>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg3 != @0x0, 7);
        let v0 = ClaimGate{
            id        : 0x2::object::new(arg4),
            gate_type : 0x1::type_name::with_defining_ids<T0>(),
            cap       : arg1,
            used      : 0,
            price     : arg2,
            treasury  : arg3,
            is_open   : false,
            redeemed  : 0x2::table::new<0x2::object::ID, bool>(arg4),
        };
        let v1 = ClaimGateCreated{
            gate_id   : 0x2::object::id<ClaimGate>(&v0),
            gate_type : v0.gate_type,
            cap       : arg1,
            price     : arg2,
        };
        0x2::event::emit<ClaimGateCreated>(v1);
        0x2::transfer::share_object<ClaimGate>(v0);
    }

    public fun create_corrections(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Corrections{
            id     : 0x2::object::new(arg1),
            fixes  : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            sealed : false,
        };
        0x2::transfer::share_object<Corrections>(v0);
    }

    public fun create_mint_config(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 7);
        assert!(0 <= 10000, 22);
        assert!(0 == 0 || @0x0 != @0x0, 22);
        let v0 = MintConfig{
            id                  : 0x2::object::new(arg2),
            treasury            : arg1,
            platform_fee_bps    : 0,
            platform_treasury   : @0x0,
            is_open             : false,
            splits              : 0x1::vector::empty<SplitShare>(),
            fixed_fee           : 0,
            fixed_fee_recipient : @0x0,
            phases              : 0x1::vector::empty<Phase>(),
            allowlist           : 0x2::table::new<address, bool>(arg2),
            minted_per_wallet   : 0x2::table::new<MintKey, u64>(arg2),
        };
        let v1 = MintConfigCreated{
            config_id : 0x2::object::id<MintConfig>(&v0),
            treasury  : arg1,
        };
        0x2::event::emit<MintConfigCreated>(v1);
        0x2::transfer::share_object<MintConfig>(v0);
    }

    public fun create_provenance(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Provenance{
            id     : 0x2::object::new(arg3),
            hash   : arg1,
            scheme : 0x1::string::utf8(arg2),
        };
        let v1 = ProvenanceSet{
            provenance : 0x2::object::id<Provenance>(&v0),
            hash       : v0.hash,
        };
        0x2::event::emit<ProvenanceSet>(v1);
        0x2::transfer::share_object<Provenance>(v0);
    }

    public fun create_royalty_splitter(arg0: &AdminCap, arg1: 0x2::transfer_policy::TransferPolicyCap<Item>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltySplitter{
            id     : 0x2::object::new(arg4),
            cap    : arg1,
            shares : build_shares(arg2, arg3),
        };
        0x2::transfer::share_object<RoyaltySplitter>(v0);
    }

    public fun distribute(arg0: &mut RoyaltySplitter, arg1: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::withdraw<Item>(arg1, &arg0.cap, 0x1::option::none<u64>(), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 29);
        let v2 = 0x1::vector::length<SplitShare>(&arg0.shares);
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v4 < v2) {
            let v6 = *0x1::vector::borrow<SplitShare>(&arg0.shares, v4);
            let v7 = if (v4 + 1 == v2) {
                v1 - v5
            } else {
                v1 * v6.bps / 10000
            };
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v7, arg2), v6.recipient);
            };
            0x1::vector::push_back<address>(&mut v3, v6.recipient);
            v5 = v5 + v7;
            v4 = v4 + 1;
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        let v8 = RoyaltyDistributed{
            splitter_id : 0x2::object::id<RoyaltySplitter>(arg0),
            total       : v1,
            recipients  : v3,
        };
        0x2::event::emit<RoyaltyDistributed>(v8);
    }

    fun do_claim(arg0: &mut ClaimGate, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 28);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.redeemed, arg2), 26);
        assert!(arg0.used < arg0.cap, 27);
        assert_mint_ready(arg1);
        assert_supply(arg1, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        if (arg0.price > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.price, 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.price, arg5), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.redeemed, arg2, true);
        arg0.used = arg0.used + 1;
        let v1 = 0x2::random::new_generator(arg4, arg5);
        let v2 = &mut v1;
        draw_and_mint(arg1, 1, v0, v2, arg5);
        let v3 = Claimed{
            gate_id  : 0x2::object::id<ClaimGate>(arg0),
            token_id : arg2,
            who      : v0,
            used     : arg0.used,
        };
        0x2::event::emit<Claimed>(v3);
    }

    fun draw_and_mint(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::random::RandomGenerator, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = draw_index(arg0, arg3);
            mint_one(arg0, v1, arg2, arg4);
            v0 = v0 + 1;
        };
    }

    fun draw_index(arg0: &mut Collection, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = arg0.size - arg0.drawn;
        let v1 = 0x2::random::generate_u64_in_range(arg1, 0, v0 - 1);
        let v2 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, v1)
        } else {
            v1
        };
        let v3 = v0 - 1;
        let v4 = if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
            *0x2::table::borrow<u64, u64>(&arg0.shuffle, v3)
        } else {
            v3
        };
        if (v1 != v3) {
            if (0x2::table::contains<u64, u64>(&arg0.shuffle, v1)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.shuffle, v1) = v4;
            } else {
                0x2::table::add<u64, u64>(&mut arg0.shuffle, v1, v4);
            };
        };
        if (0x2::table::contains<u64, u64>(&arg0.shuffle, v3)) {
            0x2::table::remove<u64, u64>(&mut arg0.shuffle, v3);
        };
        arg0.drawn = arg0.drawn + 1;
        v2
    }

    public fun drawn(arg0: &Collection) : u64 {
        arg0.drawn
    }

    public fun fix_metadata(arg0: &Corrections, arg1: &mut Item, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.index != 0, 23);
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1.index), 17);
        arg1.attributes = *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1.index);
        arg1.metadata_version = arg1.metadata_version + 1;
        let v0 = ItemMetadataFixed{
            object_id        : 0x2::object::id<Item>(arg1),
            index            : arg1.index,
            owner            : 0x2::tx_context::sender(arg2),
            metadata_version : arg1.metadata_version,
        };
        0x2::event::emit<ItemMetadataFixed>(v0);
    }

    public fun fixed_fee(arg0: &MintConfig) : u64 {
        arg0.fixed_fee
    }

    public fun has_correction(arg0: &Corrections, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.fixes, arg1)
    }

    public fun index(arg0: &Item) : u64 {
        arg0.index
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x2::display::new<Item>(&v1, arg1);
        0x2::display::add<Item>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"CodexDreams #{index}"));
        0x2::display::add<Item>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Testing This is the description bla bla bla"));
        let v3 = 0x1::string::utf8(b"https://assets.alienz.tech/collections/6c1861d3ff7006681089ce8db4514025f37ab099620f0c0191beea72a0033c93/tokens/");
        0x1::string::append(&mut v3, 0x1::string::utf8(b"{index}."));
        0x1::string::append(&mut v3, 0x1::string::utf8(b"png"));
        0x2::display::add<Item>(&mut v2, 0x1::string::utf8(b"image_url"), v3);
        if (false) {
            let v4 = 0x1::string::utf8(b"https://assets.alienz.tech/collections/6c1861d3ff7006681089ce8db4514025f37ab099620f0c0191beea72a0033c93/tokens/");
            0x1::string::append(&mut v4, 0x1::string::utf8(b"{index}."));
            0x1::string::append(&mut v4, 0x1::string::utf8(b"mp4"));
            0x2::display::add<Item>(&mut v2, 0x1::string::utf8(b"animation_url"), v4);
        };
        0x2::display::add<Item>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://hive.alienz.tech"));
        0x2::display::add<Item>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Codex"));
        0x2::display::update_version<Item>(&mut v2);
        let (v5, v6) = 0x2::transfer_policy::new<Item>(&v1, arg1);
        let v7 = v6;
        let v8 = v5;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Item>(&mut v8, &v7, 500, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Item>(&mut v8, &v7);
        let v9 = Collection{
            id               : 0x2::object::new(arg1),
            name             : 0x1::string::utf8(b"CodexDream"),
            size             : 25,
            minted           : 0,
            drawn            : 0,
            seeded           : 0,
            onchain_registry : true,
            registry         : 0x2::table::new<u64, ItemData>(arg1),
            seeded_flags     : 0x2::table::new<u64, bool>(arg1),
            shuffle          : 0x2::table::new<u64, u64>(arg1),
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Item>>(v8);
        0x2::transfer::share_object<Collection>(v9);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Item>>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v2, v0);
        let v10 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v10, v0);
    }

    public fun is_allowlisted(arg0: &MintConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.allowlist, arg1)
    }

    public fun is_fully_seeded(arg0: &Collection) : bool {
        arg0.seeded == arg0.size
    }

    public fun is_index_seeded(arg0: &Collection, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.seeded_flags, arg1)
    }

    public fun is_onchain_registry(arg0: &Collection) : bool {
        arg0.onchain_registry
    }

    public fun is_open(arg0: &MintConfig) : bool {
        arg0.is_open
    }

    public fun is_redeemed(arg0: &ClaimGate, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.redeemed, arg1)
    }

    public fun is_revealed(arg0: &Item) : bool {
        arg0.index != 0
    }

    public fun metadata_version(arg0: &Item) : u64 {
        arg0.metadata_version
    }

    fun mint_boxes_internal(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            arg0.minted = arg0.minted + 1;
            let v1 = arg0.minted;
            let v2 = Item{
                id               : 0x2::object::new(arg3),
                number           : v1,
                index            : 0,
                attributes       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
                metadata_version : 0,
            };
            let v3 = ItemMinted{
                object_id : 0x2::object::id<Item>(&v2),
                number    : v1,
                index     : 0,
                recipient : arg2,
            };
            0x2::event::emit<ItemMinted>(v3);
            0x2::transfer::public_transfer<Item>(v2, arg2);
            v0 = v0 + 1;
        };
    }

    fun mint_one(arg0: &mut Collection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.onchain_registry) {
            assert!(0x2::table::contains<u64, ItemData>(&arg0.registry, arg1), 13);
            let ItemData { attributes: v0 } = 0x2::table::remove<u64, ItemData>(&mut arg0.registry, arg1);
            v0
        } else {
            0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()
        };
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        let v2 = arg1 + 1;
        let v3 = Item{
            id               : 0x2::object::new(arg3),
            number           : v1,
            index            : v2,
            attributes       : v0,
            metadata_version : 1,
        };
        let v4 = ItemMinted{
            object_id : 0x2::object::id<Item>(&v3),
            number    : v1,
            index     : v2,
            recipient : arg2,
        };
        0x2::event::emit<ItemMinted>(v4);
        0x2::transfer::public_transfer<Item>(v3, arg2);
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun minted_by_in_phase(arg0: &MintConfig, arg1: u64, arg2: address) : u64 {
        let v0 = MintKey{
            phase : arg1,
            who   : arg2,
        };
        if (0x2::table::contains<MintKey, u64>(&arg0.minted_per_wallet, v0)) {
            *0x2::table::borrow<MintKey, u64>(&arg0.minted_per_wallet, v0)
        } else {
            0
        }
    }

    public fun number(arg0: &Item) : u64 {
        arg0.number
    }

    public fun phase_at(arg0: &MintConfig, arg1: u64) : (0x1::string::String, u64, bool, u64, bool) {
        let v0 = 0x1::vector::borrow<Phase>(&arg0.phases, arg1);
        (v0.name, v0.price, v0.gated, v0.max_per_wallet, v0.is_open)
    }

    public fun phase_count(arg0: &MintConfig) : u64 {
        0x1::vector::length<Phase>(&arg0.phases)
    }

    public fun phase_is_open(arg0: &MintConfig, arg1: u64) : bool {
        assert!(arg1 < 0x1::vector::length<Phase>(&arg0.phases), 5);
        0x1::vector::borrow<Phase>(&arg0.phases, arg1).is_open
    }

    public fun platform_fee_bps(arg0: &MintConfig) : u64 {
        arg0.platform_fee_bps
    }

    public fun platform_treasury(arg0: &MintConfig) : address {
        arg0.platform_treasury
    }

    public fun provenance_hash(arg0: &Provenance) : vector<u8> {
        arg0.hash
    }

    public fun provenance_scheme(arg0: &Provenance) : 0x1::string::String {
        arg0.scheme
    }

    entry fun public_mint_box_many(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.onchain_registry, 20);
        assert_mint_ready(arg1);
        assert_supply(arg1, arg4);
        let v0 = charge_and_check(arg0, arg2, arg3, arg4, arg5, arg6);
        mint_boxes_internal(arg1, arg4, v0, arg6);
    }

    entry fun public_mint_many(arg0: &mut MintConfig, arg1: &mut Collection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert_mint_ready(arg1);
        assert_supply(arg1, arg4);
        let v0 = charge_and_check(arg0, arg2, arg3, arg4, arg5, arg7);
        let v1 = 0x2::random::new_generator(arg6, arg7);
        let v2 = &mut v1;
        draw_and_mint(arg1, arg4, v0, v2, arg7);
    }

    public fun push_phase(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = Phase{
            name           : 0x1::string::utf8(arg2),
            price          : arg3,
            gated          : arg4,
            max_per_wallet : arg5,
            is_open        : false,
        };
        0x1::vector::push_back<Phase>(&mut arg1.phases, v0);
    }

    public fun remaining(arg0: &Collection) : u64 {
        arg0.size - arg0.drawn
    }

    public fun remove_from_allowlist(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.allowlist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.allowlist, arg2);
        };
    }

    entry fun reveal(arg0: &mut Collection, arg1: &mut Item, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = &mut v0;
        reveal_inner(arg0, arg1, v1, arg3);
    }

    fun reveal_inner(arg0: &mut Collection, arg1: &mut Item, arg2: &mut 0x2::random::RandomGenerator, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.onchain_registry, 20);
        assert!(arg1.index == 0, 14);
        assert!(arg0.drawn < arg0.size, 15);
        let v0 = draw_index(arg0, arg2);
        assert!(0x2::table::contains<u64, ItemData>(&arg0.registry, v0), 13);
        let ItemData { attributes: v1 } = 0x2::table::remove<u64, ItemData>(&mut arg0.registry, v0);
        arg1.index = v0 + 1;
        arg1.attributes = v1;
        arg1.metadata_version = 1;
        let v2 = ItemRevealed{
            object_id : 0x2::object::id<Item>(arg1),
            number    : arg1.number,
            index     : arg1.index,
            owner     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ItemRevealed>(v2);
    }

    entry fun reveal_many(arg0: &mut Collection, arg1: vector<Item>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Item>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v0 <= 25, 6);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        while (!0x1::vector::is_empty<Item>(&arg1)) {
            let v2 = 0x1::vector::pop_back<Item>(&mut arg1);
            let v3 = &mut v2;
            let v4 = &mut v1;
            reveal_inner(arg0, v3, v4, arg3);
            0x2::transfer::public_transfer<Item>(v2, 0x2::tx_context::sender(arg3));
        };
        0x1::vector::destroy_empty<Item>(arg1);
    }

    public fun royalty_share_count(arg0: &RoyaltySplitter) : u64 {
        0x1::vector::length<SplitShare>(&arg0.shares)
    }

    public fun seal_corrections(arg0: &AdminCap, arg1: &mut Corrections) {
        arg1.sealed = true;
        let v0 = CorrectionsSealed{corrections_id: 0x2::object::id<Corrections>(arg1)};
        0x2::event::emit<CorrectionsSealed>(v0);
    }

    public fun seed_correction(arg0: &AdminCap, arg1: &mut Corrections, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) {
        assert!(!arg1.sealed, 21);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 12);
        if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg1.fixes, arg2)) {
            *0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.fixes, arg2) = build_attributes(&arg3, &arg4, 0, 0x1::vector::length<vector<u8>>(&arg3));
        } else {
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg1.fixes, arg2, build_attributes(&arg3, &arg4, 0, 0x1::vector::length<vector<u8>>(&arg3)));
        };
    }

    public fun seed_item(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>) {
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 12);
        seed_one(arg1, arg2, build_attributes(&arg3, &arg4, 0, 0x1::vector::length<vector<u8>>(&arg3)));
    }

    public fun seed_items_batch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 12);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<vector<u8>>(&arg5), 12);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            seed_one(arg1, *0x1::vector::borrow<u64>(&arg2, v1), build_attributes(&arg4, &arg5, v2, v3));
            v2 = v2 + v3;
            v1 = v1 + 1;
        };
        assert!(v2 == 0x1::vector::length<vector<u8>>(&arg4), 12);
    }

    fun seed_one(arg0: &mut Collection, arg1: u64, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        assert!(arg0.onchain_registry, 20);
        assert!(arg1 < arg0.size, 9);
        assert!(!0x2::table::contains<u64, bool>(&arg0.seeded_flags, arg1), 10);
        0x2::table::add<u64, bool>(&mut arg0.seeded_flags, arg1, true);
        let v0 = ItemData{attributes: arg2};
        0x2::table::add<u64, ItemData>(&mut arg0.registry, arg1, v0);
        arg0.seeded = arg0.seeded + 1;
    }

    public fun seeded(arg0: &Collection) : u64 {
        arg0.seeded
    }

    public fun set_claim_gate(arg0: &AdminCap, arg1: &mut ClaimGate, arg2: u64, arg3: u64, arg4: bool) {
        assert!(arg2 <= arg1.cap, 24);
        assert!(arg2 >= arg1.used, 24);
        assert!(arg3 == 0 || arg1.treasury != @0x0, 7);
        arg1.cap = arg2;
        arg1.price = arg3;
        arg1.is_open = arg4;
    }

    public fun set_open(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.is_open = arg2;
    }

    public fun set_phase_open(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: bool) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2).is_open = arg3;
    }

    public fun set_phase_params(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64, arg3: u64, arg4: bool, arg5: u64) {
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 5);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        v0.price = arg3;
        v0.gated = arg4;
        v0.max_per_wallet = arg5;
    }

    public fun set_revenue_split(arg0: &AdminCap, arg1: &mut MintConfig, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: address) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 12);
        let v0 = 0x1::vector::empty<SplitShare>();
        if (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0;
            let v2 = 0;
            while (v2 < 0x1::vector::length<address>(&arg2)) {
                let v3 = *0x1::vector::borrow<address>(&arg2, v2);
                let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
                assert!(v3 != @0x0, 24);
                v1 = v1 + v4;
                let v5 = SplitShare{
                    recipient : v3,
                    bps       : v4,
                };
                0x1::vector::push_back<SplitShare>(&mut v0, v5);
                v2 = v2 + 1;
            };
            assert!(v1 == 10000, 24);
        };
        assert!(arg4 == 0 || arg5 != @0x0, 24);
        assert!(arg4 == 0 || !0x1::vector::is_empty<SplitShare>(&v0), 24);
        let v6 = 0;
        while (v6 < 0x1::vector::length<Phase>(&arg1.phases)) {
            let v7 = *0x1::vector::borrow<Phase>(&arg1.phases, v6);
            if (v7.price > 0) {
                assert!(arg4 <= v7.price, 24);
            };
            v6 = v6 + 1;
        };
        arg1.splits = v0;
        arg1.fixed_fee = arg4;
        arg1.fixed_fee_recipient = arg5;
        let v8 = RevenueSplitSet{
            config_id           : 0x2::object::id<MintConfig>(arg1),
            recipients          : arg2,
            bps                 : arg3,
            fixed_fee           : arg4,
            fixed_fee_recipient : arg5,
        };
        0x2::event::emit<RevenueSplitSet>(v8);
    }

    public fun set_royalty_split(arg0: &AdminCap, arg1: &mut RoyaltySplitter, arg2: vector<address>, arg3: vector<u64>) {
        arg1.shares = build_shares(arg2, arg3);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut MintConfig, arg2: address) {
        assert!(arg2 != @0x0, 7);
        arg1.treasury = arg2;
    }

    public fun size(arg0: &Collection) : u64 {
        arg0.size
    }

    public fun split_count(arg0: &MintConfig) : u64 {
        0x1::vector::length<SplitShare>(&arg0.splits)
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun treasury(arg0: &MintConfig) : address {
        arg0.treasury
    }

    public fun unrevealed(arg0: &Collection) : u64 {
        arg0.minted - arg0.drawn
    }

    // decompiled from Move bytecode v7
}

