module 0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::honeybugs {
    struct HONEYBUGS has drop {
        dummy_field: bool,
    }

    struct HoneybugsMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        mint_number: u64,
        genes: u256,
    }

    struct MintConfigUpdated has copy, drop {
        reserved_supply: u64,
        mint_start_time: u64,
    }

    struct AdminUpdated has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct HoneybugsUrlsUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        image_url: 0x1::string::String,
        full_body_url: 0x1::string::String,
        animation_url: 0x1::string::String,
    }

    struct Honeybugs has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        full_body_url: 0x1::string::String,
        animation_url: 0x1::string::String,
        attributes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        mint_number: u64,
        genes: u256,
        evolution_stage: u8,
    }

    struct HoneybugsCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        total_supply: u64,
        minted_count: u64,
        max_supply: u64,
        reserved_supply: u64,
        mint_start_time: u64,
        base_price: u64,
        curve_a: u64,
        admin: address,
        whitelist: 0x2::table::Table<address, u64>,
    }

    public fun add_kiosk_lock_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Honeybugs>, arg1: &0x2::transfer_policy::TransferPolicyCap<Honeybugs>, arg2: &mut 0x2::tx_context::TxContext) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Honeybugs>(arg0, arg1);
    }

    public fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<Honeybugs>, arg1: &0x2::transfer_policy::TransferPolicyCap<Honeybugs>, arg2: &mut 0x2::tx_context::TxContext) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Honeybugs>(arg0, arg1, 500, 0);
    }

    public fun add_to_whitelist(arg0: &mut HoneybugsCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.whitelist, arg1, arg2);
        };
    }

    fun add_vector_traits_to_table(arg0: &mut 0x2::table::Table<0x1::string::String, 0x1::string::String>, arg1: 0x1::string::String, arg2: vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg2)) {
            0x1::string::append(&mut arg1, u8_to_string(((v0 + 1) as u8)));
            0x2::table::add<0x1::string::String, 0x1::string::String>(arg0, arg1, u8_to_string(*0x1::vector::borrow<u8>(&arg2, v0)));
            v0 = v0 + 1;
        };
    }

    public fun admin_mint(arg0: &mut HoneybugsCollection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg0.minted_count < arg0.max_supply, 2);
        let v0 = arg0.minted_count + 1;
        0x2::transfer::public_transfer<Honeybugs>(internal_mint(arg0, v0, arg1, arg2), arg1);
    }

    public fun batch_mint(arg0: &mut HoneybugsCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 10, 5);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.mint_start_time, 6);
        assert!(arg0.minted_count + arg2 <= arg0.max_supply - arg0.reserved_supply, 7);
        assert!(arg0.minted_count + arg2 <= arg0.max_supply, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2, _) = simulate_mint_cost(arg0, v0, arg2);
        let v4 = v1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 3);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg4), arg0.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        let v5 = 0;
        let v6 = 0;
        while (v6 < arg2) {
            if (*0x1::vector::borrow<u64>(&v4, v6) == 0) {
                v5 = v5 + 1;
            };
            v6 = v6 + 1;
        };
        if (v5 > 0) {
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, v0);
            *v7 = *v7 - v5;
        };
        v6 = 0;
        while (v6 < arg2) {
            let v8 = arg0.minted_count + 1;
            0x2::transfer::public_transfer<Honeybugs>(internal_mint(arg0, v8, v0, arg4), v0);
            v6 = v6 + 1;
        };
    }

    fun generate_genes(arg0: u64, arg1: address, arg2: &0x2::tx_context::TxContext) : u256 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        let v1 = 0x2::tx_context::epoch(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::generate_genesis_genes_with_tier(v0, (arg0 - 1) / 1000)
    }

    public fun get_appearance_traits(arg0: &Honeybugs) : vector<u8> {
        0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::decode_dominant_appearance_traits(arg0.genes)
    }

    public fun get_collection_info(arg0: &HoneybugsCollection) : (0x1::string::String, 0x1::string::String, u64, u64, u64) {
        (arg0.name, arg0.description, arg0.total_supply, arg0.minted_count, arg0.max_supply)
    }

    public fun get_evolution_stage(arg0: &Honeybugs) : u8 {
        arg0.evolution_stage
    }

    public fun get_genes(arg0: &Honeybugs) : u256 {
        arg0.genes
    }

    public fun get_honeybugs_info(arg0: &Honeybugs) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u256, u8) {
        (arg0.name, arg0.description, arg0.image_url, arg0.full_body_url, arg0.animation_url, arg0.mint_number, arg0.genes, arg0.evolution_stage)
    }

    public fun get_power_traits(arg0: &Honeybugs) : vector<u8> {
        0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::decode_dominant_power_traits(arg0.genes)
    }

    public fun get_whitelist_count(arg0: &HoneybugsCollection, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)
        } else {
            0
        }
    }

    fun init(arg0: HONEYBUGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HONEYBUGS>(arg0, arg1);
        let v1 = 0x2::display::new<Honeybugs>(&v0, arg1);
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"full_body_url"), 0x1::string::utf8(b"{full_body_url}"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"animation_url"), 0x1::string::utf8(b"{animation_url}"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://honeyplay.fun"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://app.honeyplay.fun"));
        0x2::display::add<Honeybugs>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"HoneyPlay"));
        0x2::display::update_version<Honeybugs>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Honeybugs>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_collection(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = HoneybugsCollection{
            id              : 0x2::object::new(arg5),
            name            : 0x1::string::utf8(b"HoneyBugs"),
            description     : 0x1::string::utf8(b"The Genesis Collection of 10,000 HoneyBugs. Each HoneyBug is a DNA-driven NFT with 256-bit genes controlling appearance, traits, and power. Evolve, breed, and battle. Genesis holders share 5% of total HONEY supply. Your entry into the Hive."),
            image_url       : 0x1::string::utf8(b"https://assets.honeyplay.fun/honeybugs/collection/cover.png"),
            total_supply    : 0,
            minted_count    : 0,
            max_supply      : 10000,
            reserved_supply : arg3,
            mint_start_time : arg4,
            base_price      : arg1,
            curve_a         : arg2,
            admin           : 0x2::tx_context::sender(arg5),
            whitelist       : 0x2::table::new<address, u64>(arg5),
        };
        let (v1, v2) = 0x2::transfer_policy::new<Honeybugs>(arg0, arg5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Honeybugs>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Honeybugs>>(v2, 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<HoneybugsCollection>(v0);
    }

    fun internal_mint(arg0: &mut HoneybugsCollection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Honeybugs {
        let v0 = generate_genes(arg1, arg2, arg3);
        let v1 = 0;
        let v2 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg3);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"Evolution Stage"), u8_to_string(v1));
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"DNA"), u256_to_string(v0));
        let v3 = &mut v2;
        add_vector_traits_to_table(v3, 0x1::string::utf8(b"Appearance Trait "), 0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::decode_dominant_appearance_traits(v0));
        let v4 = &mut v2;
        add_vector_traits_to_table(v4, 0x1::string::utf8(b"Power Trait "), 0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::decode_dominant_power_traits(v0));
        let v5 = 0x2::object::new(arg3);
        let v6 = 0x1::string::utf8(b"https://assets.honeyplay.fun/honeybugs/");
        0x1::string::append(&mut v6, 0x2::address::to_string(0x2::object::uid_to_address(&v5)));
        0x1::string::append(&mut v6, 0x1::string::utf8(b"/dp.png"));
        0x1::string::append(&mut v6, 0x1::string::utf8(b"/full_body.png"));
        0x1::string::append(&mut v6, 0x1::string::utf8(b"/model.glb"));
        let v7 = Honeybugs{
            id              : v5,
            name            : 0x1::string::utf8(b"Honeybugs"),
            description     : 0x1::string::utf8(x"4120486f6e6579427567204e46542e20497473203235362d62697420444e41206973206974732064657374696e7920e2809420756e6971756520617070656172616e63652c207472616974732c20616e642065766f6c7574696f6e207061746820696e2074686520486f6e6579706c61792065636f73797374656d2e"),
            image_url       : v6,
            full_body_url   : v6,
            animation_url   : v6,
            attributes      : v2,
            mint_number     : arg1,
            genes           : v0,
            evolution_stage : v1,
        };
        arg0.minted_count = arg0.minted_count + 1;
        arg0.total_supply = arg0.total_supply + 1;
        let v8 = HoneybugsMinted{
            nft_id      : 0x2::object::uid_to_inner(&v7.id),
            recipient   : arg2,
            mint_number : arg1,
            genes       : v0,
        };
        0x2::event::emit<HoneybugsMinted>(v8);
        v7
    }

    public fun is_whitelisted(arg0: &HoneybugsCollection, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.whitelist, arg1)
    }

    public fun mint(arg0: &mut HoneybugsCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.mint_start_time, 6);
        assert!(arg0.minted_count < arg0.max_supply - arg0.reserved_supply, 7);
        assert!(arg0.minted_count < arg0.max_supply, 2);
        let v0 = arg0.minted_count + 1;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = get_whitelist_count(arg0, v1);
        let v3 = if (v2 > 0) {
            0
        } else {
            0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::compute_gene_price(arg0.base_price, arg0.curve_a, arg0.minted_count)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 3);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg3), arg0.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        if (v2 > 0) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, v1);
            *v4 = *v4 - 1;
        };
        0x2::transfer::public_transfer<Honeybugs>(internal_mint(arg0, v0, v1, arg3), v1);
    }

    public fun remove_from_whitelist(arg0: &mut HoneybugsCollection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.whitelist, arg1);
        };
    }

    public fun simulate_mint_cost(arg0: &HoneybugsCollection, arg1: address, arg2: u64) : (vector<u64>, u64, u64) {
        assert!(arg2 > 0, 4);
        assert!(arg0.minted_count + arg2 <= arg0.max_supply, 2);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        let v2 = arg0.minted_count;
        let v3 = 0;
        let v4 = 0;
        while (v4 < arg2) {
            let v5 = 0x3b24f68b7042bf8ba5214395886ff24ca51b1b5636eac45e52631512bee16653::genescience::compute_gene_price(arg0.base_price, arg0.curve_a, v2);
            if (v3 < get_whitelist_count(arg0, arg1)) {
                0x1::vector::push_back<u64>(&mut v0, 0);
                v3 = v3 + 1;
            } else {
                0x1::vector::push_back<u64>(&mut v0, v5);
                v1 = v1 + v5;
            };
            v2 = v2 + 1;
            v4 = v4 + 1;
        };
        (v0, v1, arg2)
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
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, ((arg0 % 16) as u64)));
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

    public fun update_admin(arg0: &mut HoneybugsCollection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
        let v0 = AdminUpdated{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminUpdated>(v0);
    }

    public fun update_mint_config(arg0: &mut HoneybugsCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.reserved_supply = arg1;
        arg0.mint_start_time = arg2;
        let v0 = MintConfigUpdated{
            reserved_supply : arg1,
            mint_start_time : arg2,
        };
        0x2::event::emit<MintConfigUpdated>(v0);
    }

    public fun update_nft_description(arg0: &HoneybugsCollection, arg1: &mut Honeybugs, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg1.description = arg2;
    }

    public fun update_nft_name(arg0: &HoneybugsCollection, arg1: &mut Honeybugs, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg1.name = arg2;
    }

    public fun update_nft_urls(arg0: &HoneybugsCollection, arg1: &mut Honeybugs, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        arg1.image_url = arg2;
        arg1.full_body_url = arg3;
        arg1.animation_url = arg4;
        let v0 = HoneybugsUrlsUpdated{
            nft_id        : 0x2::object::uid_to_inner(&arg1.id),
            image_url     : arg2,
            full_body_url : arg3,
            animation_url : arg4,
        };
        0x2::event::emit<HoneybugsUrlsUpdated>(v0);
    }

    public fun update_pricing(arg0: &mut HoneybugsCollection, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.base_price = arg1;
        arg0.curve_a = arg2;
    }

    public fun update_whitelist_count(arg0: &mut HoneybugsCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x2::table::contains<address, u64>(&arg0.whitelist, arg1), 1);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist, arg1) = arg2;
    }

    // decompiled from Move bytecode v6
}

