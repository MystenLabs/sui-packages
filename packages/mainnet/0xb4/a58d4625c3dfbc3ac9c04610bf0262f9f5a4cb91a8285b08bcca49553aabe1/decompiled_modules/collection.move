module 0xb4a58d4625c3dfbc3ac9c04610bf0262f9f5a4cb91a8285b08bcca49553aabe1::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SeedCap has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    struct ItemData has store {
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        filler: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        pad: vector<u8>,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        supply: u64,
        minted: u64,
        burned: u64,
        price: u64,
        stake_amount: u64,
        lp_amount: u64,
        fee_wallet: address,
        royalty_wallet: address,
        validator: address,
        swap_pool: 0x2::object::ID,
        lp_pool: 0x2::object::ID,
        vault: 0x2::object::ID,
        policy: 0x2::object::ID,
        graveyard: 0x2::object::ID,
        graveyard_cap: 0x2::kiosk::KioskOwnerCap,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Item>,
        mint_open: bool,
        holder_start_ms: u64,
        public_start_ms: u64,
        min_holder_balance: u64,
        registry: 0x2::table::Table<u64, ItemData>,
        seeded: u64,
        pool: vector<u16>,
        drawn: u64,
        reservations: 0x2::table::Table<u64, address>,
        reserved_total: u64,
        moved: 0x2::table::Table<u64, u64>,
        items: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        collection: 0x2::object::ID,
        proofs: 0x2::table::Table<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>,
        positions: u64,
        live: u64,
        pot_a: 0x2::balance::Balance<T0>,
        pot_b: 0x2::balance::Balance<0x2::sui::SUI>,
        acc_a: u128,
        acc_b: u128,
        sweep_fee_bps: u64,
        sweep_open: bool,
        swept_a: u64,
        swept_b: u64,
        paid_a: u64,
        paid_b: u64,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        number: u64,
        index: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        filler: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        media: 0x1::string::String,
        vault: 0x2::object::ID,
        position: u64,
        stake: 0x1::option::Option<0x3::staking_pool::StakedSui>,
        principal: u64,
        validator: address,
        status: 0x1::string::String,
        debt_a: u128,
        debt_b: u128,
        minted_epoch: u64,
        burned_epoch: u64,
        pad: vector<u8>,
    }

    struct CollectionCreated has copy, drop {
        collection: 0x2::object::ID,
        policy: 0x2::object::ID,
        graveyard: 0x2::object::ID,
        supply: u64,
        price: u64,
    }

    struct VaultCreated has copy, drop {
        collection: 0x2::object::ID,
        vault: 0x2::object::ID,
    }

    struct SeedCapIssued has copy, drop {
        collection: 0x2::object::ID,
        to: address,
    }

    struct Seeded has copy, drop {
        collection: 0x2::object::ID,
        count: u64,
        seeded: u64,
    }

    struct Reserved has copy, drop {
        collection: 0x2::object::ID,
        index: u64,
        minter: address,
    }

    struct Minted has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        index: u64,
        minter: address,
        principal: u64,
        validator: address,
        position: u64,
        reserved: bool,
    }

    struct PositionLocked has copy, drop {
        vault: 0x2::object::ID,
        position: u64,
        ones: u64,
        minter: address,
        liquidity: u128,
        swap_in: u64,
        lp_sui: u64,
        lp_a: u64,
        fee: u64,
    }

    struct Harvested has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        index: u64,
        reward: u64,
        validator: address,
        holder: address,
    }

    struct Collected has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        index: u64,
        amount_a: u64,
        amount_b: u64,
        holder: address,
    }

    struct Swept has copy, drop {
        vault: 0x2::object::ID,
        caller: address,
        positions: u64,
        amount_a: u64,
        amount_b: u64,
        caller_a: u64,
        caller_b: u64,
        live: u64,
    }

    struct Burned has copy, drop {
        item: 0x2::object::ID,
        number: u64,
        index: u64,
        holder: address,
        principal: u64,
        staking_out: u64,
        pot_a: u64,
        pot_b: u64,
        royalty: u64,
        live: u64,
    }

    struct ValidatorSet has copy, drop {
        collection: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct PoolsSet has copy, drop {
        collection: 0x2::object::ID,
        swap_from: 0x2::object::ID,
        swap_to: 0x2::object::ID,
        lp_from: 0x2::object::ID,
        lp_to: 0x2::object::ID,
    }

    struct FeeWalletSet has copy, drop {
        collection: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct RoyaltyWalletSet has copy, drop {
        collection: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct ScheduleSet has copy, drop {
        collection: 0x2::object::ID,
        holder_start_ms: u64,
        public_start_ms: u64,
        min_holder_balance: u64,
    }

    struct MintOpenSet has copy, drop {
        collection: 0x2::object::ID,
        open: bool,
    }

    struct SweepSet has copy, drop {
        vault: 0x2::object::ID,
        open: bool,
        fee_bps: u64,
    }

    struct RoyaltySet has copy, drop {
        collection: 0x2::object::ID,
        bps: u16,
        min: u64,
    }

    struct RoyaltyWithdrawn has copy, drop {
        collection: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct Migrated has copy, drop {
        object: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct AdminTransferred has copy, drop {
        to: address,
    }

    public fun position(arg0: &Item) : u64 {
        arg0.position
    }

    public fun acc<T0>(arg0: &Vault<T0>) : (u128, u128) {
        (arg0.acc_a, arg0.acc_b)
    }

    fun assert_configured(arg0: &Collection) {
        let v0 = 0x2::object::id_from_address(@0x0);
        let v1 = if (arg0.fee_wallet != @0x0) {
            if (arg0.royalty_wallet != @0x0) {
                if (arg0.validator != @0x0) {
                    if (arg0.swap_pool != v0) {
                        if (arg0.lp_pool != v0) {
                            arg0.vault != v0
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
            }
        } else {
            false
        };
        assert!(v1, 109);
    }

    public fun attributes(arg0: &Item) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    fun build_attributes(arg0: &vector<vector<u8>>, arg1: &vector<vector<u8>>, arg2: u64, arg3: u64) : (0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, u64) {
        assert!(arg3 < 128, 128);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 1;
        let v2 = 0;
        while (v2 < arg3) {
            let v3 = *0x1::vector::borrow<vector<u8>>(arg0, arg2 + v2);
            let v4 = *0x1::vector::borrow<vector<u8>>(arg1, arg2 + v2);
            assert!(0x1::vector::length<u8>(&v3) <= 127 && 0x1::vector::length<u8>(&v4) <= 127, 128);
            let v5 = v1 + 2 + 0x1::vector::length<u8>(&v3);
            v1 = v5 + 0x1::vector::length<u8>(&v4);
            let v6 = 0x1::string::utf8(v3);
            assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &v6), 126);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, v6, 0x1::string::utf8(v4));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun build_filler(arg0: u64) : (0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, u64) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v2, 48 + (v1 as u8));
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(v2), 0x1::string::utf8(b""));
            v1 = v1 + 1;
        };
        (v0, 1 + 3 * arg0)
    }

    public fun burn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        check_burn<T0>(arg0, arg1, arg3, arg4);
        let (v0, v1) = take_out(arg5, arg6, arg7, arg8);
        let v2 = v0;
        assert!(v2.vault == 0x2::object::id<Vault<T0>>(arg1), 110);
        assert!(is_active(&v2), 111);
        let v3 = 0x3::sui_system::request_withdraw_stake_non_entry(arg2, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut v2.stake), arg8);
        settle_burn<T0>(arg0, arg1, arg3, arg4, v2, v1, v3, arg8);
    }

    public fun burned(arg0: &Collection) : u64 {
        arg0.burned
    }

    fun check_burn<T0>(arg0: &Collection, arg1: &Vault<T0>, arg2: &0x2::transfer_policy::TransferPolicy<Item>, arg3: &0x2::kiosk::Kiosk) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg2) == arg0.policy, 118);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.graveyard, 117);
    }

    fun check_collection(arg0: &Collection) {
        assert!(arg0.version == 1, 100);
    }

    fun check_vault<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 100);
    }

    fun check_window(arg0: &Collection, arg1: u64, arg2: 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(arg1 >= arg0.holder_start_ms, 135);
            assert!(*0x1::option::borrow<u64>(&arg2) >= arg0.min_holder_balance, 136);
        } else {
            assert!(arg1 >= arg0.public_start_ms, 135);
        };
    }

    public fun collect<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        check_vault<T0>(arg0);
        let v0 = 0x2::kiosk::borrow_mut<Item>(arg1, arg2, arg3);
        assert!(v0.vault == 0x2::object::id<Vault<T0>>(arg0), 110);
        assert!(is_active(v0), 111);
        let (v1, v2) = pay_pot<T0>(arg0, v0, arg4);
        let v3 = v2;
        let v4 = v1;
        let v5 = Collected{
            item     : arg3,
            number   : v0.number,
            index    : v0.index,
            amount_a : 0x2::coin::value<T0>(&v4),
            amount_b : 0x2::coin::value<0x2::sui::SUI>(&v3),
            holder   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Collected>(v5);
        let v6 = 0x2::tx_context::sender(arg4);
        send<T0>(v4, v6);
        send_sui(v3, v6);
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        check_collection(arg1);
        assert!(arg1.vault == 0x2::object::id_from_address(@0x0), 119);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        arg1.vault = v1;
        let v2 = VaultCreated{
            collection : 0x2::object::id<Collection>(arg1),
            vault      : v1,
        };
        0x2::event::emit<VaultCreated>(v2);
        let v3 = Vault<T0>{
            id            : v0,
            version       : 1,
            collection    : 0x2::object::id<Collection>(arg1),
            proofs        : 0x2::table::new<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg2),
            positions     : 0,
            live          : 0,
            pot_a         : 0x2::balance::zero<T0>(),
            pot_b         : 0x2::balance::zero<0x2::sui::SUI>(),
            acc_a         : 0,
            acc_b         : 0,
            sweep_fee_bps : 100,
            sweep_open    : true,
            swept_a       : 0,
            swept_b       : 0,
            paid_a        : 0,
            paid_b        : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v3);
    }

    fun credit_slack<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        arg0.acc_b = arg0.acc_b + (v0 as u128) * 1000000000000 / (arg0.live as u128);
        arg0.swept_b = arg0.swept_b + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot_b, arg1);
    }

    fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v2 = (arg0.live as u128);
        arg0.acc_a = arg0.acc_a + (v0 as u128) * 1000000000000 / v2;
        arg0.acc_b = arg0.acc_b + (v1 as u128) * 1000000000000 / v2;
        arg0.swept_a = arg0.swept_a + v0;
        arg0.swept_b = arg0.swept_b + v1;
        0x2::balance::join<T0>(&mut arg0.pot_a, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot_b, arg2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, (((0x2::balance::value<T0>(&arg1) as u128) * (arg0.sweep_fee_bps as u128) / 10000) as u64)), arg3), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, (((0x2::balance::value<0x2::sui::SUI>(&arg2) as u128) * (arg0.sweep_fee_bps as u128) / 10000) as u64)), arg3))
    }

    public fun destroy_seed_cap(arg0: SeedCap) {
        let SeedCap {
            id         : v0,
            collection : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun draw(arg0: &mut Collection, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        assert!(arg0.drawn < arg0.supply, 102);
        arg0.drawn = arg0.drawn + 1;
        (0x1::vector::swap_remove<u16>(&mut arg0.pool, 0x2::random::generate_u64_in_range(arg1, 0, 0x1::vector::length<u16>(&arg0.pool) - 1)) as u64)
    }

    public fun drawn(arg0: &Collection) : u64 {
        arg0.drawn
    }

    public fun fee_wallet(arg0: &Collection) : address {
        arg0.fee_wallet
    }

    public fun filler_len(arg0: &Item) : u64 {
        0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&arg0.filler)
    }

    fun forge<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: 0x3::staking_pool::StakedSui, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : Item {
        assert!(arg0.minted < arg0.supply, 102);
        arg0.minted = arg0.minted + 1;
        arg1.live = arg1.live + 1;
        let v0 = 0x2::table::borrow<u64, ItemData>(&arg0.registry, arg3);
        let v1 = v0.pad;
        let v2 = 0x3::staking_pool::staked_sui_amount(&arg2);
        let v3 = arg0.validator;
        let v4 = 0x2::object::new(arg6);
        let v5 = 0x2::object::uid_to_inner(&v4);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.items, arg3, v5);
        let v6 = Minted{
            item      : v5,
            number    : arg0.minted,
            index     : arg3,
            minter    : 0x2::tx_context::sender(arg6),
            principal : v2,
            validator : v3,
            position  : arg4,
            reserved  : arg5,
        };
        0x2::event::emit<Minted>(v6);
        Item{
            id           : v4,
            number       : arg0.minted,
            index        : arg3,
            attributes   : v0.attributes,
            filler       : v0.filler,
            media        : 0x1::string::utf8(b"tokens"),
            vault        : 0x2::object::id<Vault<T0>>(arg1),
            position     : arg4,
            stake        : 0x1::option::some<0x3::staking_pool::StakedSui>(arg2),
            principal    : v2,
            validator    : v3,
            status       : 0x1::string::utf8(b"Active"),
            debt_a       : arg1.acc_a,
            debt_b       : arg1.acc_b,
            minted_epoch : 0x2::tx_context::epoch(arg6),
            burned_epoch : 0,
            pad          : v1,
        }
    }

    public fun graveyard_id(arg0: &Collection) : 0x2::object::ID {
        arg0.graveyard
    }

    public fun harvest(arg0: &Collection, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        let v0 = 0x2::kiosk::borrow_mut<Item>(arg2, arg3, arg4);
        assert!(is_active(v0), 111);
        let v1 = 0x3::sui_system::request_withdraw_stake_non_entry(arg1, 0x1::option::extract<0x3::staking_pool::StakedSui>(&mut v0.stake), arg5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) > v0.principal, 112);
        let v2 = 0x3::sui_system::request_add_stake_non_entry(arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v1, v0.principal, arg5), arg0.validator, arg5);
        assert!(0x3::staking_pool::staked_sui_amount(&v2) == v0.principal, 113);
        0x1::option::fill<0x3::staking_pool::StakedSui>(&mut v0.stake, v2);
        v0.validator = arg0.validator;
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = Harvested{
            item      : arg4,
            number    : v0.number,
            index     : v0.index,
            reward    : 0x2::balance::value<0x2::sui::SUI>(&v1),
            validator : arg0.validator,
            holder    : v3,
        };
        0x2::event::emit<Harvested>(v4);
        send_sui(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), v3);
    }

    public fun has_proof<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg0.proofs, arg1)
    }

    public fun has_stake(arg0: &Item) : bool {
        0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.stake)
    }

    public fun holder_start_ms(arg0: &Collection) : u64 {
        arg0.holder_start_ms
    }

    public fun index(arg0: &Item) : u64 {
        arg0.index
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(5000000000 >= 1000000000, 123);
        assert!(5000000000 > 0 && 5000000000 + 5000000000 <= 12000000000, 123);
        assert!(11111 >= 1 && 11111 <= 65535, 122);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x1::string::utf8(b"https://assets.alienz.tech/collections/29a0f1cd164ad9789ae6c5370d94a5657da0188f96b59ea3d61a1e98a1f7464b/");
        0x1::string::append(&mut v2, 0x1::string::utf8(b"{media}/{index}."));
        0x1::string::append(&mut v2, 0x1::string::utf8(b"png"));
        let v3 = 0x1::string::utf8(b"https://theones.alienz.tech/");
        0x1::string::append(&mut v3, 0x1::string::utf8(b"piece/{index}"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"number"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"principal"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"validator"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"The Ones #{index}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"11,111 Ones built for longevity on Sui, with every mint adding liquidity to $ONE while unique mechanics connect the NFT, token and community. X: @just1sui TG: @justonesuicto"));
        0x1::vector::push_back<0x1::string::String>(v7, v2);
        0x1::vector::push_back<0x1::string::String>(v7, v2);
        0x1::vector::push_back<0x1::string::String>(v7, v3);
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://theones.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Alienztech"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{number}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{status}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{principal}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{validator}"));
        let v8 = 0x2::display::new_with_fields<Item>(&v1, v4, v6, arg1);
        0x2::display::update_version<Item>(&mut v8);
        let (v9, v10) = 0x2::transfer_policy::new<Item>(&v1, arg1);
        let v11 = v10;
        let v12 = v9;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Item>(&mut v12, &v11, 500, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Item>(&mut v12, &v11);
        let (v13, v14) = 0x2::kiosk::new(arg1);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x2::object::new(arg1);
        let v18 = 0x2::object::uid_to_inner(&v17);
        0x2::kiosk::set_owner_custom(&mut v16, &v15, 0x2::object::id_to_address(&v18));
        let v19 = Collection{
            id                 : v17,
            version            : 1,
            name               : 0x1::string::utf8(b"The Ones"),
            supply             : 11111,
            minted             : 0,
            burned             : 0,
            price              : 12000000000,
            stake_amount       : 5000000000,
            lp_amount          : 5000000000,
            fee_wallet         : @0x0,
            royalty_wallet     : @0x0,
            validator          : @0x0,
            swap_pool          : 0x2::object::id_from_address(@0x0),
            lp_pool            : 0x2::object::id_from_address(@0x0),
            vault              : 0x2::object::id_from_address(@0x0),
            policy             : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(&v12),
            graveyard          : 0x2::object::id<0x2::kiosk::Kiosk>(&v16),
            graveyard_cap      : v15,
            policy_cap         : v11,
            mint_open          : false,
            holder_start_ms    : 18446744073709551615,
            public_start_ms    : 18446744073709551615,
            min_holder_balance : 18446744073709551615,
            registry           : 0x2::table::new<u64, ItemData>(arg1),
            seeded             : 0,
            pool               : vector[],
            drawn              : 0,
            reservations       : 0x2::table::new<u64, address>(arg1),
            reserved_total     : 0,
            moved              : 0x2::table::new<u64, u64>(arg1),
            items              : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        let v20 = CollectionCreated{
            collection : v18,
            policy     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(&v12),
            graveyard  : 0x2::object::id<0x2::kiosk::Kiosk>(&v16),
            supply     : 11111,
            price      : 12000000000,
        };
        0x2::event::emit<CollectionCreated>(v20);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Item>>(v12);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v16);
        0x2::transfer::share_object<Collection>(v19);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v8, v0);
        let v21 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v21, v0);
    }

    public fun is_active(arg0: &Item) : bool {
        arg0.status == 0x1::string::utf8(b"Active")
    }

    public fun is_minted(arg0: &Collection, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.items, arg1)
    }

    public fun issue_seed_cap(arg0: &AdminCap, arg1: &Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_collection(arg1);
        let v0 = SeedCapIssued{
            collection : 0x2::object::id<Collection>(arg1),
            to         : arg2,
        };
        0x2::event::emit<SeedCapIssued>(v0);
        let v1 = SeedCap{
            id         : 0x2::object::new(arg3),
            collection : 0x2::object::id<Collection>(arg1),
        };
        0x2::transfer::transfer<SeedCap>(v1, arg2);
    }

    public fun item_id(arg0: &Collection, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.items, arg1)
    }

    public fun item_validator(arg0: &Item) : address {
        arg0.validator
    }

    public fun item_vault(arg0: &Item) : 0x2::object::ID {
        arg0.vault
    }

    public fun live<T0>(arg0: &Vault<T0>) : u64 {
        arg0.live
    }

    public fun lp_amount(arg0: &Collection) : u64 {
        arg0.lp_amount
    }

    public fun lp_pool(arg0: &Collection) : 0x2::object::ID {
        arg0.lp_pool
    }

    public fun max_per_tx() : u64 {
        10
    }

    public fun media(arg0: &Item) : 0x1::string::String {
        arg0.media
    }

    public fun migrate_collection(arg0: &AdminCap, arg1: &mut Collection) {
        assert!(arg1.version < 1, 121);
        let v0 = Migrated{
            object : 0x2::object::id<Collection>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun migrate_vault<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        assert!(arg1.version < 1, 121);
        let v0 = Migrated{
            object : 0x2::object::id<Vault<T0>>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun min_holder_balance(arg0: &Collection) : u64 {
        arg0.min_holder_balance
    }

    fun mint_drawn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x1::option::Option<u64>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::random::RandomGenerator, arg17: &mut 0x2::tx_context::TxContext) {
        check_window(arg0, 0x2::clock::timestamp_ms(arg15), arg9);
        assert!(arg11 >= 1 && arg11 <= 10, 116);
        assert!(arg11 <= arg0.supply - arg0.drawn, 102);
        let (v0, v1, v2, v3) = pay_and_lock<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, arg12, arg13, arg14, arg15, arg17);
        let v4 = v0;
        let v5 = 0;
        while (v5 < arg11) {
            let v6 = draw(arg0, arg16);
            let v7 = forge<T0>(arg0, arg1, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v4), v6, v1, false, arg17);
            0x2::kiosk::lock<Item>(arg7, arg8, arg6, v7);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v4);
        credit_slack<T0>(arg1, v3);
        send_sui(v2, 0x2::tx_context::sender(arg17));
    }

    entry fun mint_holder_to_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: &0x2::clock::Clock, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg16, arg17);
        let v1 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::some<u64>(0x2::coin::value<T0>(&arg9)), arg10, arg11, arg12, arg13, arg14, arg15, v1, arg17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg9, 0x2::tx_context::sender(arg17));
    }

    entry fun mint_holder_to_new_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: &0x2::clock::Clock, arg14: &0x2::random::Random, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg14, arg15);
        let (v1, v2) = 0x2::kiosk::new(arg15);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, &v3, 0x1::option::some<u64>(0x2::coin::value<T0>(&arg7)), arg8, arg9, arg10, arg11, arg12, arg13, v6, arg15);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x2::tx_context::sender(arg15));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg15));
    }

    entry fun mint_holder_to_personal_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: &0x2::clock::Clock, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg16, arg17);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg8);
        let v3 = v1;
        let v4 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v3, 0x1::option::some<u64>(0x2::coin::value<T0>(&arg9)), arg10, arg11, arg12, arg13, arg14, arg15, v4, arg17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg9, 0x2::tx_context::sender(arg17));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg8, v3, v2);
    }

    public fun mint_open(arg0: &Collection) : bool {
        arg0.mint_open
    }

    fun mint_reserved<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg14) >= arg0.holder_start_ms, 135);
        assert!(0x2::table::contains<u64, address>(&arg0.reservations, arg10), 129);
        assert!(*0x2::table::borrow<u64, address>(&arg0.reservations, arg10) == 0x2::tx_context::sender(arg15), 130);
        0x2::table::remove<u64, address>(&mut arg0.reservations, arg10);
        let (v0, v1, v2, v3) = pay_and_lock<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9, 1, arg11, arg12, arg13, arg14, arg15);
        let v4 = v0;
        let v5 = forge<T0>(arg0, arg1, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v4), arg10, v1, true, arg15);
        0x2::kiosk::lock<Item>(arg7, arg8, arg6, v5);
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v4);
        credit_slack<T0>(arg1, v3);
        send_sui(v2, 0x2::tx_context::sender(arg15));
    }

    entry fun mint_reserved_to_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        mint_reserved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    entry fun mint_reserved_to_new_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg13);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint_reserved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, &v2, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg13));
    }

    entry fun mint_reserved_to_personal_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg8);
        let v2 = v0;
        mint_reserved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg8, v2, v1);
    }

    entry fun mint_to_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &0x2::random::Random, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg15, arg16);
        let v1 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<u64>(), arg9, arg10, arg11, arg12, arg13, arg14, v1, arg16);
    }

    entry fun mint_to_new_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &0x2::random::Random, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg13, arg14);
        let (v1, v2) = 0x2::kiosk::new(arg14);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, &v3, 0x1::option::none<u64>(), arg7, arg8, arg9, arg10, arg11, arg12, v6, arg14);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg14));
    }

    entry fun mint_to_personal_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &0x2::random::Random, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg15, arg16);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg8);
        let v3 = v1;
        let v4 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v3, 0x1::option::none<u64>(), arg9, arg10, arg11, arg12, arg13, arg14, v4, arg16);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg8, v3, v2);
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun number(arg0: &Item) : u64 {
        arg0.number
    }

    fun pay_and_lock<T0>(arg0: &Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<Item>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (vector<0x3::staking_pool::StakedSui>, u64, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg0.mint_open, 101);
        assert_configured(arg0);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg6) == arg0.policy, 118);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4);
        assert!(v0 == arg0.swap_pool && v0 == arg0.lp_pool, 105);
        assert!(arg0.price <= arg9, 104);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg0.price * arg8, 103);
        let v1 = arg0.lp_amount * arg8;
        assert!(arg10 > 0 && arg10 < v1, 106);
        let v2 = (arg0.price - arg0.stake_amount - arg0.lp_amount) * arg8;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v2, arg13), arg0.fee_wallet);
        };
        let v3 = 0x1::vector::empty<0x3::staking_pool::StakedSui>();
        let v4 = 0;
        while (v4 < arg8) {
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v3, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg7, arg0.stake_amount, arg13), arg0.validator, arg13));
            v4 = v4 + 1;
        };
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg7, v1, arg13);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, false, true, arg10, 79226673515401279992447579055, arg12);
        let v9 = v8;
        let v10 = v6;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v9);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v11, arg13)), v9);
        let v12 = 0x2::balance::value<T0>(&v10);
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0x2::sui::SUI>(arg3, arg4, 4294523696, 443600, arg13);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0x2::sui::SUI>(arg3, arg4, &mut v13, v12, true, arg12);
        let (v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0x2::sui::SUI>(&v14);
        assert!(v15 == v12, 107);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v5) >= v16, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0x2::sui::SUI>(arg3, arg4, v10, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v16, arg13)), v14);
        assert!(((v11 + v16) as u128) * 10000 >= (v1 as u128) * ((10000 - 1000) as u128), 139);
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v13);
        assert!(v17 >= arg11, 108);
        let v18 = arg1.positions;
        0x2::table::add<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.proofs, v18, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg5, v13, arg13));
        arg1.positions = v18 + 1;
        let v19 = PositionLocked{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            position  : v18,
            ones      : arg8,
            minter    : 0x2::tx_context::sender(arg13),
            liquidity : v17,
            swap_in   : v11,
            lp_sui    : v11 + v16,
            lp_a      : v12,
            fee       : v2,
        };
        0x2::event::emit<PositionLocked>(v19);
        (v3, v18, arg7, 0x2::coin::into_balance<0x2::sui::SUI>(v5))
    }

    fun pay_pot<T0>(arg0: &mut Vault<T0>, arg1: &mut Item, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = (((arg0.acc_a - arg1.debt_a) / 1000000000000) as u64);
        let v1 = (((arg0.acc_b - arg1.debt_b) / 1000000000000) as u64);
        arg1.debt_a = arg0.acc_a;
        arg1.debt_b = arg0.acc_b;
        arg0.paid_a = arg0.paid_a + v0;
        arg0.paid_b = arg0.paid_b + v1;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot_a, v0), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot_b, v1), arg2))
    }

    public fun pending<T0>(arg0: &Vault<T0>, arg1: &Item) : (u64, u64) {
        ((((arg0.acc_a - arg1.debt_a) / 1000000000000) as u64), (((arg0.acc_b - arg1.debt_b) / 1000000000000) as u64))
    }

    public fun policy_id(arg0: &Collection) : 0x2::object::ID {
        arg0.policy
    }

    public fun positions<T0>(arg0: &Vault<T0>) : u64 {
        arg0.positions
    }

    public fun pot<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.pot_a), 0x2::balance::value<0x2::sui::SUI>(&arg0.pot_b))
    }

    public fun price(arg0: &Collection) : u64 {
        arg0.price
    }

    public fun principal(arg0: &Item) : u64 {
        arg0.principal
    }

    public fun public_remaining(arg0: &Collection) : u64 {
        arg0.supply - arg0.drawn
    }

    public fun public_start_ms(arg0: &Collection) : u64 {
        arg0.public_start_ms
    }

    public fun reservation(arg0: &Collection, arg1: u64) : 0x1::option::Option<address> {
        if (0x2::table::contains<u64, address>(&arg0.reservations, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<u64, address>(&arg0.reservations, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun reserve(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address) {
        check_collection(arg1);
        assert!(arg1.seeded == arg1.supply, 125);
        assert!(arg1.drawn == arg1.reserved_total, 131);
        assert!(!arg1.mint_open && arg1.reserved_total < 2, 131);
        assert!(arg2 >= 1 && arg2 <= arg1.supply, 122);
        assert!(!0x2::table::contains<u64, address>(&arg1.reservations, arg2), 132);
        assert!(arg3 != @0x0, 122);
        let v0 = if (0x2::table::contains<u64, u64>(&arg1.moved, arg2)) {
            0x2::table::remove<u64, u64>(&mut arg1.moved, arg2)
        } else {
            arg2 - 1
        };
        assert!(v0 < 0x1::vector::length<u16>(&arg1.pool) && (*0x1::vector::borrow<u16>(&arg1.pool, v0) as u64) == arg2, 122);
        let v1 = 0x1::vector::length<u16>(&arg1.pool) - 1;
        if (v0 != v1) {
            let v2 = (*0x1::vector::borrow<u16>(&arg1.pool, v1) as u64);
            if (0x2::table::contains<u64, u64>(&arg1.moved, v2)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg1.moved, v2) = v0;
            } else {
                0x2::table::add<u64, u64>(&mut arg1.moved, v2, v0);
            };
        };
        0x1::vector::swap_remove<u16>(&mut arg1.pool, v0);
        arg1.drawn = arg1.drawn + 1;
        arg1.reserved_total = arg1.reserved_total + 1;
        0x2::table::add<u64, address>(&mut arg1.reservations, arg2, arg3);
        let v3 = Reserved{
            collection : 0x2::object::id<Collection>(arg1),
            index      : arg2,
            minter     : arg3,
        };
        0x2::event::emit<Reserved>(v3);
    }

    public fun reserved_total(arg0: &Collection) : u64 {
        arg0.reserved_total
    }

    public fun royalty_wallet(arg0: &Collection) : address {
        arg0.royalty_wallet
    }

    public fun scale() : u128 {
        1000000000000
    }

    public fun seed_batch(arg0: &SeedCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>) {
        check_collection(arg1);
        assert!(arg0.collection == 0x2::object::id<Collection>(arg1), 133);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 127);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<vector<u8>>(&arg5), 127);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v3 >= 1 && v3 <= arg1.supply, 122);
            assert!(!0x2::table::contains<u64, ItemData>(&arg1.registry, v3), 124);
            assert!(v3 == arg1.seeded + 1, 134);
            assert!(v4 <= 13, 128);
            let (v5, v6) = build_attributes(&arg4, &arg5, v2, v4);
            let v7 = if (v4 < 3) {
                13 - v4
            } else {
                0
            };
            let (v8, v9) = build_filler(v7);
            assert!(v6 + v9 <= 272, 128);
            let v10 = ItemData{
                attributes : v5,
                filler     : v8,
                pad        : zeros(400 - v6 - v9),
            };
            0x2::table::add<u64, ItemData>(&mut arg1.registry, v3, v10);
            0x1::vector::push_back<u16>(&mut arg1.pool, (v3 as u16));
            arg1.seeded = arg1.seeded + 1;
            v2 = v2 + v4;
            v1 = v1 + 1;
        };
        assert!(v2 == 0x1::vector::length<vector<u8>>(&arg4), 127);
        let v11 = Seeded{
            collection : 0x2::object::id<Collection>(arg1),
            count      : v0,
            seeded     : arg1.seeded,
        };
        0x2::event::emit<Seeded>(v11);
    }

    public fun seeded(arg0: &Collection) : u64 {
        arg0.seeded
    }

    fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    fun send_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        send<0x2::sui::SUI>(arg0, arg1);
    }

    public fun set_fee_wallet(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        check_collection(arg1);
        let v0 = FeeWalletSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.fee_wallet,
            to         : arg2,
        };
        0x2::event::emit<FeeWalletSet>(v0);
        arg1.fee_wallet = arg2;
    }

    public fun set_mint_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        check_collection(arg1);
        if (arg2) {
            assert_configured(arg1);
            assert!(arg1.seeded == arg1.supply, 125);
        };
        arg1.mint_open = arg2;
        let v0 = MintOpenSet{
            collection : 0x2::object::id<Collection>(arg1),
            open       : arg2,
        };
        0x2::event::emit<MintOpenSet>(v0);
    }

    public fun set_pools(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        check_collection(arg1);
        assert!(arg1.minted == 0, 140);
        let v0 = PoolsSet{
            collection : 0x2::object::id<Collection>(arg1),
            swap_from  : arg1.swap_pool,
            swap_to    : arg2,
            lp_from    : arg1.lp_pool,
            lp_to      : arg3,
        };
        0x2::event::emit<PoolsSet>(v0);
        arg1.swap_pool = arg2;
        arg1.lp_pool = arg3;
    }

    public fun set_royalty(arg0: &AdminCap, arg1: &Collection, arg2: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg3: u16, arg4: u64) {
        check_collection(arg1);
        assert!(arg3 <= 1000 && arg4 == 0, 141);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg2) == arg1.policy, 118);
        0x2::transfer_policy::remove_rule<Item, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Config>(arg2, &arg1.policy_cap);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Item>(arg2, &arg1.policy_cap, arg3, arg4);
        let v0 = RoyaltySet{
            collection : 0x2::object::id<Collection>(arg1),
            bps        : arg3,
            min        : arg4,
        };
        0x2::event::emit<RoyaltySet>(v0);
    }

    public fun set_royalty_wallet(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        check_collection(arg1);
        let v0 = RoyaltyWalletSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.royalty_wallet,
            to         : arg2,
        };
        0x2::event::emit<RoyaltyWalletSet>(v0);
        arg1.royalty_wallet = arg2;
    }

    public fun set_schedule(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: u64, arg4: u64) {
        check_collection(arg1);
        assert!(arg2 <= arg3 && arg4 > 0, 137);
        arg1.holder_start_ms = arg2;
        arg1.public_start_ms = arg3;
        arg1.min_holder_balance = arg4;
        let v0 = ScheduleSet{
            collection         : 0x2::object::id<Collection>(arg1),
            holder_start_ms    : arg2,
            public_start_ms    : arg3,
            min_holder_balance : arg4,
        };
        0x2::event::emit<ScheduleSet>(v0);
    }

    public fun set_sweep<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: bool, arg3: u64) {
        check_vault<T0>(arg1);
        assert!(arg3 <= 1000, 120);
        arg1.sweep_open = arg2;
        arg1.sweep_fee_bps = arg3;
        let v0 = SweepSet{
            vault   : 0x2::object::id<Vault<T0>>(arg1),
            open    : arg2,
            fee_bps : arg3,
        };
        0x2::event::emit<SweepSet>(v0);
    }

    public fun set_validator(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        check_collection(arg1);
        let v0 = ValidatorSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.validator,
            to         : arg2,
        };
        0x2::event::emit<ValidatorSet>(v0);
        arg1.validator = arg2;
    }

    fun settle_burn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg3: &mut 0x2::kiosk::Kiosk, arg4: Item, arg5: 0x2::transfer_policy::TransferRequest<Item>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = &mut arg4;
        let (v2, v3) = pay_pot<T0>(arg1, v1, arg7);
        let v4 = v3;
        let v5 = v2;
        arg1.live = arg1.live - 1;
        arg0.burned = arg0.burned + 1;
        arg4.status = 0x1::string::utf8(b"Burned");
        arg4.media = 0x1::string::utf8(b"burned");
        arg4.burned_epoch = 0x2::tx_context::epoch(arg7);
        assert!(0x1::option::is_none<0x3::staking_pool::StakedSui>(&arg4.stake), 113);
        let v6 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<Item>(arg2, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<Item>(arg2, &mut arg5, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg6, v6), arg7));
        0x2::kiosk::lock<Item>(arg3, &arg0.graveyard_cap, arg2, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<Item>(&mut arg5, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Item>(arg2, arg5);
        let v10 = Burned{
            item        : 0x2::object::id<Item>(&arg4),
            number      : arg4.number,
            index       : arg4.index,
            holder      : v0,
            principal   : arg4.principal,
            staking_out : 0x2::balance::value<0x2::sui::SUI>(&arg6),
            pot_a       : 0x2::coin::value<T0>(&v5),
            pot_b       : 0x2::coin::value<0x2::sui::SUI>(&v4),
            royalty     : v6,
            live        : arg1.live,
        };
        0x2::event::emit<Burned>(v10);
        let v11 = 0x2::coin::from_balance<0x2::sui::SUI>(arg6, arg7);
        0x2::coin::join<0x2::sui::SUI>(&mut v11, v4);
        send<T0>(v5, v0);
        send_sui(v11, v0);
    }

    public fun stake_amount(arg0: &Collection) : u64 {
        arg0.stake_amount
    }

    public fun status(arg0: &Item) : 0x1::string::String {
        arg0.status
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    public fun swap_pool(arg0: &Collection) : 0x2::object::ID {
        arg0.swap_pool
    }

    public fun sweep<T0>(arg0: &Collection, arg1: &mut Vault<T0>, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(arg1.sweep_open, 114);
        assert!(arg1.live > 0, 115);
        let v0 = 0x1::vector::length<u64>(&arg5);
        assert!(v0 > 0 && v0 <= 50, 116);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg5, v3);
            assert!(v4 < arg1.positions, 122);
            let (v5, v6) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg2, arg3, arg4, 0x2::table::borrow_mut<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.proofs, v4), arg6);
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v5));
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::coin::into_balance<0x2::sui::SUI>(v6));
            v3 = v3 + 1;
        };
        let (v7, v8) = deposit<T0>(arg1, v1, v2, arg6);
        let v9 = v8;
        let v10 = v7;
        let v11 = 0x2::tx_context::sender(arg6);
        let v12 = Swept{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            caller    : v11,
            positions : v0,
            amount_a  : 0x2::balance::value<T0>(&v1),
            amount_b  : 0x2::balance::value<0x2::sui::SUI>(&v2),
            caller_a  : 0x2::coin::value<T0>(&v10),
            caller_b  : 0x2::coin::value<0x2::sui::SUI>(&v9),
            live      : arg1.live,
        };
        0x2::event::emit<Swept>(v12);
        send<T0>(v10, v11);
        send_sui(v9, v11);
    }

    public fun sweep_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.sweep_fee_bps
    }

    public fun sweep_open<T0>(arg0: &Vault<T0>) : bool {
        arg0.sweep_open
    }

    fun take_out(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (Item, 0x2::transfer_policy::TransferRequest<Item>) {
        0x2::kiosk::purchase_with_cap<Item>(arg0, 0x2::kiosk::list_with_purchase_cap<Item>(arg0, arg1, arg2, 0, arg3), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public fun traits(arg0: &Collection, arg1: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        0x2::table::borrow<u64, ItemData>(&arg0.registry, arg1).attributes
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        let v0 = AdminTransferred{to: arg1};
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun validator(arg0: &Collection) : address {
        arg0.validator
    }

    public fun vault_id(arg0: &Collection) : 0x2::object::ID {
        arg0.vault
    }

    public fun version() : u64 {
        1
    }

    public fun withdraw_royalties(arg0: &Collection, arg1: &mut 0x2::transfer_policy::TransferPolicy<Item>, arg2: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<Item>>(arg1) == arg0.policy, 118);
        assert!(arg0.royalty_wallet != @0x0, 138);
        let v0 = 0x2::transfer_policy::withdraw<Item>(arg1, &arg0.policy_cap, 0x1::option::none<u64>(), arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) > 0, 138);
        let v1 = RoyaltyWithdrawn{
            collection : 0x2::object::id<Collection>(arg0),
            amount     : 0x2::coin::value<0x2::sui::SUI>(&v0),
            to         : arg0.royalty_wallet,
        };
        0x2::event::emit<RoyaltyWithdrawn>(v1);
        send_sui(v0, arg0.royalty_wallet);
    }

    fun zeros(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

