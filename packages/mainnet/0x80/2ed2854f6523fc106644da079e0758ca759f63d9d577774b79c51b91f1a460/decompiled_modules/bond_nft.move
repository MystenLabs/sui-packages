module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::bond_nft {
    struct BondNFTRegistry has key {
        id: 0x2::object::UID,
        bills: 0x2::table::Table<u64, address>,
        next_bill_id: u64,
        admin: address,
        uri_setters: 0x2::table::Table<address, bool>,
    }

    struct BondNFT has store, key {
        id: 0x2::object::UID,
        bill_id: u64,
        bond_market: address,
        uri: 0x1::string::String,
    }

    struct BillMinted has copy, drop {
        bill_id: u64,
        nft_address: address,
        owner: address,
        bond_market: address,
    }

    struct BillBurned has copy, drop {
        bill_id: u64,
        owner: address,
    }

    struct URIUpdated has copy, drop {
        bill_id: u64,
        new_uri: 0x1::string::String,
    }

    public fun add_uri_setter(arg0: &mut BondNFTRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 9);
        if (0x2::table::contains<address, bool>(&arg0.uri_setters, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.uri_setters, arg1) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg0.uri_setters, arg1, true);
        };
    }

    public fun bill_exists(arg0: &BondNFTRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, address>(&arg0.bills, arg1)
    }

    public fun bill_id(arg0: &BondNFT) : u64 {
        arg0.bill_id
    }

    public fun bond_market(arg0: &BondNFT) : address {
        arg0.bond_market
    }

    public fun burn(arg0: &mut BondNFTRegistry, arg1: BondNFT, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg1.bill_id;
        if (0x2::table::contains<u64, address>(&arg0.bills, v0)) {
            0x2::table::remove<u64, address>(&mut arg0.bills, v0);
        };
        let BondNFT {
            id          : v1,
            bill_id     : _,
            bond_market : _,
            uri         : _,
        } = arg1;
        0x2::object::delete(v1);
        let v5 = BillBurned{
            bill_id : v0,
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BillBurned>(v5);
    }

    fun generate_token_uri(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://apebond.com/api/bill/");
        0x1::string::append(&mut v0, u64_to_string(arg0));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v0, 0x2::tx_context::sender(arg0), true);
        let v1 = BondNFTRegistry{
            id           : 0x2::object::new(arg0),
            bills        : 0x2::table::new<u64, address>(arg0),
            next_bill_id : 1,
            admin        : 0x2::tx_context::sender(arg0),
            uri_setters  : v0,
        };
        0x2::transfer::share_object<BondNFTRegistry>(v1);
    }

    public fun is_uri_setter(arg0: &BondNFTRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.uri_setters, arg1) && *0x2::table::borrow<address, bool>(&arg0.uri_setters, arg1)
    }

    public fun mint(arg0: &mut BondNFTRegistry, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg0.next_bill_id;
        arg0.next_bill_id = v0 + 1;
        let v1 = BondNFT{
            id          : 0x2::object::new(arg3),
            bill_id     : v0,
            bond_market : arg2,
            uri         : generate_token_uri(v0),
        };
        let v2 = 0x2::object::id_address<BondNFT>(&v1);
        0x2::table::add<u64, address>(&mut arg0.bills, v0, v2);
        let v3 = BillMinted{
            bill_id     : v0,
            nft_address : v2,
            owner       : arg1,
            bond_market : arg2,
        };
        0x2::event::emit<BillMinted>(v3);
        0x2::transfer::transfer<BondNFT>(v1, arg1);
        v0
    }

    public fun next_bill_id(arg0: &BondNFTRegistry) : u64 {
        arg0.next_bill_id
    }

    public fun nft_address(arg0: &BondNFTRegistry, arg1: u64) : address {
        assert!(0x2::table::contains<u64, address>(&arg0.bills, arg1), 2);
        *0x2::table::borrow<u64, address>(&arg0.bills, arg1)
    }

    public fun remove_uri_setter(arg0: &mut BondNFTRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 9);
        if (0x2::table::contains<address, bool>(&arg0.uri_setters, arg1)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.uri_setters, arg1) = false;
        };
    }

    public fun set_token_uri(arg0: &BondNFTRegistry, arg1: &mut BondNFT, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, bool>(&arg0.uri_setters, v0) && *0x2::table::borrow<address, bool>(&arg0.uri_setters, v0), 8);
        arg1.uri = arg2;
        let v1 = URIUpdated{
            bill_id : arg1.bill_id,
            new_uri : arg1.uri,
        };
        0x2::event::emit<URIUpdated>(v1);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun uri(arg0: &BondNFT) : 0x1::string::String {
        arg0.uri
    }

    // decompiled from Move bytecode v7
}

