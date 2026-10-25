module 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    struct PublisherKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DisplayCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LegacyStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionPoolKey has copy, drop, store {
        position: u64,
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
        config: 0x2::object::ID,
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
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<KingFizh>,
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

    struct KingFizh has store, key {
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

    struct LaunchReservationKey has copy, drop, store {
        index: u64,
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

    struct RoyaltiesDistributed has copy, drop {
        collection: 0x2::object::ID,
        policy: 0x2::object::ID,
        total: u64,
        willie: u64,
        king: u64,
    }

    struct LegacyMigrated has copy, drop {
        old: 0x2::object::ID,
        item: 0x2::object::ID,
        index: u64,
        holder: address,
        price: u64,
        vip: bool,
    }

    struct Migrated has copy, drop {
        object: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct AdminTransferred has copy, drop {
        to: address,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        code_version: u64,
        revision: u64,
        upgrade_cap: 0x1::option::Option<0x2::object::ID>,
        values: 0x2::versioned::Versioned,
    }

    struct SettingsV1 has store {
        public_mint: 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::Allocation,
        migration: 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::Allocation,
        vip_migration: 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::Allocation,
        treasury_wallet: address,
        hive_wallet: address,
        subsidy_wallet: address,
        willie_wallet: address,
        royalty_willie_bps: u16,
        royalty_bps: u16,
        validator: address,
        swap_pool: 0x2::object::ID,
        lp_pool: 0x2::object::ID,
        min_king_tokens: u64,
        holder_start_ms: u64,
        public_start_ms: u64,
        early_access_ms: u64,
        migration_duration_ms: u64,
        max_per_tx: u64,
        emergency_pauses: u64,
    }

    struct ConfigCreated has copy, drop {
        config: 0x2::object::ID,
        collection: 0x2::object::ID,
        version: u64,
    }

    struct ConfigUpdated has copy, drop {
        config: 0x2::object::ID,
        revision: u64,
        section: u8,
    }

    struct ProtocolUpgraded has copy, drop {
        collection: 0x2::object::ID,
        vault: 0x2::object::ID,
        config: 0x2::object::ID,
        from: u64,
        to: u64,
        package: 0x2::object::ID,
    }

    public fun version() : u64 {
        1
    }

    public fun position(arg0: &KingFizh) : u64 {
        arg0.position
    }

    public fun acc<T0>(arg0: &Vault<T0>) : (u128, u128) {
        (arg0.acc_a, arg0.acc_b)
    }

    public fun activate_protocol_upgrade<T0>(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut Vault<T0>, arg3: &0x2::package::UpgradeCap) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&configuration(arg1).upgrade_cap) && *0x1::option::borrow<0x2::object::ID>(&configuration(arg1).upgrade_cap) == 0x2::object::id<0x2::package::UpgradeCap>(arg3), 149);
        let v0 = if (0x2::package::version(arg3) == 1) {
            if (arg1.version < 1) {
                if (arg2.version == arg1.version) {
                    configuration(arg1).code_version == arg1.version
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 121);
        assert!(arg2.collection == 0x2::object::id<Collection>(arg1) && 0x2::object::id<Vault<T0>>(arg2) == arg1.vault, 110);
        advance_protocol_internal<T0>(arg1, arg2, 1, 0x2::package::upgrade_package(arg3));
    }

    fun advance_protocol_internal<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: u64, arg3: 0x2::object::ID) {
        let v0 = arg0.version;
        arg0.version = arg2;
        arg1.version = arg2;
        let v1 = configuration_mut(arg0);
        v1.code_version = arg2;
        let v2 = ProtocolUpgraded{
            collection : 0x2::object::id<Collection>(arg0),
            vault      : 0x2::object::id<Vault<T0>>(arg1),
            config     : arg0.config,
            from       : v0,
            to         : arg2,
            package    : arg3,
        };
        0x2::event::emit<ProtocolUpgraded>(v2);
    }

    public fun advance_protocol_version<T0>(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut Vault<T0>, arg3: &0x2::package::UpgradeCap) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        check_vault<T0>(arg2);
        assert!(arg2.collection == 0x2::object::id<Collection>(arg1) && 0x2::object::id<Vault<T0>>(arg2) == arg1.vault, 110);
        assert!(0x1::option::is_some<0x2::object::ID>(&configuration(arg1).upgrade_cap) && *0x1::option::borrow<0x2::object::ID>(&configuration(arg1).upgrade_cap) == 0x2::object::id<0x2::package::UpgradeCap>(arg3), 149);
        let v0 = 0x2::package::version(arg3);
        assert!(v0 == 1 + 1, 121);
        advance_protocol_internal<T0>(arg1, arg2, v0, 0x2::package::upgrade_package(arg3));
    }

    fun assert_action(arg0: &Collection, arg1: u8) {
        check_collection(arg0);
        assert!(settings(arg0).emergency_pauses & 1 << arg1 == 0, 148);
    }

    fun assert_admin(arg0: &AdminCap, arg1: &Collection) {
        assert!(arg0.collection == 0x2::object::id<Collection>(arg1), 150);
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

    fun assert_king<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"5fad71cd86dfb03f3941571835b54fb2a94364ae54ac7f816224837ff424b662::king::KING", 105);
    }

    fun assert_revision(arg0: &Collection, arg1: u64) {
        check_collection(arg0);
        assert!(config_revision(arg0) == arg1, 147);
    }

    fun assert_v1_fields(arg0: &0x2::display::Display<KingFizh>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"number"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"principal"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"validator"));
        let v2 = 0x2::display::fields<KingFizh>(arg0);
        assert!(0x2::vec_map::length<0x1::string::String, 0x1::string::String>(v2) == 0x1::vector::length<0x1::string::String>(&v0), 145);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v0)) {
            let (v4, _) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(v2, v3);
            assert!(*v4 == *0x1::vector::borrow<0x1::string::String>(&v0, v3), 145);
            v3 = v3 + 1;
        };
        assert!(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v2, 0x1::vector::borrow<0x1::string::String>(&v0, 0)) == 0x1::string::utf8(b"King Fizh #{index}"), 145);
        assert!(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v2, 0x1::vector::borrow<0x1::string::String>(&v0, 1)) == 0x1::string::utf8(b"King Fizh"), 145);
        assert!(*0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v2, 0x1::vector::borrow<0x1::string::String>(&v0, 2)) == *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v2, 0x1::vector::borrow<0x1::string::String>(&v0, 3)), 145);
    }

    public fun attributes(arg0: &KingFizh) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun bind_legacy_batch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<0x2::object::ID>, arg3: vector<u64>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = if (0x1::vector::length<0x2::object::ID>(&arg2) > 0) {
            if (0x1::vector::length<0x2::object::ID>(&arg2) <= 100) {
                0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u64>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 116);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::bind_identity(legacy_state_mut(arg1), *0x1::vector::borrow<0x2::object::ID>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
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

    public fun burn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) {
        check_burn<T0>(arg0, arg1, arg3, arg4);
        assert_action(arg0, 4);
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

    fun check_burn<T0>(arg0: &Collection, arg1: &Vault<T0>, arg2: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg3: &0x2::kiosk::Kiosk) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg2) == arg0.policy, 118);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg0.graveyard, 117);
    }

    fun check_collection(arg0: &Collection) {
        assert!(arg0.version == 1 && configuration(arg0).code_version == 1, 100);
    }

    fun check_public_inventory(arg0: &Collection, arg1: u64) {
        if (arg1 >= arg0.public_start_ms && arg1 - arg0.public_start_ms >= settings(arg0).migration_duration_ms) {
            assert!(0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::reserved_count(legacy_state(arg0)) == 0, 142);
        };
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

    public fun collect<T0>(arg0: &Collection, arg1: &mut Vault<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        assert_action(arg0, 3);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0) && 0x2::object::id<Vault<T0>>(arg1) == arg0.vault, 110);
        check_vault<T0>(arg1);
        let v0 = 0x2::kiosk::borrow_mut<KingFizh>(arg2, arg3, arg4);
        assert!(v0.vault == 0x2::object::id<Vault<T0>>(arg1), 110);
        assert!(is_active(v0), 111);
        let (v1, v2) = pay_pot<T0>(arg1, v0, arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = Collected{
            item     : arg4,
            number   : v0.number,
            index    : v0.index,
            amount_a : 0x2::coin::value<T0>(&v4),
            amount_b : 0x2::coin::value<0x2::sui::SUI>(&v3),
            holder   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Collected>(v5);
        let v6 = 0x2::tx_context::sender(arg5);
        send<T0>(v4, v6);
        send_sui(v3, v6);
    }

    fun config_changed(arg0: &mut Collection, arg1: u8) {
        let v0 = configuration_mut(arg0);
        v0.revision = v0.revision + 1;
        let v1 = ConfigUpdated{
            config   : 0x2::object::id<Config>(v0),
            revision : v0.revision,
            section  : arg1,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun config_code_version(arg0: &Config) : u64 {
        arg0.code_version
    }

    public fun config_id(arg0: &Collection) : 0x2::object::ID {
        arg0.config
    }

    public fun config_revision(arg0: &Collection) : u64 {
        configuration(arg0).revision
    }

    public fun config_schema_version(arg0: &Config) : u64 {
        0x2::versioned::version(&arg0.values)
    }

    public fun configuration(arg0: &Collection) : &Config {
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<ConfigKey, Config>(&arg0.id, v0)
    }

    fun configuration_mut(arg0: &mut Collection) : &mut Config {
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<ConfigKey, Config>(&mut arg0.id, v0)
    }

    public fun configure_legacy_layout(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u8>, arg3: u8, arg4: vector<u8>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::configure_layout(legacy_state_mut(arg1), arg2, arg3, arg4);
    }

    public fun configure_media(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::display::Display<KingFizh>, arg3: 0x1::string::String) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(!has_display_v2(arg1), 146);
        configure_media_internal(arg1, arg2, arg3);
    }

    public fun configure_media_and_sync(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::display::Display<KingFizh>, arg3: &mut 0x2::display_registry::Display<KingFizh>, arg4: 0x1::string::String) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = display_cover(arg2);
        let v1 = *0x2::display_registry::fields<KingFizh>(arg3);
        configure_media_internal(arg1, arg2, arg4);
        sync_display_v2(arg0, arg1, arg2, arg3);
        let v2 = DisplayCapKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<DisplayCapKey, 0x2::display_registry::DisplayCap<KingFizh>>(&arg1.id, v2);
        let v4 = 0x1::string::utf8(b"collection_cover_url");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display_registry::fields<KingFizh>(arg3), &v4) && *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(0x2::display_registry::fields<KingFizh>(arg3), &v4) == v0) {
            let v5 = 0;
            while (v5 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v1)) {
                let (v6, v7) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&v1, v5);
                if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<KingFizh>(arg2), v6)) {
                    let v8 = if (*v6 == v4) {
                        display_cover(arg2)
                    } else {
                        *v7
                    };
                    0x2::display_registry::set<KingFizh>(arg3, v3, *v6, v8);
                };
                v5 = v5 + 1;
            };
        };
    }

    fun configure_media_internal(arg0: &mut Collection, arg1: &mut 0x2::display::Display<KingFizh>, arg2: 0x1::string::String) {
        let v0 = 0x1::string::as_bytes(&arg2);
        assert!(0x1::vector::length<u8>(v0) > 8 && *0x1::vector::borrow<u8>(v0, 0x1::vector::length<u8>(v0) - 1) == 47, 109);
        let v1 = b"https://";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            assert!(*0x1::vector::borrow<u8>(v0, v2) == *0x1::vector::borrow<u8>(&v1, v2), 109);
            v2 = v2 + 1;
        };
        let v3 = 0x1::string::utf8(b".invalid");
        assert!(0x1::string::index_of(&arg2, &v3) == 0x1::vector::length<u8>(v0), 109);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::confirm_media(legacy_state_mut(arg0), 0x2::object::id<0x2::display::Display<KingFizh>>(arg1));
        0x1::string::append(&mut arg2, 0x1::string::utf8(b"{media}/{index}.webp"));
        let v4 = *0x2::display::fields<KingFizh>(arg1);
        v2 = 0;
        while (v2 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v4)) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&v4, v2);
            let v7 = if (*v5 == 0x1::string::utf8(b"image_url") || *v5 == 0x1::string::utf8(b"thumbnail_url")) {
                arg2
            } else {
                *v6
            };
            0x2::display::edit<KingFizh>(arg1, *v5, v7);
            v2 = v2 + 1;
        };
        0x2::display::update_version<KingFizh>(arg1);
    }

    public fun configured_allocation(arg0: &Collection, arg1: u8) : (u64, u64, u64, u64, u64, u64) {
        let v0 = route_allocation(arg0, arg1);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_values(&v0)
    }

    fun copy_display_fields(arg0: &0x2::display::Display<KingFizh>, arg1: &mut 0x2::display_registry::Display<KingFizh>, arg2: &0x2::display_registry::DisplayCap<KingFizh>) {
        let v0 = *0x2::display_registry::fields<KingFizh>(arg1);
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(0x2::display::fields<KingFizh>(arg0))) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(0x2::display::fields<KingFizh>(arg0), v1);
            0x2::display_registry::set<KingFizh>(arg1, arg2, *v2, *v3);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&v0)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&v0, v1);
            if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<KingFizh>(arg0), v4)) {
                0x2::display_registry::set<KingFizh>(arg1, arg2, *v4, *v5);
            };
            v1 = v1 + 1;
        };
    }

    public fun create_display_v2(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &0x2::display::Display<KingFizh>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = 0x2::object::id<0x2::display_registry::DisplayRegistry>(arg2);
        assert!(0x2::object::id_to_address(&v0) == @0xd, 144);
        assert!(!has_display_v2(arg1), 144);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::assert_media_ready(legacy_state(arg1), 0x2::object::id<0x2::display::Display<KingFizh>>(arg3));
        assert_v1_fields(arg3);
        let (v1, v2) = display_v2_extras(arg1, arg3);
        let v3 = v2;
        let v4 = v1;
        assert!(arg4 == v4 && arg5 == v3, 145);
        let (v5, v6) = 0x2::display_registry::new<KingFizh>(arg2, 0x1::internal::permit<KingFizh>(), arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = &mut v8;
        copy_display_fields(arg3, v9, &v7);
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::string::String>(&v4)) {
            assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(0x2::display::fields<KingFizh>(arg3), 0x1::vector::borrow<0x1::string::String>(&v4, v10)), 145);
            0x2::display_registry::set<KingFizh>(&mut v8, &v7, *0x1::vector::borrow<0x1::string::String>(&v4, v10), *0x1::vector::borrow<0x1::string::String>(&v3, v10));
            v10 = v10 + 1;
        };
        0x2::display_registry::share<KingFizh>(v8);
        let v11 = DisplayCapKey{dummy_field: false};
        0x2::dynamic_field::add<DisplayCapKey, 0x2::display_registry::DisplayCap<KingFizh>>(&mut arg1.id, v11, v7);
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_king<T0>();
        create_vault_internal<T0>(arg1, arg2);
    }

    fun create_vault_internal<T0>(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        assert!(arg0.vault == 0x2::object::id_from_address(@0x0), 119);
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        arg0.vault = v1;
        let v2 = VaultCreated{
            collection : 0x2::object::id<Collection>(arg0),
            vault      : v1,
        };
        0x2::event::emit<VaultCreated>(v2);
        let v3 = Vault<T0>{
            id            : v0,
            version       : 1,
            collection    : 0x2::object::id<Collection>(arg0),
            proofs        : 0x2::table::new<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg1),
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

    fun display_cover(arg0: &0x2::display::Display<KingFizh>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"image_url");
        let v1 = 0x2::vec_map::get<0x1::string::String, 0x1::string::String>(0x2::display::fields<KingFizh>(arg0), &v0);
        let v2 = b"{media}/{index}.webp";
        let v3 = 0x1::string::as_bytes(v1);
        assert!(0x1::vector::length<u8>(v3) >= 0x1::vector::length<u8>(&v2), 145);
        let v4 = 0x1::vector::length<u8>(v3) - 0x1::vector::length<u8>(&v2);
        assert!(0x1::string::substring(v1, v4, 0x1::vector::length<u8>(v3)) == 0x1::string::utf8(v2), 145);
        let v5 = 0x1::string::substring(v1, 0, v4);
        0x1::string::append(&mut v5, 0x1::string::utf8(b"tokens/0.webp"));
        v5
    }

    public fun display_v2_extras(arg0: &Collection, arg1: &0x2::display::Display<KingFizh>) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::assert_media_ready(legacy_state(arg0), 0x2::object::id<0x2::display::Display<KingFizh>>(arg1));
        let v0 = 0x1::string::utf8(b"0x");
        let v1 = 0x2::object::id<Collection>(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&v1)));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_cover_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_id"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes:json}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{index}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"King Fizh"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"King Fizh"));
        0x1::vector::push_back<0x1::string::String>(v5, display_cover(arg1));
        0x1::vector::push_back<0x1::string::String>(v5, v0);
        (v2, v4)
    }

    public fun distribute(arg0: &Collection, arg1: &mut 0x2::transfer_policy::TransferPolicy<KingFizh>, arg2: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg1) == arg0.policy, 118);
        assert_action(arg0, 6);
        let v0 = 0x2::transfer_policy::withdraw<KingFizh>(arg1, &arg0.policy_cap, 0x1::option::none<u64>(), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 > 0, 138);
        let v2 = settings(arg0);
        let (v3, v4) = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::distribute_configured(v0, v2.royalty_willie_bps, v2.willie_wallet, v2.treasury_wallet, arg2);
        let v5 = RoyaltiesDistributed{
            collection : 0x2::object::id<Collection>(arg0),
            policy     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg1),
            total      : v1,
            willie     : v3,
            king       : v4,
        };
        0x2::event::emit<RoyaltiesDistributed>(v5);
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

    public fun filler_len(arg0: &KingFizh) : u64 {
        0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&arg0.filler)
    }

    fun forge<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: 0x3::staking_pool::StakedSui, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : KingFizh {
        assert!(arg0.minted < arg0.supply, 102);
        arg0.minted = arg0.minted + 1;
        arg1.live = arg1.live + 1;
        let v0 = 0x2::table::borrow<u64, ItemData>(&arg0.registry, arg3);
        let v1 = v0.pad;
        let v2 = 0x3::staking_pool::staked_sui_amount(&arg2);
        assert!(v2 == arg0.stake_amount, 113);
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
        KingFizh{
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

    public fun full_range_ticks(arg0: u32) : (u32, u32) {
        assert!(arg0 > 0 && arg0 <= 443636, 123);
        let v0 = 443636 / arg0 * arg0;
        (4294967295 - v0 + 1, v0)
    }

    public fun graveyard_id(arg0: &Collection) : 0x2::object::ID {
        arg0.graveyard
    }

    public fun harvest(arg0: &Collection, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        check_collection(arg0);
        assert_action(arg0, 2);
        let v0 = 0x2::kiosk::borrow_mut<KingFizh>(arg2, arg3, arg4);
        assert!(is_active(v0), 111);
        assert!(v0.vault == arg0.vault, 110);
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

    public fun has_display_v2(arg0: &Collection) : bool {
        let v0 = DisplayCapKey{dummy_field: false};
        0x2::dynamic_field::exists<DisplayCapKey>(&arg0.id, v0)
    }

    public fun has_proof<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&arg0.proofs, arg1)
    }

    public fun has_stake(arg0: &KingFizh) : bool {
        0x1::option::is_some<0x3::staking_pool::StakedSui>(&arg0.stake)
    }

    public fun holder_start_ms(arg0: &Collection) : u64 {
        arg0.holder_start_ms
    }

    public fun index(arg0: &KingFizh) : u64 {
        arg0.index
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(2000000000 >= 1000000000, 123);
        assert!(1500000000 > 0 && 2000000000 + 1500000000 <= 8000000000, 123);
        assert!(2100 >= 1 && 2100 <= 65535, 122);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x1::string::utf8(b"https://assets.alienz.tech/collections/05899071423146b3ec5c7b568067414eb0c3ac26e4a4ac951c3cbc36a0fd6a36/");
        0x1::string::append(&mut v2, 0x1::string::utf8(b"{media}/{index}."));
        0x1::string::append(&mut v2, 0x1::string::utf8(b"webp"));
        let v3 = 0x1::string::utf8(b"https://kingfizh.alienz.tech/");
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
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"King Fizh #{index}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"King Fizh"));
        0x1::vector::push_back<0x1::string::String>(v7, v2);
        0x1::vector::push_back<0x1::string::String>(v7, v2);
        0x1::vector::push_back<0x1::string::String>(v7, v3);
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://kingfizh.alienz.tech/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Alienztech"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{number}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{status}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{principal}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{validator}"));
        let v8 = 0x2::display::new_with_fields<KingFizh>(&v1, v4, v6, arg1);
        0x2::display::update_version<KingFizh>(&mut v8);
        let (v9, v10) = 0x2::transfer_policy::new<KingFizh>(&v1, arg1);
        let v11 = v10;
        let v12 = v9;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<KingFizh>(&mut v12, &v11, 500, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<KingFizh>(&mut v12, &v11);
        let (v13, v14) = 0x2::kiosk::new(arg1);
        let v15 = v14;
        let v16 = v13;
        let v17 = 0x2::object::new(arg1);
        let v18 = 0x2::object::uid_to_inner(&v17);
        0x2::kiosk::set_owner_custom(&mut v16, &v15, 0x2::object::id_to_address(&v18));
        let v19 = PublisherKey{dummy_field: false};
        0x2::dynamic_field::add<PublisherKey, 0x2::package::Publisher>(&mut v17, v19, v1);
        let v20 = LegacyStateKey{dummy_field: false};
        0x2::dynamic_field::add<LegacyStateKey, 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::State>(&mut v17, v20, 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::new(v18, 0x2::object::id<0x2::display::Display<KingFizh>>(&v8), arg1));
        let v21 = SettingsV1{
            public_mint           : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::default_allocation(0),
            migration             : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::default_allocation(1),
            vip_migration         : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::default_allocation(2),
            treasury_wallet       : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::king(),
            hive_wallet           : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::hive(),
            subsidy_wallet        : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::subsidy(),
            willie_wallet         : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::willie(),
            royalty_willie_bps    : 3000,
            royalty_bps           : 500,
            validator             : @0x0,
            swap_pool             : 0x2::object::id_from_address(@0x0),
            lp_pool               : 0x2::object::id_from_address(@0x0),
            min_king_tokens       : 3000000,
            holder_start_ms       : 18446744073709551615,
            public_start_ms       : 18446744073709551615,
            early_access_ms       : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::early_access_ms(),
            migration_duration_ms : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::migration_duration_ms(),
            max_per_tx            : 25,
            emergency_pauses      : 0,
        };
        let v22 = Config{
            id           : 0x2::object::new(arg1),
            collection   : v18,
            code_version : 1,
            revision     : 0,
            upgrade_cap  : 0x1::option::none<0x2::object::ID>(),
            values       : 0x2::versioned::create<SettingsV1>(1, v21, arg1),
        };
        let v23 = 0x2::object::id<Config>(&v22);
        let v24 = ConfigCreated{
            config     : v23,
            collection : v18,
            version    : 1,
        };
        0x2::event::emit<ConfigCreated>(v24);
        let v25 = ConfigKey{dummy_field: false};
        0x2::dynamic_object_field::add<ConfigKey, Config>(&mut v17, v25, v22);
        let v26 = Collection{
            id                 : v17,
            config             : v23,
            version            : 1,
            name               : 0x1::string::utf8(b"King Fizh"),
            supply             : 2100,
            minted             : 0,
            burned             : 0,
            price              : 8000000000,
            stake_amount       : 2000000000,
            lp_amount          : 1500000000,
            fee_wallet         : @0x0,
            royalty_wallet     : @0x0,
            validator          : @0x0,
            swap_pool          : 0x2::object::id_from_address(@0x0),
            lp_pool            : 0x2::object::id_from_address(@0x0),
            vault              : 0x2::object::id_from_address(@0x0),
            policy             : 0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(&v12),
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
        let v27 = CollectionCreated{
            collection : v18,
            policy     : 0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(&v12),
            graveyard  : 0x2::object::id<0x2::kiosk::Kiosk>(&v16),
            supply     : 2100,
            price      : 8000000000,
        };
        0x2::event::emit<CollectionCreated>(v27);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<KingFizh>>(v12);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v16);
        0x2::transfer::share_object<Collection>(v26);
        0x2::transfer::public_transfer<0x2::display::Display<KingFizh>>(v8, v0);
        let v28 = AdminCap{
            id         : 0x2::object::new(arg1),
            collection : v18,
        };
        0x2::transfer::transfer<AdminCap>(v28, v0);
        let v29 = SeedCapIssued{
            collection : v18,
            to         : v0,
        };
        0x2::event::emit<SeedCapIssued>(v29);
        let v30 = SeedCap{
            id         : 0x2::object::new(arg1),
            collection : v18,
        };
        0x2::transfer::transfer<SeedCap>(v30, v0);
    }

    public fun is_active(arg0: &KingFizh) : bool {
        arg0.status == 0x1::string::utf8(b"Active")
    }

    public fun is_minted(arg0: &Collection, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.items, arg1)
    }

    public fun is_vip(arg0: &Collection, arg1: address) : bool {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::is_vip(legacy_state(arg0), arg1)
    }

    public fun issue_seed_cap(arg0: &AdminCap, arg1: &Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
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

    public fun item_validator(arg0: &KingFizh) : address {
        arg0.validator
    }

    public fun item_vault(arg0: &KingFizh) : 0x2::object::ID {
        arg0.vault
    }

    public fun legacy_archive(arg0: &Collection) : 0x2::object::ID {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::archive_id(legacy_state(arg0))
    }

    public fun legacy_reserved_count(arg0: &Collection) : u64 {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::reserved_count(legacy_state(arg0))
    }

    fun legacy_state(arg0: &Collection) : &0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::State {
        let v0 = LegacyStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<LegacyStateKey, 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::State>(&arg0.id, v0)
    }

    fun legacy_state_mut(arg0: &mut Collection) : &mut 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::State {
        let v0 = LegacyStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LegacyStateKey, 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::State>(&mut arg0.id, v0)
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
        25
    }

    public fun media(arg0: &KingFizh) : 0x1::string::String {
        arg0.media
    }

    public fun migrate_collection(arg0: &AdminCap, arg1: &mut Collection) {
        assert_admin(arg0, arg1);
        assert!(configuration(arg1).code_version == 1, 100);
        assert!(arg1.version < 1, 121);
        let v0 = Migrated{
            object : 0x2::object::id<Collection>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun migrate_from_kiosk<T0: store + key, T1>(arg0: &mut Collection, arg1: &mut Vault<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::Archive, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg10: 0x2::object::ID, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::assert_authentic<T0>();
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg7, 0x2::kiosk::list_with_purchase_cap<T0>(arg7, arg8, arg10, 0, arg16), 0x2::coin::zero<0x2::sui::SUI>(arg16));
        let v2 = v0;
        let (v3, v4, v5) = prepare_migration<T0, T1>(arg0, arg1, arg2, arg3, &v2, arg11, arg13, arg14, arg15, arg16);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::archive_with_policy<T0>(legacy_state(arg0), arg4, 0x2::object::id<Collection>(arg0), v2, v5, v1, arg9, arg12, arg16);
        0x2::kiosk::lock<KingFizh>(arg5, arg6, arg3, v3);
        send_sui(v4, 0x2::tx_context::sender(arg16));
    }

    public fun migrate_in_kiosk<T0: store + key, T1>(arg0: &mut Collection, arg1: &mut Vault<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::Archive, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg8: 0x2::object::ID, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::assert_authentic<T0>();
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg5, 0x2::kiosk::list_with_purchase_cap<T0>(arg5, arg6, arg8, 0, arg14), 0x2::coin::zero<0x2::sui::SUI>(arg14));
        let v2 = v0;
        let (v3, v4, v5) = prepare_migration<T0, T1>(arg0, arg1, arg2, arg3, &v2, arg9, arg11, arg12, arg13, arg14);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::archive_with_policy<T0>(legacy_state(arg0), arg4, 0x2::object::id<Collection>(arg0), v2, v5, v1, arg7, arg10, arg14);
        0x2::kiosk::lock<KingFizh>(arg5, arg6, arg3, v3);
        send_sui(v4, 0x2::tx_context::sender(arg14));
    }

    public fun migrate_to_kiosk<T0: store + key, T1>(arg0: &mut Collection, arg1: &mut Vault<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::Archive, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: T0, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = prepare_migration<T0, T1>(arg0, arg1, arg2, arg3, &arg7, arg8, arg9, arg10, arg11, arg12);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::archive<T0>(legacy_state(arg0), arg4, 0x2::object::id<Collection>(arg0), arg7, v2, arg12);
        0x2::kiosk::lock<KingFizh>(arg5, arg6, arg3, v0);
        send_sui(v1, 0x2::tx_context::sender(arg12));
    }

    public fun migrate_to_new_kiosk<T0: store + key, T1>(arg0: &mut Collection, arg1: &mut Vault<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::Archive, arg5: T0, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        migrate_to_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, v4, &v2, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg10));
    }

    public fun migrate_to_personal_kiosk<T0: store + key, T1>(arg0: &mut Collection, arg1: &mut Vault<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::Archive, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: T0, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg6);
        let v2 = v0;
        migrate_to_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v2, arg7, arg8, arg9, arg10, arg11, arg12);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg6, v2, v1);
    }

    public fun migrate_vault<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        assert!(arg0.collection == arg1.collection, 150);
        assert!(arg1.version < 1, 121);
        let v0 = Migrated{
            object : 0x2::object::id<Vault<T0>>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun migrated_legacy(arg0: &Collection, arg1: 0x2::object::ID) : bool {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::has_migrated(legacy_state(arg0), arg1)
    }

    public fun migration_end_ms(arg0: &Collection) : u64 {
        arg0.public_start_ms + settings(arg0).migration_duration_ms
    }

    public fun migration_price_for_wallet(arg0: &Collection, arg1: address) : u64 {
        let v0 = if (is_vip(arg0, arg1)) {
            2
        } else {
            1
        };
        let v1 = route_allocation(arg0, v0);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_price(&v1)
    }

    public fun migration_reserved(arg0: &Collection, arg1: u64) : bool {
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::is_reserved(legacy_state(arg0), arg1)
    }

    public fun min_holder_balance(arg0: &Collection) : u64 {
        arg0.min_holder_balance
    }

    fun mint_drawn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x1::option::Option<u64>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::random::RandomGenerator, arg17: &mut 0x2::tx_context::TxContext) {
        check_window(arg0, 0x2::clock::timestamp_ms(arg15), arg9);
        check_public_inventory(arg0, 0x2::clock::timestamp_ms(arg15));
        assert!(arg11 >= 1 && arg11 <= 25, 116);
        assert!(arg11 <= arg0.supply - arg0.drawn, 102);
        let (v0, v1, v2, v3) = pay_and_lock<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, arg12, arg13, arg14, arg15, arg17);
        let v4 = v0;
        let v5 = 0;
        while (v5 < arg11) {
            let v6 = draw(arg0, arg16);
            let v7 = forge<T0>(arg0, arg1, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v4), v6, v1, false, arg17);
            0x2::kiosk::lock<KingFizh>(arg7, arg8, arg6, v7);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v4);
        credit_slack<T0>(arg1, v3);
        send_sui(v2, 0x2::tx_context::sender(arg17));
    }

    entry fun mint_holder_to_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &0x2::random::Random, arg18: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg15);
        let v0 = 0x2::random::new_generator(arg17, arg18);
        let v1 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::some<u64>(0x2::coin::value<T0>(&arg9)), arg10, arg11, arg12, arg13, arg14, arg16, v1, arg18);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg9, 0x2::tx_context::sender(arg18));
    }

    entry fun mint_holder_to_new_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: u64, arg12: u128, arg13: u64, arg14: &0x2::clock::Clock, arg15: &0x2::random::Random, arg16: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg13);
        let v0 = 0x2::random::new_generator(arg15, arg16);
        let (v1, v2) = 0x2::kiosk::new(arg16);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, &v3, 0x1::option::some<u64>(0x2::coin::value<T0>(&arg7)), arg8, arg9, arg10, arg11, arg12, arg14, v6, arg16);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x2::tx_context::sender(arg16));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg16));
    }

    entry fun mint_holder_to_personal_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: u64, arg14: u128, arg15: u64, arg16: &0x2::clock::Clock, arg17: &0x2::random::Random, arg18: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg15);
        let v0 = 0x2::random::new_generator(arg17, arg18);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg8);
        let v3 = v1;
        let v4 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v3, 0x1::option::some<u64>(0x2::coin::value<T0>(&arg9)), arg10, arg11, arg12, arg13, arg14, arg16, v4, arg18);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg9, 0x2::tx_context::sender(arg18));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg8, v3, v2);
    }

    public fun mint_launch_reserved<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg9);
        check_vault<T0>(arg1);
        assert!(arg0.mint_open, 101);
        assert_action(arg0, 0);
        assert_configured(arg0);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0) && 0x2::object::id<Vault<T0>>(arg1) == arg0.vault, 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg3) == arg0.policy, 118);
        assert!(0x2::clock::timestamp_ms(arg10) >= arg0.holder_start_ms, 135);
        let v0 = LaunchReservationKey{index: arg7};
        assert!(0x2::dynamic_field::exists<LaunchReservationKey>(&arg0.id, v0), 129);
        assert!(*0x2::table::borrow<u64, address>(&arg0.reservations, arg7) == 0x2::tx_context::sender(arg11), 130);
        let v1 = arg0.stake_amount;
        assert!(v1 <= arg8, 104);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v1, 103);
        0x2::table::remove<u64, address>(&mut arg0.reservations, arg7);
        let v2 = LaunchReservationKey{index: arg7};
        0x2::dynamic_field::remove<LaunchReservationKey, address>(&mut arg0.id, v2);
        let v3 = 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, v1, arg11), arg0.validator, arg11);
        let v4 = forge<T0>(arg0, arg1, v3, arg7, 18446744073709551615, true, arg11);
        0x2::kiosk::lock<KingFizh>(arg4, arg5, arg3, v4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        } else {
            send_sui(arg6, 0x2::tx_context::sender(arg11));
        };
    }

    public fun mint_open(arg0: &Collection) : bool {
        arg0.mint_open
    }

    fun mint_reserved<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg14) >= arg0.holder_start_ms, 135);
        assert!(0x2::table::contains<u64, address>(&arg0.reservations, arg10), 129);
        assert!(*0x2::table::borrow<u64, address>(&arg0.reservations, arg10) == 0x2::tx_context::sender(arg15), 130);
        0x2::table::remove<u64, address>(&mut arg0.reservations, arg10);
        let (v0, v1, v2, v3) = pay_and_lock<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9, 1, arg11, arg12, arg13, arg14, arg15);
        let v4 = v0;
        let v5 = forge<T0>(arg0, arg1, 0x1::vector::pop_back<0x3::staking_pool::StakedSui>(&mut v4), arg10, v1, true, arg15);
        0x2::kiosk::lock<KingFizh>(arg7, arg8, arg6, v5);
        0x1::vector::destroy_empty<0x3::staking_pool::StakedSui>(v4);
        credit_slack<T0>(arg1, v3);
        send_sui(v2, 0x2::tx_context::sender(arg15));
    }

    entry fun mint_reserved_to_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg14);
        mint_reserved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16);
    }

    entry fun mint_reserved_to_new_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg12);
        let (v0, v1) = 0x2::kiosk::new(arg14);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint_reserved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v4, &v2, arg7, arg8, arg9, arg10, arg11, arg13, arg14);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg14));
    }

    entry fun mint_reserved_to_personal_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg14);
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg8);
        let v2 = v0;
        mint_reserved<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v2, arg9, arg10, arg11, arg12, arg13, arg15, arg16);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg8, v2, v1);
    }

    entry fun mint_to_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg14);
        let v0 = 0x2::random::new_generator(arg16, arg17);
        let v1 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<u64>(), arg9, arg10, arg11, arg12, arg13, arg15, v1, arg17);
    }

    entry fun mint_to_new_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x2::random::Random, arg15: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg12);
        let v0 = 0x2::random::new_generator(arg14, arg15);
        let (v1, v2) = 0x2::kiosk::new(arg15);
        let v3 = v2;
        let v4 = v1;
        let v5 = &mut v4;
        let v6 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, &v3, 0x1::option::none<u64>(), arg7, arg8, arg9, arg10, arg11, arg13, v6, arg15);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg15));
    }

    entry fun mint_to_personal_kiosk<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        assert_revision(arg0, arg14);
        let v0 = 0x2::random::new_generator(arg16, arg17);
        let (v1, v2) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg8);
        let v3 = v1;
        let v4 = &mut v0;
        mint_drawn<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &v3, 0x1::option::none<u64>(), arg9, arg10, arg11, arg12, arg13, arg15, v4, arg17);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg8, v3, v2);
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun number(arg0: &KingFizh) : u64 {
        arg0.number
    }

    fun pay_and_lock<T0>(arg0: &Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (vector<0x3::staking_pool::StakedSui>, u64, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert!(arg0.mint_open, 101);
        assert_action(arg0, 0);
        assert_configured(arg0);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0), 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg6) == arg0.policy, 118);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4);
        assert!(v0 == arg0.swap_pool && v0 == arg0.lp_pool, 105);
        assert!(arg0.price <= arg9, 104);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= arg0.price * arg8, 103);
        let v1 = arg0.lp_amount * arg8;
        assert!(arg10 > 0 && arg10 < v1, 106);
        let v2 = 0x2::tx_context::sender(arg13);
        let (v3, v4) = route_payment(arg0, arg7, 0, arg8, arg9, arg13);
        let v5 = v3;
        let v6 = 0x1::vector::empty<0x3::staking_pool::StakedSui>();
        let v7 = 0;
        while (v7 < arg8) {
            0x1::vector::push_back<0x3::staking_pool::StakedSui>(&mut v6, 0x3::sui_system::request_add_stake_non_entry(arg2, 0x2::coin::split<0x2::sui::SUI>(&mut v5, arg0.stake_amount, arg13), arg0.validator, arg13));
            v7 = v7 + 1;
        };
        let v8 = 0x2::coin::split<0x2::sui::SUI>(&mut v5, v1, arg13);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        let (v9, v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, false, true, arg10, 79226673515401279992447579055, arg12);
        let v12 = v11;
        let v13 = v9;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v10);
        let v14 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v14, arg13)), v12);
        let v15 = 0x2::balance::value<T0>(&v13);
        let (v16, v17) = full_range_ticks(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, 0x2::sui::SUI>(arg4));
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0x2::sui::SUI>(arg3, arg4, v16, v17, arg13);
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0x2::sui::SUI>(arg3, arg4, &mut v18, v15, true, arg12);
        let (v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0x2::sui::SUI>(&v19);
        assert!(v20 == v15, 107);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v8) >= v21, 103);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0x2::sui::SUI>(arg3, arg4, v13, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v21, arg13)), v19);
        assert!(((v14 + v21) as u128) * 10000 >= (v1 as u128) * ((10000 - 1000) as u128), 139);
        let v22 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v18);
        assert!(v22 >= arg11, 108);
        let v23 = arg1.positions;
        0x2::table::add<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.proofs, v23, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg5, v18, arg13));
        let v24 = PositionPoolKey{position: v23};
        0x2::dynamic_field::add<PositionPoolKey, 0x2::object::ID>(&mut arg1.id, v24, v0);
        arg1.positions = v23 + 1;
        let v25 = PositionLocked{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            position  : v23,
            ones      : arg8,
            minter    : v2,
            liquidity : v22,
            swap_in   : v14,
            lp_sui    : v14 + v21,
            lp_a      : v15,
            fee       : (arg0.price - arg0.stake_amount - arg0.lp_amount) * arg8,
        };
        0x2::event::emit<PositionLocked>(v25);
        (v6, v23, v4, 0x2::coin::into_balance<0x2::sui::SUI>(v8))
    }

    fun pay_pot<T0>(arg0: &mut Vault<T0>, arg1: &mut KingFizh, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = (((arg0.acc_a - arg1.debt_a) / 1000000000000) as u64);
        let v1 = (((arg0.acc_b - arg1.debt_b) / 1000000000000) as u64);
        arg1.debt_a = arg0.acc_a;
        arg1.debt_b = arg0.acc_b;
        arg0.paid_a = arg0.paid_a + v0;
        arg0.paid_b = arg0.paid_b + v1;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot_a, v0), arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot_b, v1), arg2))
    }

    public fun pending<T0>(arg0: &Vault<T0>, arg1: &KingFizh) : (u64, u64) {
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

    fun prepare_migration<T0: store + key, T1>(arg0: &mut Collection, arg1: &mut Vault<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: &T0, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (KingFizh, 0x2::coin::Coin<0x2::sui::SUI>, u64) {
        assert_revision(arg0, arg7);
        let v0 = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::index<T0>(legacy_state(arg0), arg4);
        prepare_migration_at_index<T1>(arg0, arg1, arg2, arg3, 0x2::object::id<T0>(arg4), v0, arg5, arg6, arg8, arg9)
    }

    fun prepare_migration_at_index<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg4: 0x2::object::ID, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (KingFizh, 0x2::coin::Coin<0x2::sui::SUI>, u64) {
        let v0 = validate_migration<T0>(arg0, arg1, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg8), 0x2::tx_context::sender(arg9));
        let (v1, v2) = route_payment(arg0, arg6, v0, 1, arg7, arg9);
        let v3 = v1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v3) == arg0.stake_amount, 113);
        let v4 = 0x3::sui_system::request_add_stake_non_entry(arg2, v3, arg0.validator, arg9);
        let v5 = legacy_state_mut(arg0);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::record(v5, arg4, arg5);
        let v6 = forge<T0>(arg0, arg1, v4, arg5, 18446744073709551615, true, arg9);
        let v7 = route_allocation(arg0, v0);
        let v8 = LegacyMigrated{
            old    : arg4,
            item   : 0x2::object::id<KingFizh>(&v6),
            index  : arg5,
            holder : 0x2::tx_context::sender(arg9),
            price  : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_price(&v7),
            vip    : v0 == 2,
        };
        0x2::event::emit<LegacyMigrated>(v8);
        (v6, v2, arg5)
    }

    public fun price(arg0: &Collection) : u64 {
        arg0.price
    }

    public fun principal(arg0: &KingFizh) : u64 {
        arg0.principal
    }

    public fun public_remaining(arg0: &Collection) : u64 {
        arg0.supply - arg0.drawn
    }

    public fun public_start_ms(arg0: &Collection) : u64 {
        arg0.public_start_ms
    }

    public fun register_upgrade_cap(arg0: &AdminCap, arg1: &mut Collection, arg2: &0x2::package::UpgradeCap) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = configuration_mut(arg1);
        if (0x1::option::is_some<0x2::object::ID>(&v0.upgrade_cap)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v0.upgrade_cap) == 0x2::object::id<0x2::package::UpgradeCap>(arg2), 149);
        } else {
            let v1 = if (0x2::package::version(arg2) == 1) {
                let v2 = 0x2::package::upgrade_package(arg2);
                0x2::object::id_to_address(&v2) == 0x1::type_name::original_id<KingFizh>()
            } else {
                false
            };
            assert!(v1, 149);
            v0.upgrade_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg2));
        };
    }

    public fun release_expired_legacy(arg0: &mut Collection, arg1: vector<u64>, arg2: &0x2::clock::Clock) {
        check_collection(arg0);
        assert!(0x1::vector::length<u64>(&arg1) > 0 && 0x1::vector::length<u64>(&arg1) <= 100, 116);
        let v0 = arg0.public_start_ms;
        0x1::vector::reverse<u64>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg1);
            let v3 = settings(arg0).migration_duration_ms;
            let v4 = legacy_state_mut(arg0);
            0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::release_window(v4, v2, 0x2::clock::timestamp_ms(arg2), v0, v3);
            assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.items, v2), 113);
            0x1::vector::push_back<u16>(&mut arg0.pool, (v2 as u16));
            arg0.drawn = arg0.drawn - 1;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
    }

    fun remove_available(arg0: &mut Collection, arg1: u64) {
        let v0 = if (0x2::table::contains<u64, u64>(&arg0.moved, arg1)) {
            0x2::table::remove<u64, u64>(&mut arg0.moved, arg1)
        } else {
            arg1 - 1
        };
        assert!(v0 < 0x1::vector::length<u16>(&arg0.pool) && (*0x1::vector::borrow<u16>(&arg0.pool, v0) as u64) == arg1, 122);
        let v1 = 0x1::vector::length<u16>(&arg0.pool) - 1;
        if (v0 != v1) {
            let v2 = (*0x1::vector::borrow<u16>(&arg0.pool, v1) as u64);
            if (0x2::table::contains<u64, u64>(&arg0.moved, v2)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.moved, v2) = v0;
            } else {
                0x2::table::add<u64, u64>(&mut arg0.moved, v2, v0);
            };
        };
        0x1::vector::swap_remove<u16>(&mut arg0.pool, v0);
    }

    public fun reservation(arg0: &Collection, arg1: u64) : 0x1::option::Option<address> {
        if (0x2::table::contains<u64, address>(&arg0.reservations, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<u64, address>(&arg0.reservations, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun reserve(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg1.seeded == arg1.supply, 125);
        assert!(arg1.minted == 0 && !0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::frozen(legacy_state(arg1)), 131);
        assert!(!arg1.mint_open && arg1.reserved_total < 2, 131);
        assert!(arg2 >= 1 && arg2 <= arg1.supply, 122);
        assert!(!0x2::table::contains<u64, address>(&arg1.reservations, arg2), 132);
        assert!(arg3 != @0x0, 122);
        remove_available(arg1, arg2);
        arg1.drawn = arg1.drawn + 1;
        arg1.reserved_total = arg1.reserved_total + 1;
        0x2::table::add<u64, address>(&mut arg1.reservations, arg2, arg3);
        let v0 = Reserved{
            collection : 0x2::object::id<Collection>(arg1),
            index      : arg2,
            minter     : arg3,
        };
        0x2::event::emit<Reserved>(v0);
    }

    public fun reserve_after_launch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<address>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg1.seeded == arg1.supply, 125);
        let v0 = if (0x1::vector::length<u64>(&arg2) > 0) {
            if (0x1::vector::length<u64>(&arg2) <= 50) {
                0x1::vector::length<u64>(&arg2) == 0x1::vector::length<address>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 116);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = *0x1::vector::borrow<address>(&arg3, v1);
            let v4 = if (v2 >= 1) {
                if (v2 <= arg1.supply) {
                    v3 != @0x0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v4, 122);
            assert!(!0x2::table::contains<u64, address>(&arg1.reservations, v2), 132);
            assert!(!0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::is_reserved(legacy_state(arg1), v2), 122);
            remove_available(arg1, v2);
            arg1.drawn = arg1.drawn + 1;
            arg1.reserved_total = arg1.reserved_total + 1;
            0x2::table::add<u64, address>(&mut arg1.reservations, v2, v3);
            let v5 = LaunchReservationKey{index: v2};
            0x2::dynamic_field::add<LaunchReservationKey, address>(&mut arg1.id, v5, v3);
            let v6 = Reserved{
                collection : 0x2::object::id<Collection>(arg1),
                index      : v2,
                minter     : v3,
            };
            0x2::event::emit<Reserved>(v6);
            v1 = v1 + 1;
        };
    }

    public fun reserve_legacy_batch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = if (arg1.seeded == arg1.supply) {
            if (!arg1.mint_open) {
                arg1.minted == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 131);
        assert!(0x1::vector::length<u64>(&arg2) > 0 && 0x1::vector::length<u64>(&arg2) <= 100, 116);
        0x1::vector::reverse<u64>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            let v3 = if (v2 > 0) {
                if (v2 <= arg1.supply) {
                    !0x2::table::contains<u64, address>(&arg1.reservations, v2)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 122);
            let v4 = legacy_state_mut(arg1);
            0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::reserve(v4, v2);
            remove_available(arg1, v2);
            arg1.drawn = arg1.drawn + 1;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg2);
    }

    public fun reserved_total(arg0: &Collection) : u64 {
        arg0.reserved_total
    }

    fun route_allocation(arg0: &Collection, arg1: u8) : 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::Allocation {
        let v0 = settings(arg0);
        if (arg1 == 0) {
            v0.public_mint
        } else if (arg1 == 1) {
            v0.migration
        } else {
            assert!(arg1 == 2, 123);
            v0.vip_migration
        }
    }

    fun route_payment(arg0: &Collection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = settings(arg0);
        assert!(arg3 <= v0.max_per_tx, 116);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::pay_allocated(arg1, route_allocation(arg0, arg2), arg2, arg3, arg4, v0.treasury_wallet, v0.hive_wallet, v0.subsidy_wallet, arg5)
    }

    public fun royalty_wallet(arg0: &Collection) : address {
        arg0.royalty_wallet
    }

    public fun scale() : u128 {
        1000000000000
    }

    public fun seal_legacy_inventory(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        assert_admin(arg0, arg1);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::seal_inventory(legacy_state_mut(arg1), arg2);
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
            assert!(v4 <= 15, 128);
            let (v5, v6) = build_attributes(&arg4, &arg5, v2, v4);
            let v7 = if (v4 < 3) {
                15 - v4
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

    public fun set_access_limits(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: u64) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg3 <= 25
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 123);
        arg1.min_holder_balance = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::minimum_king_for(legacy_state(arg1), arg2);
        let v1 = settings_mut(arg1);
        v1.min_king_tokens = arg2;
        v1.max_per_tx = arg3;
        config_changed(arg1, 5);
    }

    public fun set_economics(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::checked_allocation(arg2, 0);
        let v1 = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::checked_allocation(arg3, 1);
        let v2 = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::checked_allocation(arg4, 2);
        assert!(0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_stake(&v0) == 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_stake(&v1) && 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_stake(&v0) == 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_stake(&v2), 123);
        arg1.price = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_price(&v0);
        arg1.stake_amount = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_stake(&v0);
        arg1.lp_amount = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::terms::allocation_lp(&v0);
        let v3 = settings_mut(arg1);
        v3.public_mint = v0;
        v3.migration = v1;
        v3.vip_migration = v2;
        config_changed(arg1, 0);
    }

    public fun set_emergency_pauses(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg2 <= 127, 123);
        let v0 = settings_mut(arg1);
        v0.emergency_pauses = arg2;
        config_changed(arg1, 6);
    }

    public fun set_fee_wallet(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg2 != @0x0, 123);
        let v0 = FeeWalletSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.fee_wallet,
            to         : arg2,
        };
        0x2::event::emit<FeeWalletSet>(v0);
        arg1.fee_wallet = arg2;
        let v1 = settings_mut(arg1);
        v1.hive_wallet = arg2;
        config_changed(arg1, 1);
    }

    public fun set_king_metadata<T0>(arg0: &AdminCap, arg1: &mut Collection, arg2: &0x2::coin::CoinMetadata<T0>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert_king<T0>();
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::set_king_decimals(legacy_state_mut(arg1), 0x2::coin::get_decimals<T0>(arg2));
    }

    public fun set_launch_terms(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: u64, arg4: u64) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(!arg1.mint_open && arg1.minted == 0, 131);
        let v0 = if (arg3 > 0) {
            if (arg2 >= arg3) {
                if (arg4 > 0) {
                    arg2 <= 18446744073709551615 - arg4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 137);
        let v1 = 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::minimum_king_for(legacy_state(arg1), settings(arg1).min_king_tokens);
        let v2 = settings_mut(arg1);
        v2.early_access_ms = arg3;
        v2.migration_duration_ms = arg4;
        set_schedule_internal(arg1, arg2 - arg3, arg2, v1);
    }

    public fun set_mint_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        if (arg2) {
            assert_configured(arg1);
            assert!(arg1.seeded == arg1.supply, 125);
            assert!(arg1.public_start_ms != 18446744073709551615, 137);
            assert!(has_display_v2(arg1), 143);
            if (!0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::frozen(legacy_state(arg1))) {
                let v0 = legacy_state_mut(arg1);
                0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::seal_configuration(v0);
            };
        };
        arg1.mint_open = arg2;
        let v1 = MintOpenSet{
            collection : 0x2::object::id<Collection>(arg1),
            open       : arg2,
        };
        0x2::event::emit<MintOpenSet>(v1);
    }

    public fun set_pools(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        assert!(arg2 == arg3 && 0x2::object::id_to_address(&arg2) != @0x0, 105);
        set_pools_internal(arg1, arg2, arg3);
    }

    fun set_pools_internal(arg0: &mut Collection, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        check_collection(arg0);
        let v0 = PoolsSet{
            collection : 0x2::object::id<Collection>(arg0),
            swap_from  : arg0.swap_pool,
            swap_to    : arg1,
            lp_from    : arg0.lp_pool,
            lp_to      : arg2,
        };
        0x2::event::emit<PoolsSet>(v0);
        arg0.swap_pool = arg1;
        arg0.lp_pool = arg2;
        let v1 = settings_mut(arg0);
        v1.swap_pool = arg1;
        v1.lp_pool = arg2;
        config_changed(arg0, 3);
    }

    public fun set_recipients(arg0: &AdminCap, arg1: &mut Collection, arg2: address, arg3: address, arg4: address, arg5: address) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = if (arg2 != @0x0) {
            if (arg3 != @0x0) {
                if (arg4 != @0x0) {
                    arg5 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 123);
        arg1.fee_wallet = arg3;
        arg1.royalty_wallet = arg2;
        let v1 = settings_mut(arg1);
        v1.treasury_wallet = arg2;
        v1.hive_wallet = arg3;
        v1.subsidy_wallet = arg4;
        v1.willie_wallet = arg5;
        config_changed(arg1, 1);
    }

    public fun set_royalty(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::transfer_policy::TransferPolicy<KingFizh>, arg3: u16, arg4: u64) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = if (arg3 > 0) {
            if (arg3 <= 1000) {
                arg4 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 141);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg2) == arg1.policy, 118);
        0x2::transfer_policy::remove_rule<KingFizh, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Config>(arg2, &arg1.policy_cap);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<KingFizh>(arg2, &arg1.policy_cap, arg3, arg4);
        let v1 = settings_mut(arg1);
        v1.royalty_bps = arg3;
        config_changed(arg1, 4);
        let v2 = RoyaltySet{
            collection : 0x2::object::id<Collection>(arg1),
            bps        : arg3,
            min        : arg4,
        };
        0x2::event::emit<RoyaltySet>(v2);
    }

    public fun set_royalty_split(arg0: &AdminCap, arg1: &mut Collection, arg2: u16) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg2 > 0 && arg2 < 10000, 141);
        let v0 = settings_mut(arg1);
        v0.royalty_willie_bps = arg2;
        config_changed(arg1, 4);
    }

    public fun set_royalty_wallet(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg2 != @0x0, 123);
        let v0 = RoyaltyWalletSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.royalty_wallet,
            to         : arg2,
        };
        0x2::event::emit<RoyaltyWalletSet>(v0);
        arg1.royalty_wallet = arg2;
        let v1 = settings_mut(arg1);
        v1.treasury_wallet = arg2;
        config_changed(arg1, 1);
    }

    public fun set_schedule(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: u64, arg4: u64) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(!arg1.mint_open && arg1.minted == 0, 131);
        assert!(arg2 + settings(arg1).early_access_ms == arg3, 137);
        assert!(arg4 == 0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::minimum_king_for(legacy_state(arg1), settings(arg1).min_king_tokens), 137);
        set_schedule_internal(arg1, arg2, arg3, arg4);
    }

    fun set_schedule_internal(arg0: &mut Collection, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg2 && arg3 > 0, 137);
        arg0.holder_start_ms = arg1;
        arg0.public_start_ms = arg2;
        arg0.min_holder_balance = arg3;
        let v0 = settings_mut(arg0);
        v0.holder_start_ms = arg1;
        v0.public_start_ms = arg2;
        config_changed(arg0, 5);
        let v1 = ScheduleSet{
            collection         : 0x2::object::id<Collection>(arg0),
            holder_start_ms    : arg1,
            public_start_ms    : arg2,
            min_holder_balance : arg3,
        };
        0x2::event::emit<ScheduleSet>(v1);
    }

    public fun set_sweep<T0>(arg0: &AdminCap, arg1: &Collection, arg2: &mut Vault<T0>, arg3: bool, arg4: u64) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        check_vault<T0>(arg2);
        assert!(arg2.collection == 0x2::object::id<Collection>(arg1) && 0x2::object::id<Vault<T0>>(arg2) == arg1.vault, 110);
        assert!(arg4 <= 1000, 120);
        arg2.sweep_open = arg3;
        arg2.sweep_fee_bps = arg4;
        let v0 = SweepSet{
            vault   : 0x2::object::id<Vault<T0>>(arg2),
            open    : arg3,
            fee_bps : arg4,
        };
        0x2::event::emit<SweepSet>(v0);
    }

    public fun set_validator(arg0: &AdminCap, arg1: &mut Collection, arg2: address) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        assert!(arg2 != @0x0, 123);
        let v0 = ValidatorSet{
            collection : 0x2::object::id<Collection>(arg1),
            from       : arg1.validator,
            to         : arg2,
        };
        0x2::event::emit<ValidatorSet>(v0);
        arg1.validator = arg2;
        let v1 = settings_mut(arg1);
        v1.validator = arg2;
        config_changed(arg1, 2);
    }

    public fun set_vip_batch(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<address>, arg3: bool) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        let v0 = legacy_state_mut(arg1);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::set_vip(v0, arg2, arg3);
        config_changed(arg1, 7);
    }

    fun settings(arg0: &Collection) : &SettingsV1 {
        let v0 = configuration(arg0);
        let v1 = if (v0.code_version == 1) {
            if (v0.collection == 0x2::object::id<Collection>(arg0)) {
                0x2::object::id<Config>(v0) == arg0.config
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 100);
        0x2::versioned::load_value<SettingsV1>(&v0.values)
    }

    fun settings_mut(arg0: &mut Collection) : &mut SettingsV1 {
        0x2::versioned::load_value_mut<SettingsV1>(&mut configuration_mut(arg0).values)
    }

    fun settle_burn<T0>(arg0: &mut Collection, arg1: &mut Vault<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<KingFizh>, arg3: &mut 0x2::kiosk::Kiosk, arg4: KingFizh, arg5: 0x2::transfer_policy::TransferRequest<KingFizh>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
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
        let v6 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<KingFizh>(arg2, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KingFizh>(arg2, &mut arg5, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg6, v6), arg7));
        0x2::kiosk::lock<KingFizh>(arg3, &arg0.graveyard_cap, arg2, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KingFizh>(&mut arg5, arg3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<KingFizh>(arg2, arg5);
        let v10 = Burned{
            item        : 0x2::object::id<KingFizh>(&arg4),
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

    public fun status(arg0: &KingFizh) : 0x1::string::String {
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
        assert_action(arg0, 5);
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
            let v5 = PositionPoolKey{position: v4};
            assert!(*0x2::dynamic_field::borrow<PositionPoolKey, 0x2::object::ID>(&arg1.id, v5) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg4), 105);
            let (v6, v7) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, 0x2::sui::SUI>(arg2, arg3, arg4, 0x2::table::borrow_mut<u64, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.proofs, v4), arg6);
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v6));
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::coin::into_balance<0x2::sui::SUI>(v7));
            v3 = v3 + 1;
        };
        let (v8, v9) = deposit<T0>(arg1, v1, v2, arg6);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x2::tx_context::sender(arg6);
        let v13 = Swept{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            caller    : v12,
            positions : v0,
            amount_a  : 0x2::balance::value<T0>(&v1),
            amount_b  : 0x2::balance::value<0x2::sui::SUI>(&v2),
            caller_a  : 0x2::coin::value<T0>(&v11),
            caller_b  : 0x2::coin::value<0x2::sui::SUI>(&v10),
            live      : arg1.live,
        };
        0x2::event::emit<Swept>(v13);
        send<T0>(v11, v12);
        send_sui(v10, v12);
    }

    public fun sweep_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.sweep_fee_bps
    }

    public fun sweep_open<T0>(arg0: &Vault<T0>) : bool {
        arg0.sweep_open
    }

    public fun sync_display_v2(arg0: &AdminCap, arg1: &Collection, arg2: &0x2::display::Display<KingFizh>, arg3: &mut 0x2::display_registry::Display<KingFizh>) {
        assert_admin(arg0, arg1);
        check_collection(arg1);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::assert_media_ready(legacy_state(arg1), 0x2::object::id<0x2::display::Display<KingFizh>>(arg2));
        assert_v1_fields(arg2);
        assert!(has_display_v2(arg1), 143);
        let v0 = DisplayCapKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<DisplayCapKey, 0x2::display_registry::DisplayCap<KingFizh>>(&arg1.id, v0);
        assert!(0x2::display_registry::cap_id<KingFizh>(arg3) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::display_registry::DisplayCap<KingFizh>>(v1)), 144);
        copy_display_fields(arg2, arg3, v1);
    }

    fun take_out(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (KingFizh, 0x2::transfer_policy::TransferRequest<KingFizh>) {
        0x2::kiosk::purchase_with_cap<KingFizh>(arg0, 0x2::kiosk::list_with_purchase_cap<KingFizh>(arg0, arg1, arg2, 0, arg3), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public fun traits(arg0: &Collection, arg1: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        0x2::table::borrow<u64, ItemData>(&arg0.registry, arg1).attributes
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        let v0 = AdminTransferred{to: arg1};
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun transfer_seed_cap(arg0: SeedCap, arg1: address) {
        0x2::transfer::transfer<SeedCap>(arg0, arg1);
    }

    fun validate_migration<T0>(arg0: &Collection, arg1: &Vault<T0>, arg2: &0x2::transfer_policy::TransferPolicy<KingFizh>, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: address) : u8 {
        check_collection(arg0);
        check_vault<T0>(arg1);
        assert_configured(arg0);
        assert!(arg0.mint_open, 101);
        assert_action(arg0, 1);
        assert!(arg1.collection == 0x2::object::id<Collection>(arg0) && 0x2::object::id<Vault<T0>>(arg1) == arg0.vault, 110);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<KingFizh>>(arg2) == arg0.policy, 118);
        let v0 = if (arg4 > 0) {
            if (arg4 <= arg0.supply) {
                !0x2::table::contains<u64, 0x2::object::ID>(&arg0.items, arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 122);
        0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::check_claim_window(legacy_state(arg0), arg3, arg4, arg5, arg0.public_start_ms, settings(arg0).migration_duration_ms);
        if (0xee4752a0e4e8d236aecfc3e0dec4d5c69dd92cfe7ecc49631adb4938cb21c7fe::legacy::is_vip(legacy_state(arg0), arg6)) {
            2
        } else {
            1
        }
    }

    public fun validator(arg0: &Collection) : address {
        arg0.validator
    }

    public fun vault_id(arg0: &Collection) : 0x2::object::ID {
        arg0.vault
    }

    public fun withdraw_royalties(arg0: &Collection, arg1: &mut 0x2::transfer_policy::TransferPolicy<KingFizh>, arg2: &mut 0x2::tx_context::TxContext) {
        distribute(arg0, arg1, arg2);
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

