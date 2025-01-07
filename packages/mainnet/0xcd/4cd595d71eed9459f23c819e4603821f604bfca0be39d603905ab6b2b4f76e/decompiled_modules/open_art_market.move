module 0xcd4cd595d71eed9459f23c819e4603821f604bfca0be39d603905ab6b2b4f76e::open_art_market {
    struct ContractStock has key {
        id: 0x2::object::UID,
        contract_id: 0x2::object::ID,
        shares: u64,
        share_price: u64,
        contract_name: 0x1::string::String,
        artist: 0x1::string::String,
        creation_date: u64,
        description: 0x1::string::String,
        currency: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Contract has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        shares: u64,
        share_price: u64,
        outgoing_price: u64,
        multiplier: u64,
        name: 0x1::string::String,
        artist: 0x1::string::String,
        creation_date: u64,
        description: 0x1::string::String,
        currency: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OPEN_ART_MARKET has drop {
        dummy_field: bool,
    }

    struct Shares has store {
        value: u64,
    }

    fun burn_contract_stock(arg0: ContractStock) : u64 {
        let ContractStock {
            id            : v0,
            contract_id   : _,
            shares        : v2,
            share_price   : _,
            contract_name : _,
            artist        : _,
            creation_date : _,
            description   : _,
            currency      : _,
            image_url     : _,
        } = arg0;
        0x2::object::delete(v0);
        v2
    }

    public fun get_available_shares_for_sale(arg0: &Contract) : u64 {
        arg0.shares
    }

    public fun get_contract_id(arg0: &Contract) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_stock_contract_id(arg0: &ContractStock) : 0x2::object::ID {
        arg0.contract_id
    }

    public fun get_stock_shares(arg0: &ContractStock) : u64 {
        arg0.shares
    }

    public fun get_user_shares(arg0: &Shares) : u64 {
        arg0.value
    }

    fun init(arg0: OPEN_ART_MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<OPEN_ART_MARKET>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun merge_contract_stocks(arg0: &mut ContractStock, arg1: ContractStock) {
        assert!(arg0.contract_id == arg1.contract_id, 1);
        arg0.shares = arg0.shares + burn_contract_stock(arg1);
    }

    public fun mint_contract_and_share(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(arg2 > 0, 5);
        assert!(arg3 > 0, 6);
        let v0 = Contract{
            id             : 0x2::object::new(arg10),
            total_supply   : arg1,
            shares         : arg1,
            share_price    : arg2,
            outgoing_price : arg2 * arg1 * arg3,
            multiplier     : arg3,
            name           : arg4,
            artist         : arg5,
            creation_date  : arg6,
            description    : arg7,
            currency       : arg8,
            image_url      : arg9,
        };
        0x2::transfer::public_share_object<Contract>(v0);
    }

    public fun mint_contract_stock(arg0: &mut AdminCap, arg1: &mut Contract, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.shares;
        assert!(arg2 <= v0, 0);
        arg1.shares = v0 - arg2;
        if (0x2::dynamic_field::exists_<address>(&arg1.id, arg3)) {
            let v1 = 0x2::dynamic_field::borrow_mut<address, Shares>(&mut arg1.id, arg3);
            v1.value = v1.value + arg2;
        } else {
            let v2 = Shares{value: arg2};
            0x2::dynamic_field::add<address, Shares>(&mut arg1.id, arg3, v2);
        };
        let v3 = ContractStock{
            id            : 0x2::object::new(arg4),
            contract_id   : 0x2::object::uid_to_inner(&arg1.id),
            shares        : arg2,
            share_price   : arg1.share_price,
            contract_name : arg1.name,
            artist        : arg1.artist,
            creation_date : arg1.creation_date,
            description   : arg1.description,
            currency      : arg1.currency,
            image_url     : arg1.image_url,
        };
        0x2::transfer::transfer<ContractStock>(v3, arg3);
    }

    public fun safe_burn_contract_stock(arg0: &Contract, arg1: ContractStock) : u64 {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.contract_id, 2);
        assert!(arg0.shares == 0, 3);
        burn_contract_stock(arg1)
    }

    public fun split_contract_stock(arg0: &mut ContractStock, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.shares > arg1, 0);
        let v0 = ContractStock{
            id            : 0x2::object::new(arg2),
            contract_id   : arg0.contract_id,
            shares        : arg1,
            share_price   : arg0.share_price,
            contract_name : arg0.contract_name,
            artist        : arg0.artist,
            creation_date : arg0.creation_date,
            description   : arg0.description,
            currency      : arg0.currency,
            image_url     : arg0.image_url,
        };
        arg0.shares = arg0.shares - arg1;
        0x2::transfer::transfer<ContractStock>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun transfer_contract_stock(arg0: &mut Contract, arg1: ContractStock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg2)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, Shares>(&mut arg0.id, arg2);
            v0.value = v0.value + arg1.shares;
        } else {
            let v1 = Shares{value: arg1.shares};
            0x2::dynamic_field::add<address, Shares>(&mut arg0.id, arg2, v1);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<address, Shares>(&mut arg0.id, 0x2::tx_context::sender(arg3));
        v2.value = v2.value - arg1.shares;
        0x2::transfer::transfer<ContractStock>(arg1, arg2);
    }

    public fun update_outgoing_price(arg0: &AdminCap, arg1: &mut Contract, arg2: u64) {
        arg1.outgoing_price = arg2;
    }

    // decompiled from Move bytecode v6
}

