module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription {
    struct Movescription has store, key {
        id: 0x2::object::UID,
        amount: u64,
        tick: 0x1::ascii::String,
        attach_coin: u64,
        acc: 0x2::balance::Balance<0x2::sui::SUI>,
        metadata: 0x1::option::Option<Metadata>,
    }

    struct Metadata has copy, drop, store {
        content_type: 0x1::string::String,
        content: vector<u8>,
    }

    struct LockedBox has store {
        locked_movescription: Movescription,
    }

    struct MOVESCRIPTION has drop {
        dummy_field: bool,
    }

    struct DeployRecord has key {
        id: 0x2::object::UID,
        version: u64,
        record: 0x2::table::Table<0x1::ascii::String, address>,
    }

    struct TickStat has copy, drop, store {
        remain: u64,
        current_supply: u64,
        total_transactions: u64,
    }

    struct TickRecordV2 has store, key {
        id: 0x2::object::UID,
        version: u64,
        tick: 0x1::ascii::String,
        total_supply: u64,
        burnable: bool,
        mint_factory: 0x1::ascii::String,
        stat: TickStat,
    }

    struct BurnReceipt has store, key {
        id: 0x2::object::UID,
        tick: 0x1::ascii::String,
        amount: u64,
    }

    struct Treasury<phantom T0> has store {
        cap: 0x2::coin::TreasuryCap<T0>,
        coin_type: 0x1::ascii::String,
    }

    struct InitTreasuryArgs<phantom T0> has store, key {
        id: 0x2::object::UID,
        tick: 0x1::ascii::String,
        cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
    }

    struct DeployTickV2 has copy, drop {
        id: 0x2::object::ID,
        deployer: address,
        tick: 0x1::ascii::String,
        total_supply: u64,
        burnable: bool,
    }

    struct MintTickV2 has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        tick: 0x1::ascii::String,
        amount: u64,
    }

    struct BurnTick has copy, drop {
        sender: address,
        tick: 0x1::ascii::String,
        amount: u64,
        message: 0x1::string::String,
    }

    struct IncentiveEvent has copy, drop {
        to_mint_value: u64,
        new_burn_to_coin: u64,
    }

    struct InscriptionBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct EpochRecord has store {
        epoch: u64,
        start_time_ms: u64,
        players: vector<address>,
        mint_fees: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
    }

    struct TickRecord has key {
        id: 0x2::object::UID,
        version: u64,
        tick: 0x1::ascii::String,
        total_supply: u64,
        start_time_ms: u64,
        epoch_count: u64,
        current_epoch: u64,
        remain: u64,
        mint_fee: u64,
        epoch_records: 0x2::table::Table<u64, EpochRecord>,
        current_supply: u64,
        total_transactions: u64,
    }

    struct DeployTick has copy, drop {
        id: 0x2::object::ID,
        deployer: address,
        tick: 0x1::ascii::String,
        total_supply: u64,
        start_time_ms: u64,
        epoch_count: u64,
        mint_fee: u64,
    }

    struct NewEpoch has copy, drop {
        tick: 0x1::ascii::String,
        epoch: u64,
        start_time_ms: u64,
    }

    struct SettleEpoch has copy, drop {
        tick: 0x1::ascii::String,
        epoch: u64,
        settle_user: address,
        settle_time_ms: u64,
        palyers_count: u64,
        epoch_amount: u64,
    }

    struct MintTick has copy, drop {
        sender: address,
        tick: 0x1::ascii::String,
    }

    public fun destroy_zero(arg0: Movescription) {
        assert!(arg0.amount == 0, 27);
        assert!(arg0.attach_coin == 0, 16);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.acc) == 0, 27);
        assert!(0x1::option::is_none<Metadata>(&arg0.metadata), 27);
        if (contains_locked(&arg0)) {
            let v0 = &mut arg0;
            destroy_zero(unlock_box(v0));
        };
        let Movescription {
            id          : v1,
            amount      : _,
            tick        : _,
            attach_coin : _,
            acc         : v5,
            metadata    : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        0x2::object::delete(v1);
    }

    public entry fun split(arg0: &mut Movescription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_split(arg0, arg1, arg2);
        0x2::transfer::public_transfer<Movescription>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun zero(arg0: &TickRecordV2, arg1: &mut 0x2::tx_context::TxContext) : Movescription {
        new_movescription(0, arg0.tick, 0x2::balance::zero<0x2::sui::SUI>(), 0x1::option::none<Metadata>(), arg1)
    }

    public entry fun burn(arg0: &mut TickRecord, arg1: Movescription, arg2: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public fun acc(arg0: &Movescription) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.acc)
    }

    fun add_df<T0: store>(arg0: &mut Movescription, arg1: T0) {
        0x2::dynamic_field::add<0x1::ascii::String, T0>(&mut arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>(), arg1);
    }

    public fun add_incentive<T0: drop>(arg0: &mut TickRecordV2) {
        assert!(arg0.version <= 4, 19);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"burn_to_coin")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"burn_to_coin", 0);
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"burn_to_coin");
        let v1 = tick_record_v2_burned_amount(arg0) * 1000000000 - *v0;
        *v0 = *v0 + v1;
        let v2 = borrow_mut_treasury<T0>(arg0);
        let v3 = IncentiveEvent{
            to_mint_value    : v1,
            new_burn_to_coin : *v0,
        };
        0x2::event::emit<IncentiveEvent>(v3);
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"incentive")) {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive", 0x2::coin::mint_balance<T0>(&mut v2.cap, v1));
        } else {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive"), 0x2::coin::mint_balance<T0>(&mut v2.cap, v1));
        };
    }

    fun add_treasury<T0: drop>(arg0: &mut TickRecordV2, arg1: Treasury<T0>) {
        0x2::dynamic_field::add<vector<u8>, Treasury<T0>>(&mut arg0.id, b"treasury", arg1);
    }

    public fun amount(arg0: &Movescription) : u64 {
        arg0.amount
    }

    public fun attach_coin(arg0: &Movescription) : u64 {
        arg0.attach_coin
    }

    public fun base_epoch_count() : u64 {
        21600
    }

    fun borrow_df<T0: store>(arg0: &Movescription) : &T0 {
        0x2::dynamic_field::borrow<0x1::ascii::String, T0>(&arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    fun borrow_df_mut<T0: store>(arg0: &mut Movescription) : &mut T0 {
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, T0>(&mut arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    public(friend) fun borrow_incentive<T0: drop>(arg0: &TickRecordV2) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"incentive")
    }

    public fun borrow_locked(arg0: &Movescription) : &Movescription {
        &borrow_df<LockedBox>(arg0).locked_movescription
    }

    public(friend) fun borrow_mut_incentive<T0: drop>(arg0: &mut TickRecordV2) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive")
    }

    fun borrow_mut_locked(arg0: &mut Movescription) : &mut Movescription {
        &mut borrow_df_mut<LockedBox>(arg0).locked_movescription
    }

    fun borrow_mut_treasury<T0: drop>(arg0: &mut TickRecordV2) : &mut Treasury<T0> {
        0x2::dynamic_field::borrow_mut<vector<u8>, Treasury<T0>>(&mut arg0.id, b"treasury")
    }

    fun borrow_treasury<T0: drop>(arg0: &TickRecordV2) : &Treasury<T0> {
        0x2::dynamic_field::borrow<vector<u8>, Treasury<T0>>(&arg0.id, b"treasury")
    }

    public entry fun burn_for_receipt(arg0: &mut TickRecord, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public entry fun burn_for_receipt_v2(arg0: &mut TickRecordV2, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = do_burn_for_receipt_v2(arg0, arg1, arg2, arg3);
        let v3 = v1;
        if (0x1::option::is_some<Movescription>(&v3)) {
            0x2::transfer::public_transfer<Movescription>(0x1::option::destroy_some<Movescription>(v3), 0x2::tx_context::sender(arg3));
        } else {
            0x1::option::destroy_none<Movescription>(v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<BurnReceipt>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun burn_v2(arg0: &mut TickRecordV2, arg1: Movescription, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_burn_v2(arg0, arg1, arg2);
        let v2 = v1;
        if (0x1::option::is_some<Movescription>(&v2)) {
            0x2::transfer::public_transfer<Movescription>(0x1::option::destroy_some<Movescription>(v2), 0x2::tx_context::sender(arg2));
        } else {
            0x1::option::destroy_none<Movescription>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun calculate_deploy_fee(arg0: vector<u8>, arg1: u64) : u64 {
        abort 20
    }

    public fun check_coin_type<T0: drop>(arg0: &TickRecordV2) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>() == borrow_treasury<T0>(arg0).coin_type
    }

    public fun check_tick(arg0: &Movescription, arg1: vector<u8>) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        0x1::ascii::into_bytes(arg0.tick) == arg1
    }

    public fun check_tick_record(arg0: &TickRecordV2, arg1: vector<u8>) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        0x1::ascii::into_bytes(arg0.tick) == arg1
    }

    public fun clean_finished_tick_record(arg0: &mut TickRecord, arg1: u64) {
        assert!(arg0.remain == 0, 1000);
        let v0 = 0x2::table::length<u64, EpochRecord>(&arg0.epoch_records);
        let v1 = v0 - 1;
        let v2 = 0;
        while (v1 > 0 && v2 < 0x2::math::min(arg1, v0)) {
            if (0x2::table::contains<u64, EpochRecord>(&arg0.epoch_records, v1)) {
                let (_, _, _, v6) = unwrap_epoch_record(0x2::table::remove<u64, EpochRecord>(&mut arg0.epoch_records, v1));
                0x2::table::destroy_empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(v6);
                v2 = v2 + 1;
            };
            v1 = v1 - 1;
        };
    }

    public fun clean_finished_tick_record_via_epoch(arg0: &mut TickRecord, arg1: u64) {
        assert!(arg0.remain == 0, 1000);
        if (0x2::table::contains<u64, EpochRecord>(&arg0.epoch_records, arg1)) {
            let (_, _, _, v3) = unwrap_epoch_record(0x2::table::remove<u64, EpochRecord>(&mut arg0.epoch_records, arg1));
            0x2::table::destroy_empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(v3);
        };
    }

    public fun clean_old_invalid_not_start_tick_record(arg0: &mut DeployRecord, arg1: &mut TickRecord) {
        arg1.version = 4;
        let v0 = arg1.tick;
        if (!0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::is_tick_name_valid(0x1::ascii::into_bytes(v0)) && arg1.current_epoch == 0 && arg1.total_transactions == 0) {
            0x2::table::remove<0x1::ascii::String, address>(&mut arg0.record, v0);
        };
    }

    public fun coin_supply<T0: drop>(arg0: &TickRecordV2) : u64 {
        0x2::coin::total_supply<T0>(&borrow_treasury<T0>(arg0).cap)
    }

    public(friend) fun coin_to_movescription<T0: drop>(arg0: &mut TickRecordV2, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x1::option::Option<Movescription>, arg3: 0x1::option::Option<Metadata>, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : (Movescription, 0x2::balance::Balance<T0>) {
        assert!(arg0.version <= 4, 19);
        let v0 = borrow_mut_treasury<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&arg4);
        assert!(v1 >= 1000000000, 30);
        let v2 = v1 / 1000000000;
        0x2::coin::burn<T0>(&mut v0.cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg4, v2 * 1000000000), arg5));
        let v3 = new_movescription(v2, arg0.tick, arg1, arg3, arg5);
        if (0x1::option::is_some<Movescription>(&arg2)) {
            let v4 = &mut v3;
            lock_within(v4, 0x1::option::destroy_some<Movescription>(arg2));
        } else {
            0x1::option::destroy_none<Movescription>(arg2);
        };
        (v3, arg4)
    }

    public fun contains_locked(arg0: &Movescription) : bool {
        exists_df<LockedBox>(arg0)
    }

    public entry fun deploy(arg0: &mut DeployRecord, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public entry fun deploy_v2(arg0: &mut DeployRecord, arg1: &mut TickRecord, arg2: &mut Movescription, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public fun do_burn(arg0: &mut TickRecord, arg1: Movescription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 20
    }

    public fun do_burn_for_receipt(arg0: &mut TickRecord, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BurnReceipt) {
        abort 20
    }

    public fun do_burn_for_receipt_v2(arg0: &mut TickRecordV2, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<Movescription>, BurnReceipt) {
        let (v0, v1) = do_burn_with_message_v2(arg0, arg1, arg2, arg3);
        let v2 = BurnReceipt{
            id     : 0x2::object::new(arg3),
            tick   : arg1.tick,
            amount : arg1.amount,
        };
        (v0, v1, v2)
    }

    public fun do_burn_v2(arg0: &mut TickRecordV2, arg1: Movescription, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<Movescription>) {
        do_burn_with_message_v2(arg0, arg1, 0x1::vector::empty<u8>(), arg2)
    }

    public fun do_burn_with_message(arg0: &mut TickRecord, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 20
    }

    public fun do_burn_with_message_v2(arg0: &mut TickRecordV2, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<Movescription>) {
        assert!(arg0.burnable, 26);
        internal_burn(arg0, arg1, arg2, arg3)
    }

    public fun do_burn_with_witness<T0: drop>(arg0: &mut TickRecordV2, arg1: Movescription, arg2: vector<u8>, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<Movescription>) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::assert_witness<T0>(arg0.mint_factory);
        internal_burn(arg0, arg1, arg2, arg4)
    }

    public fun do_merge(arg0: &mut Movescription, arg1: Movescription) {
        assert!(arg0.tick == arg1.tick, 10);
        assert!(arg1.attach_coin == 0, 16);
        assert!(arg0.metadata == arg1.metadata, 18);
        if (contains_locked(&arg1)) {
            let v0 = &mut arg1;
            lock_within(arg0, unlock_box(v0));
        };
        let Movescription {
            id          : v1,
            amount      : v2,
            tick        : _,
            attach_coin : _,
            acc         : v5,
            metadata    : _,
        } = arg1;
        arg0.amount = arg0.amount + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.acc, v5);
        0x2::object::delete(v1);
    }

    public fun do_mint(arg0: &mut TickRecord, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public fun do_mint_with_witness<T0: drop>(arg0: &mut TickRecordV2, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: 0x1::option::Option<Metadata>, arg4: T0, arg5: &mut 0x2::tx_context::TxContext) : Movescription {
        assert!(arg0.version <= 4, 19);
        assert!(arg0.stat.remain > 0, 7);
        assert!(arg0.stat.remain >= arg2, 7);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::is_witness<T0>(), 24);
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::assert_witness<T0>(arg0.mint_factory);
        arg0.stat.remain = arg0.stat.remain - arg2;
        arg0.stat.current_supply = arg0.stat.current_supply + arg2;
        arg0.stat.total_transactions = arg0.stat.total_transactions + 1;
        let v0 = arg0.tick;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = new_movescription(arg2, v0, arg1, arg3, arg5);
        let v3 = MintTickV2{
            id     : 0x2::object::id<Movescription>(&v2),
            sender : v1,
            tick   : v0,
            amount : arg2,
        };
        0x2::event::emit<MintTickV2>(v3);
        v2
    }

    public fun do_split(arg0: &mut Movescription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Movescription {
        assert!(0 < arg1 && arg1 < arg0.amount, 9);
        assert!(arg0.attach_coin == 0, 16);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.acc);
        let v1 = arg0.amount;
        let v2 = if (v0 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.acc, split_amount(v0, arg1, v1))
        };
        arg0.amount = v1 - arg1;
        let v3 = new_movescription(arg1, arg0.tick, v2, arg0.metadata, arg2);
        if (contains_locked(arg0)) {
            let v4 = borrow_mut_locked(arg0);
            let v5 = split_amount(v4.amount, arg1, v1);
            let v6 = &mut v3;
            lock_within(v6, do_split(v4, v5, arg2));
        };
        v3
    }

    public fun drop_receipt(arg0: BurnReceipt) : (0x1::ascii::String, u64) {
        let BurnReceipt {
            id     : v0,
            tick   : v1,
            amount : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    public fun epoch_duration_ms() : u64 {
        60000
    }

    public fun epoch_max_player() : u64 {
        500
    }

    fun exists_df<T0: store>(arg0: &Movescription) : bool {
        0x2::dynamic_field::exists_with_type<0x1::ascii::String, T0>(&arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    fun init(arg0: MOVESCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployRecord{
            id      : 0x2::object::new(arg1),
            version : 4,
            record  : 0x2::table::new<0x1::ascii::String, address>(arg1),
        };
        0x2::transfer::share_object<DeployRecord>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tick"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{amount}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::svg::generateSVG(b"mrc-20", b"mint", b"{tick}", b"{amount}")));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://movescriptions.org"));
        let v5 = 0x2::package::claim<MOVESCRIPTION>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Movescription>(&v5, v1, v3, arg1);
        0x2::display::update_version<Movescription>(&mut v6);
        let v7 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v7);
        0x2::transfer::public_transfer<0x2::display::Display<Movescription>>(v6, v7);
    }

    public fun init_treasury<T0: drop>(arg0: &mut TickRecordV2, arg1: &mut InitTreasuryArgs<T0>) {
        assert!(arg0.version <= 4, 19);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"treasury"), 29);
        assert!(arg0.tick == arg1.tick, 10);
        let v0 = Treasury<T0>{
            cap       : 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg1.cap),
            coin_type : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>(),
        };
        add_treasury<T0>(arg0, v0);
    }

    public fun inject_sui(arg0: &mut Movescription, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.acc, arg1);
    }

    public entry fun inject_sui_entry(arg0: &mut Movescription, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        inject_sui(arg0, arg1);
    }

    fun internal_burn(arg0: &mut TickRecordV2, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x1::option::Option<Movescription>) {
        assert!(arg0.version <= 4, 19);
        assert!(arg0.tick == arg1.tick, 10);
        assert!(arg1.attach_coin == 0, 16);
        let v0 = if (contains_locked(&arg1)) {
            let v1 = &mut arg1;
            0x1::option::some<Movescription>(unlock_box(v1))
        } else {
            0x1::option::none<Movescription>()
        };
        let Movescription {
            id          : v2,
            amount      : v3,
            tick        : v4,
            attach_coin : _,
            acc         : v6,
            metadata    : _,
        } = arg1;
        arg0.stat.current_supply = arg0.stat.current_supply - v3;
        0x2::object::delete(v2);
        let v8 = BurnTick{
            sender  : 0x2::tx_context::sender(arg3),
            tick    : v4,
            amount  : v3,
            message : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<BurnTick>(v8);
        (0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3), v0)
    }

    public(friend) fun internal_deploy_with_witness<T0: drop>(arg0: &mut DeployRecord, arg1: 0x1::ascii::String, arg2: u64, arg3: bool, arg4: T0, arg5: &mut 0x2::tx_context::TxContext) : TickRecordV2 {
        assert!(!0x2::table::contains<0x1::ascii::String, address>(&arg0.record, arg1), 2);
        assert!(arg2 > 0, 4);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::is_witness<T0>(), 24);
        let v0 = 0x2::object::new(arg5);
        let v1 = TickStat{
            remain             : arg2,
            current_supply     : 0,
            total_transactions : 0,
        };
        let v2 = TickRecordV2{
            id           : v0,
            version      : 4,
            tick         : arg1,
            total_supply : arg2,
            burnable     : arg3,
            mint_factory : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::module_id<T0>(),
            stat         : v1,
        };
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.record, arg1, 0x2::object::id_address<TickRecordV2>(&v2));
        let v3 = DeployTickV2{
            id           : 0x2::object::uid_to_inner(&v0),
            deployer     : 0x2::tx_context::sender(arg5),
            tick         : arg1,
            total_supply : arg2,
            burnable     : arg3,
        };
        0x2::event::emit<DeployTickV2>(v3);
        v2
    }

    public fun is_deployed(arg0: &DeployRecord, arg1: vector<u8>) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        0x2::table::contains<0x1::ascii::String, address>(&arg0.record, 0x1::ascii::string(arg1))
    }

    public fun is_mergeable(arg0: &Movescription, arg1: &Movescription) : bool {
        arg0.tick == arg1.tick && arg0.metadata == arg1.metadata
    }

    public(friend) fun is_movescription_publisher(arg0: &0x2::package::Publisher) : bool {
        0x2::package::from_module<Movescription>(arg0)
    }

    public fun is_splitable(arg0: &Movescription) : bool {
        arg0.amount > 1 && arg0.attach_coin == 0
    }

    public fun is_treasury_inited(arg0: &TickRecordV2) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"treasury")
    }

    public fun is_zero(arg0: &Movescription) : bool {
        if (arg0.amount != 0 || arg0.attach_coin != 0 || 0x2::balance::value<0x2::sui::SUI>(&arg0.acc) != 0 || 0x1::option::is_some<Metadata>(&arg0.metadata)) {
            return false
        };
        if (contains_locked(arg0)) {
            return is_zero(borrow_locked(arg0))
        };
        true
    }

    public fun lock_within(arg0: &mut Movescription, arg1: Movescription) {
        if (exists_df<LockedBox>(arg0)) {
            let v0 = &mut borrow_df_mut<LockedBox>(arg0).locked_movescription;
            do_merge(v0, arg1);
        } else {
            let v1 = LockedBox{locked_movescription: arg1};
            add_df<LockedBox>(arg0, v1);
        };
    }

    public fun mcoin_decimals() : u8 {
        9
    }

    public fun mcoin_decimals_base() : u64 {
        1000000000
    }

    public entry fun merge(arg0: &mut Movescription, arg1: Movescription) {
        do_merge(arg0, arg1);
    }

    public fun metadata(arg0: &Movescription) : 0x1::option::Option<Metadata> {
        arg0.metadata
    }

    public fun metadata_content(arg0: &Metadata) : vector<u8> {
        arg0.content
    }

    public fun metadata_content_type(arg0: &Metadata) : 0x1::string::String {
        arg0.content_type
    }

    public fun migrate_deploy_record(arg0: &mut DeployRecord) {
        assert!(arg0.version <= 4, 19);
        arg0.version = 4;
    }

    public fun migrate_tick_record(arg0: &mut TickRecord) {
        assert!(arg0.version <= 4, 19);
        arg0.version = 4;
    }

    public(friend) fun migrate_tick_record_to_v2<T0: drop>(arg0: &mut DeployRecord, arg1: TickRecord, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : (TickRecordV2, u64, u64, u64, u64, 0x2::table::Table<u64, EpochRecord>) {
        assert!(arg0.version <= 4, 19);
        let TickRecord {
            id                 : v0,
            version            : _,
            tick               : v2,
            total_supply       : v3,
            start_time_ms      : v4,
            epoch_count        : v5,
            current_epoch      : v6,
            remain             : v7,
            mint_fee           : v8,
            epoch_records      : v9,
            current_supply     : v10,
            total_transactions : v11,
        } = arg1;
        let v12 = TickStat{
            remain             : v7,
            current_supply     : v10,
            total_transactions : v11,
        };
        let v13 = TickRecordV2{
            id           : 0x2::object::new(arg3),
            version      : 4,
            tick         : v2,
            total_supply : v3,
            burnable     : true,
            mint_factory : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::module_id<T0>(),
            stat         : v12,
        };
        0x2::table::remove<0x1::ascii::String, address>(&mut arg0.record, v2);
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.record, v2, 0x2::object::id_address<TickRecordV2>(&v13));
        0x2::object::delete(v0);
        (v13, v4, v5, v6, v8, v9)
    }

    public(friend) fun migrate_tick_record_to_v2_no_drop<T0: drop>(arg0: &mut DeployRecord, arg1: &mut TickRecord, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : (TickRecordV2, u64, u64, u64, u64) {
        assert!(arg0.version <= 4, 19);
        assert!(arg1.version < 4, 19);
        arg1.version = 4;
        let v0 = TickStat{
            remain             : arg1.remain,
            current_supply     : arg1.current_supply,
            total_transactions : arg1.total_transactions,
        };
        let v1 = TickRecordV2{
            id           : 0x2::object::new(arg3),
            version      : 4,
            tick         : arg1.tick,
            total_supply : arg1.total_supply,
            burnable     : true,
            mint_factory : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::module_id<T0>(),
            stat         : v0,
        };
        0x2::table::remove<0x1::ascii::String, address>(&mut arg0.record, arg1.tick);
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.record, arg1.tick, 0x2::object::id_address<TickRecordV2>(&v1));
        (v1, arg1.start_time_ms, arg1.epoch_count, arg1.current_epoch, arg1.mint_fee)
    }

    public fun min_epochs() : u64 {
        120
    }

    public entry fun mint(arg0: &mut TickRecord, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public fun move_tick_total_supply() : u64 {
        10000000000
    }

    public(friend) fun movescription_to_coin<T0: drop>(arg0: &mut TickRecordV2, arg1: Movescription) : (0x2::balance::Balance<0x2::sui::SUI>, 0x1::option::Option<Movescription>, 0x1::option::Option<Metadata>, 0x2::balance::Balance<T0>) {
        assert!(arg0.version <= 4, 19);
        assert!(arg0.tick == arg1.tick, 10);
        assert!(arg1.attach_coin == 0, 16);
        let v0 = if (contains_locked(&arg1)) {
            let v1 = &mut arg1;
            0x1::option::some<Movescription>(unlock_box(v1))
        } else {
            0x1::option::none<Movescription>()
        };
        let Movescription {
            id          : v2,
            amount      : v3,
            tick        : _,
            attach_coin : _,
            acc         : v6,
            metadata    : v7,
        } = arg1;
        0x2::object::delete(v2);
        (v6, v0, v7, 0x2::coin::mint_balance<T0>(&mut borrow_mut_treasury<T0>(arg0).cap, v3 * 1000000000))
    }

    public fun new_init_treasury_args<T0: drop>(arg0: 0x1::ascii::String, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) : InitTreasuryArgs<T0> {
        assert!(0x2::coin::get_symbol<T0>(&arg2) == arg0, 28);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 27);
        assert!(0x2::coin::get_decimals<T0>(&arg2) == 9, 28);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(arg2);
        InitTreasuryArgs<T0>{
            id   : 0x2::object::new(arg3),
            tick : arg0,
            cap  : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg1),
        }
    }

    public fun new_metadata(arg0: 0x1::string::String, arg1: vector<u8>) : Metadata {
        Metadata{
            content_type : arg0,
            content      : arg1,
        }
    }

    fun new_movescription(arg0: u64, arg1: 0x1::ascii::String, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<Metadata>, arg4: &mut 0x2::tx_context::TxContext) : Movescription {
        Movescription{
            id          : 0x2::object::new(arg4),
            amount      : arg0,
            tick        : arg1,
            attach_coin : 0,
            acc         : arg2,
            metadata    : arg3,
        }
    }

    public fun protocol_start_time_ms() : u64 {
        1704038400000
    }

    public fun protocol_tick() : vector<u8> {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::tick_name::move_tick()
    }

    public fun protocol_tick_total_supply() : u64 {
        10000000000
    }

    fun remove_df<T0: store>(arg0: &mut Movescription) : T0 {
        0x2::dynamic_field::remove<0x1::ascii::String, T0>(&mut arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    fun split_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64);
        let v1 = v0;
        if (v0 == 0) {
            v1 = 1;
        };
        v1
    }

    public fun tick(arg0: &Movescription) : 0x1::ascii::String {
        arg0.tick
    }

    public fun tick_record_add_df<T0: store, T1: drop>(arg0: &mut TickRecordV2, arg1: T0, arg2: T1) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::assert_witness<T1>(arg0.mint_factory);
        tick_record_add_df_internal<T0>(arg0, arg1);
    }

    public(friend) fun tick_record_add_df_internal<T0: store>(arg0: &mut TickRecordV2, arg1: T0) {
        0x2::dynamic_field::add<0x1::ascii::String, T0>(&mut arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>(), arg1);
    }

    public fun tick_record_borrow_df<T0: store>(arg0: &TickRecordV2) : &T0 {
        0x2::dynamic_field::borrow<0x1::ascii::String, T0>(&arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    public fun tick_record_borrow_mut_df<T0: store, T1: drop>(arg0: &mut TickRecordV2, arg1: T1) : &mut T0 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::assert_witness<T1>(arg0.mint_factory);
        tick_record_borrow_mut_df_internal<T0>(arg0)
    }

    public(friend) fun tick_record_borrow_mut_df_internal<T0: store>(arg0: &mut TickRecordV2) : &mut T0 {
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, T0>(&mut arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    public fun tick_record_current_epoch(arg0: &TickRecord) : u64 {
        arg0.current_epoch
    }

    public fun tick_record_current_supply(arg0: &TickRecord) : u64 {
        arg0.current_supply
    }

    public fun tick_record_epoch_count(arg0: &TickRecord) : u64 {
        arg0.epoch_count
    }

    public(friend) fun tick_record_epoch_records(arg0: &mut TickRecord) : &mut 0x2::table::Table<u64, EpochRecord> {
        &mut arg0.epoch_records
    }

    public fun tick_record_exists_df<T0: store>(arg0: &TickRecordV2) : bool {
        0x2::dynamic_field::exists_with_type<0x1::ascii::String, T0>(&arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    public fun tick_record_mint_fee(arg0: &TickRecord) : u64 {
        arg0.mint_fee
    }

    public fun tick_record_remain(arg0: &TickRecord) : u64 {
        arg0.remain
    }

    public fun tick_record_remove_df<T0: store, T1: drop>(arg0: &mut TickRecordV2, arg1: T1) : T0 {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::assert_witness<T1>(arg0.mint_factory);
        0x2::dynamic_field::remove<0x1::ascii::String, T0>(&mut arg0.id, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<T0>())
    }

    public fun tick_record_start_time_ms(arg0: &TickRecord) : u64 {
        arg0.start_time_ms
    }

    public fun tick_record_total_supply(arg0: &TickRecord) : u64 {
        arg0.total_supply
    }

    public fun tick_record_total_transactions(arg0: &TickRecord) : u64 {
        arg0.total_transactions
    }

    public fun tick_record_v2_burned_amount(arg0: &TickRecordV2) : u64 {
        arg0.total_supply - arg0.stat.current_supply - arg0.stat.remain
    }

    public fun tick_record_v2_current_supply(arg0: &TickRecordV2) : u64 {
        arg0.stat.current_supply
    }

    public fun tick_record_v2_mint_factory(arg0: &TickRecordV2) : 0x1::ascii::String {
        arg0.mint_factory
    }

    public fun tick_record_v2_remain(arg0: &TickRecordV2) : u64 {
        arg0.stat.remain
    }

    public fun tick_record_v2_tick(arg0: &TickRecordV2) : 0x1::ascii::String {
        arg0.tick
    }

    public fun tick_record_v2_total_supply(arg0: &TickRecordV2) : u64 {
        arg0.total_supply
    }

    public fun tick_record_v2_total_transactions(arg0: &TickRecordV2) : u64 {
        arg0.stat.total_transactions
    }

    fun unlock_box(arg0: &mut Movescription) : Movescription {
        let LockedBox { locked_movescription: v0 } = remove_df<LockedBox>(arg0);
        v0
    }

    public fun unpack_metadata(arg0: Metadata) : (0x1::string::String, vector<u8>) {
        let Metadata {
            content_type : v0,
            content      : v1,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun unwrap_epoch_record(arg0: EpochRecord) : (u64, u64, vector<address>, 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>) {
        let EpochRecord {
            epoch         : v0,
            start_time_ms : v1,
            players       : v2,
            mint_fees     : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    // decompiled from Move bytecode v6
}

