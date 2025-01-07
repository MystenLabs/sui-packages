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

    struct InscriptionBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct MOVESCRIPTION has drop {
        dummy_field: bool,
    }

    struct DeployRecord has key {
        id: 0x2::object::UID,
        version: u64,
        record: 0x2::table::Table<0x1::ascii::String, address>,
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

    struct BurnReceipt has store, key {
        id: 0x2::object::UID,
        tick: 0x1::ascii::String,
        amount: u64,
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

    struct MintTick has copy, drop {
        sender: address,
        tick: 0x1::ascii::String,
    }

    struct BurnTick has copy, drop {
        sender: address,
        tick: 0x1::ascii::String,
        amount: u64,
        message: 0x1::string::String,
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

    public entry fun split(arg0: &mut Movescription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_split(arg0, arg1, arg2);
        0x2::transfer::public_transfer<Movescription>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun acc(arg0: &Movescription) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.acc)
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

    public entry fun burn(arg0: &mut TickRecord, arg1: Movescription, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = do_burn_with_message(arg0, arg1, 0x1::vector::empty<u8>(), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun burn_for_receipt(arg0: &mut TickRecord, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_burn_for_receipt(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<BurnReceipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun calculate_deploy_fee(arg0: vector<u8>, arg1: u64) : u64 {
        assert!(arg1 >= 120, 15);
        let v0 = 0x1::ascii::string(arg0);
        let v1 = 0x1::ascii::length(&v0);
        assert!(v1 >= 4 && v1 <= 32, 1);
        let v2 = if (arg1 >= 21600) {
            100
        } else {
            21600 * 100 / arg1
        };
        1000 * 4 / v1 + v2
    }

    public fun check_tick(arg0: &Movescription, arg1: vector<u8>) : bool {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        arg0.tick == 0x1::ascii::string(arg1)
    }

    public entry fun deploy(arg0: &mut DeployRecord, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 20
    }

    public entry fun deploy_v2(arg0: &mut DeployRecord, arg1: &mut TickRecord, arg2: &mut Movescription, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 23
    }

    public fun do_burn(arg0: &mut TickRecord, arg1: Movescription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        do_burn_with_message(arg0, arg1, 0x1::vector::empty<u8>(), arg2)
    }

    public fun do_burn_for_receipt(arg0: &mut TickRecord, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BurnReceipt) {
        let v0 = do_burn_with_message(arg0, arg1, arg2, arg3);
        let v1 = BurnReceipt{
            id     : 0x2::object::new(arg3),
            tick   : arg1.tick,
            amount : arg1.amount,
        };
        (v0, v1)
    }

    public fun do_burn_with_message(arg0: &mut TickRecord, arg1: Movescription, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version <= 3, 19);
        assert!(arg0.tick == arg1.tick, 10);
        assert!(arg1.attach_coin == 0, 16);
        let Movescription {
            id          : v0,
            amount      : v1,
            tick        : v2,
            attach_coin : _,
            acc         : v4,
            metadata    : _,
        } = arg1;
        arg0.current_supply = arg0.current_supply - v1;
        0x2::object::delete(v0);
        let v6 = BurnTick{
            sender  : 0x2::tx_context::sender(arg3),
            tick    : v2,
            amount  : v1,
            message : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<BurnTick>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg3)
    }

    fun do_deploy(arg0: &mut DeployRecord, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        let v0 = 0x1::ascii::string(arg1);
        let v1 = 0x1::ascii::length(&v0);
        assert!(4 <= v1 && v1 <= 32, 1);
        assert!(!0x2::table::contains<0x1::ascii::String, address>(&arg0.record, v0), 2);
        assert!(arg2 > 120, 4);
        assert!(arg4 >= 120, 15);
        assert!(arg5 <= 100000000000, 12);
        let v2 = 0x2::object::new(arg6);
        let v3 = TickRecord{
            id                 : v2,
            version            : 3,
            tick               : v0,
            total_supply       : arg2,
            start_time_ms      : arg3,
            epoch_count        : arg4,
            current_epoch      : 0,
            remain             : arg2,
            mint_fee           : arg5,
            epoch_records      : 0x2::table::new<u64, EpochRecord>(arg6),
            current_supply     : 0,
            total_transactions : 0,
        };
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.record, v0, 0x2::object::id_address<TickRecord>(&v3));
        0x2::transfer::share_object<TickRecord>(v3);
        let v4 = DeployTick{
            id            : 0x2::object::uid_to_inner(&v2),
            deployer      : 0x2::tx_context::sender(arg6),
            tick          : v0,
            total_supply  : arg2,
            start_time_ms : arg3,
            epoch_count   : arg4,
            mint_fee      : arg5,
        };
        0x2::event::emit<DeployTick>(v4);
    }

    fun do_deploy_with_fee(arg0: &mut DeployRecord, arg1: &mut TickRecord, arg2: &mut Movescription, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 3, 19);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        if (arg5 == 0) {
            arg5 = v0;
        };
        assert!(arg5 >= v0, 17);
        assert!(arg2.tick == 0x1::ascii::string(b"MOVE"), 21);
        assert!(arg1.tick == arg2.tick, 21);
        let v1 = calculate_deploy_fee(arg3, arg6);
        assert!(arg2.amount >= v1, 22);
        let v2 = do_split(arg2, v1, arg9);
        let v3 = do_burn(arg1, v2, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg9));
        do_deploy(arg0, arg3, arg4, arg5, arg6, arg7, arg9);
    }

    public fun do_merge(arg0: &mut Movescription, arg1: Movescription) {
        assert!(arg0.tick == arg1.tick, 10);
        assert!(arg1.attach_coin == 0, 16);
        assert!(arg0.metadata == arg1.metadata, 18);
        let Movescription {
            id          : v0,
            amount      : v1,
            tick        : _,
            attach_coin : _,
            acc         : v4,
            metadata    : _,
        } = arg1;
        arg0.amount = arg0.amount + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.acc, v4);
        0x2::object::delete(v0);
    }

    public fun do_mint(arg0: &mut TickRecord, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 3, 19);
        assert!(arg0.remain > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time_ms, 14);
        arg0.total_transactions = arg0.total_transactions + 1;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg0.tick;
        let v3 = if (0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.mint_fee) {
            arg1
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
            0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.mint_fee, arg3)
        };
        let v4 = arg0.current_epoch;
        if (0x2::table::contains<u64, EpochRecord>(&arg0.epoch_records, v4)) {
            let v5 = 0x2::table::borrow_mut<u64, EpochRecord>(&mut arg0.epoch_records, v4);
            mint_in_epoch(v5, v1, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
            if (v5.start_time_ms + 60000 < v0 || 0x1::vector::length<address>(&v5.players) >= 500) {
                settlement(arg0, v4, v1, v0, arg3);
            };
        } else {
            0x2::table::add<u64, EpochRecord>(&mut arg0.epoch_records, v4, new_epoch_record(v2, v4, v0, v1, 0x2::coin::into_balance<0x2::sui::SUI>(v3), arg3));
        };
        let v6 = MintTick{
            sender : v1,
            tick   : v2,
        };
        0x2::event::emit<MintTick>(v6);
    }

    public fun do_split(arg0: &mut Movescription, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Movescription {
        assert!(0 < arg1 && arg1 < arg0.amount, 9);
        assert!(arg0.attach_coin == 0, 16);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.acc);
        let v1 = if (v0 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            let v2 = split_acc(v0, arg1, arg0.amount);
            let v3 = v2;
            if (v2 == 0) {
                v3 = 1;
            };
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.acc, v3)
        };
        arg0.amount = arg0.amount - arg1;
        new_movescription(arg1, arg0.tick, v1, arg0.metadata, arg2)
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

    fun init(arg0: MOVESCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployRecord{
            id      : 0x2::object::new(arg1),
            version : 3,
            record  : 0x2::table::new<0x1::ascii::String, address>(arg1),
        };
        let v1 = &mut v0;
        do_deploy(v1, b"MOVE", 10000000000, 1704038400000, 21600, 100000000, arg1);
        0x2::transfer::share_object<DeployRecord>(v0);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"tick"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{amount}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::svg::generateSVG(b"mrc-20", b"mint", b"{tick}", b"{amount}")));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://movescriptions.org"));
        let v6 = 0x2::package::claim<MOVESCRIPTION>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Movescription>(&v6, v2, v4, arg1);
        0x2::display::update_version<Movescription>(&mut v7);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, v8);
        0x2::transfer::public_transfer<0x2::display::Display<Movescription>>(v7, v8);
    }

    public fun inject_sui(arg0: &mut Movescription, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.acc, arg1);
    }

    public entry fun inject_sui_entry(arg0: &mut Movescription, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        inject_sui(arg0, arg1);
    }

    public entry fun merge(arg0: &mut Movescription, arg1: Movescription) {
        do_merge(arg0, arg1);
    }

    public fun migrate_deploy_record(arg0: &mut DeployRecord) {
        assert!(arg0.version <= 3, 19);
        arg0.version = 3;
    }

    public fun migrate_tick_record(arg0: &mut TickRecord) {
        assert!(arg0.version <= 3, 19);
        arg0.version = 3;
    }

    public fun min_epochs() : u64 {
        120
    }

    public entry fun mint(arg0: &mut TickRecord, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::string_util::to_uppercase(&mut arg1);
        assert!(arg0.tick == 0x1::ascii::string(arg1), 3);
        do_mint(arg0, arg2, arg3, arg4);
    }

    fun mint_in_epoch(arg0: &mut EpochRecord, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.mint_fees, arg1)) {
            0x1::vector::push_back<address>(&mut arg0.players, arg1);
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.mint_fees, arg1, arg2);
        } else {
            0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.mint_fees, arg1), arg2);
        };
    }

    fun new_epoch_record(arg0: 0x1::ascii::String, arg1: u64, arg2: u64, arg3: address, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : EpochRecord {
        let v0 = 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg5);
        0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0, arg3, arg4);
        let v1 = NewEpoch{
            tick          : arg0,
            epoch         : arg1,
            start_time_ms : arg2,
        };
        0x2::event::emit<NewEpoch>(v1);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, arg3);
        EpochRecord{
            epoch         : arg1,
            start_time_ms : arg2,
            players       : v2,
            mint_fees     : v0,
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
        b"MOVE"
    }

    fun settlement(arg0: &mut TickRecord, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.tick;
        let v1 = 0x2::table::borrow_mut<u64, EpochRecord>(&mut arg0.epoch_records, arg1);
        let v2 = arg0.total_supply / arg0.epoch_count;
        let v3 = v2;
        if (v2 * 2 > arg0.remain) {
            v3 = arg0.remain;
        };
        let v4 = v1.players;
        let v5 = 0;
        let v6 = 0x1::vector::length<address>(&v4);
        let v7 = v3 / v6;
        let v8 = v7;
        if (v7 == 0) {
            v8 = 1;
        };
        while (v5 < v6) {
            let v9 = *0x1::vector::borrow<address>(&v4, v5);
            if (arg0.remain > 0) {
                let v10 = new_movescription(v8, v0, 0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v1.mint_fees, v9), 0x1::option::none<Metadata>(), arg4);
                0x2::transfer::public_transfer<Movescription>(v10, v9);
                arg0.remain = arg0.remain - v8;
                arg0.current_supply = arg0.current_supply + v8;
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v1.mint_fees, v9), arg4), v9);
            };
            v5 = v5 + 1;
        };
        let v11 = v8 * v6;
        if (v11 < v3) {
            let v12 = v3 - v11;
            let v13 = new_movescription(v12, v0, 0x2::balance::zero<0x2::sui::SUI>(), 0x1::option::none<Metadata>(), arg4);
            0x2::transfer::public_transfer<Movescription>(v13, arg2);
            arg0.remain = arg0.remain - v12;
            arg0.current_supply = arg0.current_supply + v12;
        };
        assert!(0x2::table::is_empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(&v1.mint_fees), 0);
        let v14 = SettleEpoch{
            tick           : v0,
            epoch          : arg1,
            settle_user    : arg2,
            settle_time_ms : arg3,
            palyers_count  : v6,
            epoch_amount   : v3,
        };
        0x2::event::emit<SettleEpoch>(v14);
        if (arg0.remain != 0) {
            let v15 = arg1 + 1;
            0x2::table::add<u64, EpochRecord>(&mut arg0.epoch_records, v15, new_epoch_record(v0, v15, arg3, arg2, 0x2::balance::zero<0x2::sui::SUI>(), arg4));
            arg0.current_epoch = v15;
        };
    }

    fun split_acc(arg0: u64, arg1: u64, arg2: u64) : u64 {
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

    public fun tick_record_current_epoch(arg0: &TickRecord) : u64 {
        arg0.current_epoch
    }

    public fun tick_record_current_supply(arg0: &TickRecord) : u64 {
        arg0.current_supply
    }

    public fun tick_record_epoch_count(arg0: &TickRecord) : u64 {
        arg0.epoch_count
    }

    public fun tick_record_mint_fee(arg0: &TickRecord) : u64 {
        arg0.mint_fee
    }

    public fun tick_record_remain(arg0: &TickRecord) : u64 {
        arg0.remain
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

    // decompiled from Move bytecode v6
}

