module 0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle {
    struct ChainData has copy, drop, store {
        gas_price: u128,
        price: u128,
    }

    struct GasOracle has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<u8, ChainData>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun new() : ChainData {
        ChainData{
            gas_price : 0,
            price     : 0,
        }
    }

    public(friend) fun cross_rate(arg0: &GasOracle, arg1: u8) : u128 {
        let v0 = get_own_chain_data(arg0);
        (((0x2::table::borrow<u8, ChainData>(&arg0.data, arg1).price as u256) * 1000000000000000000 / (v0.price as u256)) as u128)
    }

    public(friend) fun gas_price(arg0: &ChainData) : u128 {
        arg0.gas_price
    }

    public(friend) fun get_chain_data(arg0: &GasOracle, arg1: u8) : ChainData {
        if (0x2::table::contains<u8, ChainData>(&arg0.data, arg1)) {
            *0x2::table::borrow<u8, ChainData>(&arg0.data, arg1)
        } else {
            new()
        }
    }

    public(friend) fun get_id(arg0: &GasOracle) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_own_chain_data(arg0: &GasOracle) : ChainData {
        get_chain_data(arg0, 13)
    }

    public(friend) fun get_transaction_gas_cost_in_native_token(arg0: &GasOracle, arg1: u8, arg2: u64) : u64 {
        let ChainData {
            gas_price : v0,
            price     : v1,
        } = *0x2::table::borrow<u8, ChainData>(&arg0.data, arg1);
        let v2 = get_own_chain_data(arg0);
        (((v0 as u256) * (arg2 as u256) * (v1 as u256) / (v2.price as u256) / (1000000000 as u256)) as u64)
    }

    public(friend) fun get_transaction_gas_cost_in_stable(arg0: &GasOracle, arg1: u8, arg2: u64, arg3: u8) : u64 {
        let ChainData {
            gas_price : v0,
            price     : v1,
        } = *0x2::table::borrow<u8, ChainData>(&arg0.data, arg1);
        (((v0 as u256) * (arg2 as u256) * (v1 as u256) / (0x1::u128::pow(10, 18 + 18 - arg3) as u256)) as u64) + 1
    }

    public(friend) fun get_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::init_version<AdminCap>(&v0, &mut v1, 1);
        let v2 = GasOracle{
            id   : v1,
            data : 0x2::table::new<u8, ChainData>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GasOracle>(v2);
    }

    public(friend) fun migrate(arg0: &AdminCap, arg1: &mut GasOracle) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::migrate_version<AdminCap>(arg0, &mut arg1.id, 1);
    }

    public(friend) fun price(arg0: &ChainData) : u128 {
        arg0.price
    }

    public(friend) fun set_chain_data(arg0: &mut GasOracle, arg1: u8, arg2: u128, arg3: u128) {
        let v0 = ChainData{
            gas_price : arg2,
            price     : arg3,
        };
        if (0x2::table::contains<u8, ChainData>(&arg0.data, arg1)) {
            *0x2::table::borrow_mut<u8, ChainData>(&mut arg0.data, arg1) = v0;
        } else {
            0x2::table::add<u8, ChainData>(&mut arg0.data, arg1, v0);
        };
    }

    public(friend) fun set_gas_price(arg0: &mut GasOracle, arg1: u8, arg2: u128) {
        if (0x2::table::contains<u8, ChainData>(&arg0.data, arg1)) {
            0x2::table::borrow_mut<u8, ChainData>(&mut arg0.data, arg1).gas_price = arg2;
        } else {
            let v0 = new();
            v0.gas_price = arg2;
            0x2::table::add<u8, ChainData>(&mut arg0.data, arg1, v0);
        };
    }

    public(friend) fun set_price(arg0: &mut GasOracle, arg1: u8, arg2: u128) {
        if (0x2::table::contains<u8, ChainData>(&arg0.data, arg1)) {
            0x2::table::borrow_mut<u8, ChainData>(&mut arg0.data, arg1).price = arg2;
        } else {
            let v0 = new();
            v0.price = arg2;
            0x2::table::add<u8, ChainData>(&mut arg0.data, arg1, v0);
        };
    }

    public(friend) fun stable_to_sui_amount(arg0: &GasOracle, arg1: u64, arg2: u8) : u64 {
        let v0 = get_own_chain_data(arg0);
        (((0x1::u128::pow(10, 18 + 9 - arg2) as u256) * (arg1 as u256) / (v0.price as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

