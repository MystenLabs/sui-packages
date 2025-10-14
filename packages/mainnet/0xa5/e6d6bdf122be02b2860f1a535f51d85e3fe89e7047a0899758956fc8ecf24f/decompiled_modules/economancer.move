module 0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::economancer {
    struct ECONOMANCER has drop {
        dummy_field: bool,
    }

    struct EconoMancerMinted has copy, drop {
        bug_id: 0x2::object::ID,
        recipient: address,
        mint_number: u64,
        genes: u256,
    }

    struct EconoMancer has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        mint_number: u64,
        rarity: u8,
        genes: u256,
        evolution_stage: u8,
    }

    struct EconoMancerCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        total_supply: u64,
        minted_count: u64,
        max_supply: u64,
        base_price: u64,
        curve_a: u64,
        admin: address,
        whitelist: 0x2::table::Table<address, u64>,
    }

    public fun add_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<EconoMancer>, arg1: &0x2::transfer_policy::TransferPolicyCap<EconoMancer>, arg2: &mut 0x2::tx_context::TxContext) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<EconoMancer>(arg0, arg1);
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<EconoMancer>, arg1: &0x2::transfer_policy::TransferPolicyCap<EconoMancer>, arg2: &mut 0x2::tx_context::TxContext) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<EconoMancer>(arg0, arg1, (500 as u16), 0);
    }

    public fun add_to_whitelist(arg0: &mut EconoMancerCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.whitelist, arg1, arg2);
        };
    }

    public fun batch_mint(arg0: &mut EconoMancerCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(arg2 <= 10, 2);
        assert!(arg0.minted_count + arg2 <= arg0.max_supply, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, _, _) = simulate_mint_cost(arg0, v0, arg2);
        let v4 = v1;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v6 < arg2) {
            if (*0x1::vector::borrow<u64>(&v4, v6) == 0) {
                v7 = v7 + 1;
            };
            v5 = v5 + *0x1::vector::borrow<u64>(&v4, v6);
            v6 = v6 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v5, 3);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v5, arg3), arg0.admin);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (v7 > 0) {
            let v8 = if (v7 >= arg2) {
                arg2
            } else {
                v7
            };
            let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, v0);
            *v9 = *v9 - v8;
        };
        let v10 = arg0.minted_count;
        let v11 = 0;
        while (v11 < arg2) {
            v10 = v10 + 1;
            let v12 = internal_mint(arg0, v10, v0, arg3);
            0x2::transfer::public_transfer<EconoMancer>(v12, v0);
            v11 = v11 + 1;
        };
        arg0.minted_count = arg0.minted_count + arg2;
        arg0.total_supply = arg0.total_supply + arg2;
    }

    fun generate_genes(arg0: u64, arg1: address, arg2: &0x2::tx_context::TxContext) : u256 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        let v1 = 0x2::tx_context::epoch(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::generate_genesis_genes_with_tier(v0, (arg0 - 1) / 1000)
    }

    public fun get_appearance_traits(arg0: &EconoMancer) : vector<u8> {
        0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::decode_dominant_appearance_traits(arg0.genes)
    }

    public fun get_collection_info(arg0: &EconoMancerCollection) : (0x1::string::String, 0x1::string::String, u64, u64, u64) {
        (arg0.name, arg0.description, arg0.total_supply, arg0.minted_count, arg0.max_supply)
    }

    public fun get_evolution_stage(arg0: &EconoMancer) : u8 {
        arg0.evolution_stage
    }

    public fun get_genes(arg0: &EconoMancer) : u256 {
        arg0.genes
    }

    public fun get_necromancer_info(arg0: &EconoMancer) : (0x1::string::String, 0x1::string::String, u64, u8, u256, u8) {
        (arg0.name, arg0.description, arg0.mint_number, arg0.rarity, arg0.genes, arg0.evolution_stage)
    }

    public fun get_power_traits(arg0: &EconoMancer) : vector<u8> {
        0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::decode_dominant_power_traits(arg0.genes)
    }

    public fun get_whitelist_count(arg0: &EconoMancerCollection, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)
        } else {
            0
        }
    }

    fun init(arg0: ECONOMANCER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ECONOMANCER>(arg0, arg1);
        let v1 = 0x2::display::new<EconoMancer>(&v0, arg1);
        0x2::display::add<EconoMancer>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<EconoMancer>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EconoMancer>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<EconoMancer>(&mut v1, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<EconoMancer>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EconoMancer>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_collection(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = EconoMancerCollection{
            id           : 0x2::object::new(arg3),
            name         : 0x1::string::utf8(b"EconoMancers"),
            description  : 0x1::string::utf8(b"A collection of magical EconoMancers that live in the Sui ecosystem"),
            image_url    : 0x1::string::utf8(b"https://assets.honeyplay.fun/necromancers/collection.png"),
            total_supply : 0,
            minted_count : 0,
            max_supply   : 15000,
            base_price   : arg1,
            curve_a      : arg2,
            admin        : 0x2::tx_context::sender(arg3),
            whitelist    : 0x2::table::new<address, u64>(arg3),
        };
        let (v1, v2) = 0x2::transfer_policy::new<EconoMancer>(arg0, arg3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EconoMancer>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EconoMancer>>(v2, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<EconoMancerCollection>(v0);
    }

    fun internal_mint(arg0: &mut EconoMancerCollection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : EconoMancer {
        let v0 = generate_genes(arg1, arg2, arg3);
        let v1 = 0;
        let v2 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg3);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"DNA"), u256_to_string(v0));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Evolution Stage"), u8_to_string(v1));
        let v3 = 0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::decode_dominant_appearance_traits(v0);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 1"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 0)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 2"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 1)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 3"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 2)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 4"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 3)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 5"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 4)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 6"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 5)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Appearance Trait 7"), u8_to_string(*0x1::vector::borrow<u8>(&v3, 6)));
        let v4 = 0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::decode_dominant_power_traits(v0);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 1"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 0)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 2"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 1)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 3"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 2)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 4"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 3)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 5"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 4)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 6"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 5)));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Power Trait 7"), u8_to_string(*0x1::vector::borrow<u8>(&v4, 6)));
        let v5 = if (arg1 % 100 == 0) {
            5
        } else if (arg1 % 20 == 0) {
            4
        } else if (arg1 % 10 == 0) {
            3
        } else if (arg1 % 5 == 0) {
            2
        } else {
            1
        };
        let v6 = if (arg1 % 100 == 0) {
            0x1::string::utf8(b"Legendary EconoMancer")
        } else if (arg1 % 20 == 0) {
            0x1::string::utf8(b"Epic EconoMancer")
        } else if (arg1 % 10 == 0) {
            0x1::string::utf8(b"Rare EconoMancer")
        } else if (arg1 % 5 == 0) {
            0x1::string::utf8(b"Uncommon EconoMancer")
        } else {
            0x1::string::utf8(b"EconoMancer")
        };
        let v7 = EconoMancer{
            id              : 0x2::object::new(arg3),
            name            : v6,
            description     : 0x1::string::utf8(b"A magical EconoMancer from the Sui ecosystem with unique genetic DNA"),
            image_url       : 0x1::string::utf8(b"https://assets.honeyplay.fun/necromancers/bug.png"),
            attributes      : v2,
            mint_number     : arg1,
            rarity          : v5,
            genes           : v0,
            evolution_stage : v1,
        };
        arg0.minted_count = arg0.minted_count + 1;
        arg0.total_supply = arg0.total_supply + 1;
        let v8 = EconoMancerMinted{
            bug_id      : 0x2::object::uid_to_inner(&v7.id),
            recipient   : arg2,
            mint_number : arg1,
            genes       : v0,
        };
        0x2::event::emit<EconoMancerMinted>(v8);
        v7
    }

    public fun is_whitelisted(arg0: &EconoMancerCollection, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.whitelist, arg1)
    }

    public fun mint(arg0: &mut EconoMancerCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted_count < arg0.max_supply, 0);
        let v0 = arg0.minted_count + 1;
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.whitelist, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.whitelist, v1)
        } else {
            0
        };
        let v3 = if (v2 > 0) {
            0
        } else {
            0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::compute_gene_price(arg0.base_price, arg0.curve_a, arg0.minted_count)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 1);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg2), arg0.admin);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (v2 > 0) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, v1);
            *v4 = *v4 - 1;
        };
        0x2::transfer::public_transfer<EconoMancer>(internal_mint(arg0, v0, v1, arg2), v1);
    }

    public fun remove_from_whitelist(arg0: &mut EconoMancerCollection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.whitelist, arg1);
        };
    }

    public fun simulate_mint_cost(arg0: &EconoMancerCollection, arg1: address, arg2: u64) : (vector<u64>, u64, u64) {
        assert!(arg2 > 0, 0);
        assert!(arg0.minted_count + arg2 <= arg0.max_supply, 1);
        let v0 = if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)
        } else {
            0
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        let v3 = arg0.minted_count;
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg2) {
            let v6 = 0xa5e6d6bdf122be02b2860f1a535f51d85e3fe89e7047a0899758956fc8ecf24f::genescience::compute_gene_price(arg0.base_price, arg0.curve_a, v3);
            if (v4 < v0) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                v4 = v4 + 1;
            } else {
                0x1::vector::push_back<u64>(&mut v1, v6);
                v2 = v2 + v6;
            };
            v3 = v3 + 1;
            v5 = v5 + 1;
        };
        (v1, v2, arg2)
    }

    fun u256_to_string(arg0: u256) : 0x1::string::String {
        let v0 = b"0123456789abcdef";
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 48);
        0x1::vector::push_back<u8>(&mut v1, 120);
        let v2 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v2, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, (((arg0 % 16) as u8) as u64)));
                arg0 = arg0 / 16;
            };
            0x1::vector::reverse<u8>(&mut v2);
        };
        0x1::vector::append<u8>(&mut v1, v2);
        0x1::string::utf8(v1)
    }

    fun u8_to_string(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            let v1 = 0x1::vector::empty<u8>();
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v1, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            0x1::vector::reverse<u8>(&mut v1);
            0x1::vector::append<u8>(&mut v0, v1);
        };
        0x1::string::utf8(v0)
    }

    public fun update_pricing(arg0: &mut EconoMancerCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.base_price = arg1;
        arg0.curve_a = arg2;
    }

    public fun update_whitelist_count(arg0: &mut EconoMancerCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist, arg1), 1);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

