module 0x75163e4841a873246a0bfdf3a4eb3fb78cc168a141ee221f1eac824efdd3fd7f::fundraise {
    struct FUNDRAISE has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        sui_sold: u64,
        osiri_sold: u64,
        claim_live: bool,
        sui_deposits: 0x2::table::Table<address, u64>,
        osiri_bought: 0x2::table::Table<address, u64>,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        allocations: 0x2::table::Table<address, u64>,
    }

    struct AllocationNFT has store, key {
        id: 0x2::object::UID,
        amount: u64,
        pool: u8,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    public entry fun claim(arg0: &Config, arg1: AllocationNFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claim_live, 2);
        0x2::tx_context::sender(arg2);
        let AllocationNFT {
            id        : v0,
            amount    : _,
            pool      : _,
            name      : _,
            image_url : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun allocation_for(arg0: &Whitelist, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.allocations, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.allocations, arg1)
        } else {
            0
        }
    }

    public entry fun buy_with_osiri(arg0: &mut Config, arg1: &Whitelist, arg2: 0x2::coin::Coin<0x42e826aa6c71325e2aaaf031976e023d75eefe584116f9349de5b0e56e648e49::osiri::OSIRI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x42e826aa6c71325e2aaaf031976e023d75eefe584116f9349de5b0e56e648e49::osiri::OSIRI>(&arg2);
        assert!(v1 > 0, 7);
        assert!(0x2::table::contains<address, u64>(&arg1.allocations, v0), 5);
        let v2 = v1 / 50000000;
        assert!(v2 > 0, 7);
        let v3 = v2 * 1000000000;
        let v4 = if (0x2::table::contains<address, u64>(&arg0.osiri_bought, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.osiri_bought, v0)
        } else {
            0
        };
        let v5 = v4 + v3;
        assert!(v5 <= *0x2::table::borrow<address, u64>(&arg1.allocations, v0), 8);
        if (v4 == 0) {
            0x2::table::add<address, u64>(&mut arg0.osiri_bought, v0, v3);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.osiri_bought, v0) = v5;
        };
        let v6 = arg0.osiri_sold + v3;
        assert!(v6 <= 55000000000000000, 4);
        arg0.osiri_sold = v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x42e826aa6c71325e2aaaf031976e023d75eefe584116f9349de5b0e56e648e49::osiri::OSIRI>>(arg2, arg0.owner);
        0x2::transfer::public_transfer<AllocationNFT>(mint_nft(v2, 1, arg3), v0);
    }

    public entry fun buy_with_sui(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 7);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.sui_deposits, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.sui_deposits, v0)
        } else {
            0
        };
        let v3 = v2 + v1;
        assert!(v3 <= 40000000000, 6);
        if (0x2::table::contains<address, u64>(&arg0.sui_deposits, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.sui_deposits, v0) = v3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.sui_deposits, v0, v3);
        };
        let v4 = v1 / 34120;
        assert!(v4 > 0, 7);
        let v5 = arg0.sui_sold + v4 * 1000000000;
        assert!(v5 <= 15000000000000000, 3);
        arg0.sui_sold = v5;
        transfer_sui_to_owner(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg2);
        0x2::transfer::public_transfer<AllocationNFT>(mint_nft(v4, 0, arg2), v0);
    }

    public entry fun enable_claim(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.claim_live = true;
    }

    fun init(arg0: FUNDRAISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Whitelist{
            id          : 0x2::object::new(arg1),
            allocations : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Whitelist>(v0);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = Config{
            id           : 0x2::object::new(arg1),
            owner        : v1,
            sui_sold     : 0,
            osiri_sold   : 0,
            claim_live   : false,
            sui_deposits : 0x2::table::new<address, u64>(arg1),
            osiri_bought : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Config>(v2);
        let v3 = 0x2::package::claim<FUNDRAISE>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"PONZI Token Allocation NFT"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://ponzicoin.io"));
        let v8 = 0x2::display::new_with_fields<AllocationNFT>(&v3, v4, v6, arg1);
        0x2::display::update_version<AllocationNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v1);
        0x2::transfer::public_transfer<0x2::display::Display<AllocationNFT>>(v8, v1);
    }

    public fun is_claim_live(arg0: &Config) : bool {
        arg0.claim_live
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.allocations, arg1)
    }

    fun mint_nft(arg0: u64, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : AllocationNFT {
        AllocationNFT{
            id        : 0x2::object::new(arg2),
            amount    : arg0,
            pool      : arg1,
            name      : 0x1::string::utf8(b"PONZI Sale Participation"),
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Mk4J8mwY/ponziallo.png"),
        }
    }

    public fun osiri_bought_by(arg0: &Config, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.osiri_bought, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.osiri_bought, arg1)
        } else {
            0
        }
    }

    public fun osiri_pool_sold(arg0: &Config) : u64 {
        arg0.osiri_sold
    }

    public entry fun set_allocations(arg0: &Config, arg1: &mut Whitelist, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 == 0x1::vector::length<u64>(&arg3), 7);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, u64>(&arg1.allocations, v2)) {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.allocations, v2) = *0x1::vector::borrow<u64>(&arg3, v0);
            } else {
                0x2::table::add<address, u64>(&mut arg1.allocations, v2, *0x1::vector::borrow<u64>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun sui_deposited_by(arg0: &Config, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.sui_deposits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.sui_deposits, arg1)
        } else {
            0
        }
    }

    public fun sui_pool_sold(arg0: &Config) : u64 {
        arg0.sui_sold
    }

    fun transfer_balance_to_owner<T0: store + key>(arg0: &Config, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), arg0.owner);
    }

    fun transfer_sui_to_owner(arg0: &Config, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg2), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

