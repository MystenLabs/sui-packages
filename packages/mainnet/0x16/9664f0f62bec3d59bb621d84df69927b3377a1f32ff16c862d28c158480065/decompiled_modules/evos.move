module 0x169664f0f62bec3d59bb621d84df69927b3377a1f32ff16c862d28c158480065::evos {
    struct EVOS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Evos has store, key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        stage: 0x1::string::String,
        level: u32,
        species: 0x1::string::String,
        xp: u32,
        gems: u32,
        url: 0x2::url::Url,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct Incubator has key {
        id: 0x2::object::UID,
        inhold: u64,
        specs: vector<Specie>,
        specs_tot_weight: u8,
        index: u64,
        slots: vector<0x2::object::ID>,
        version: u64,
        mint_cap: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<Evos>,
        evos_created: vector<0x2::object::ID>,
    }

    struct Slot has store, key {
        id: 0x2::object::UID,
        deposit_at: u64,
        owner: address,
    }

    struct Specie has store {
        name: 0x1::string::String,
        weight: u8,
        url: vector<u8>,
    }

    public fun url(arg0: &Evos) : 0x2::url::Url {
        arg0.url
    }

    public entry fun add_specie(arg0: &AdminCap, arg1: &mut Incubator, arg2: 0x1::string::String, arg3: u8, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.specs_tot_weight + arg3 < 255, 12);
        let v0 = 0;
        while (0x1::vector::length<Specie>(&arg1.specs) > v0) {
            if (0x1::vector::borrow<Specie>(&arg1.specs, v0).weight > arg3) {
                0x1::vector::insert<Specie>(&mut arg1.specs, create_specie(arg2, arg3, arg4), v0);
                arg1.specs_tot_weight = arg1.specs_tot_weight + arg3;
                break
            };
            v0 = v0 + 1;
        };
    }

    public fun all_evos_ids(arg0: &Incubator) : vector<0x2::object::ID> {
        arg0.evos_created
    }

    public fun burn_evos(arg0: Evos) {
        let Evos {
            id         : v0,
            index      : _,
            name       : _,
            stage      : _,
            level      : _,
            species    : _,
            xp         : _,
            gems       : _,
            url        : _,
            attributes : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun create_evos(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Evos>, arg1: &mut Incubator, arg2: &mut 0x2::tx_context::TxContext) : Evos {
        arg1.index = arg1.index + 1;
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1.index));
        let v1 = 0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::rand_no_counter(v0, arg2);
        let v2 = draw_specie(&arg1.specs, select((arg1.specs_tot_weight as u64), &v1));
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(b"gems"));
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(b"xp"));
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(b"species"));
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(b"stage"));
        0x1::vector::push_back<0x1::ascii::String>(v4, 0x1::ascii::string(b"level"));
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::ascii::string(b"0"));
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::ascii::string(b"0"));
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::string::to_ascii(v2.name));
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::ascii::string(b"Egg"));
        0x1::vector::push_back<0x1::ascii::String>(v6, 0x1::ascii::string(b"1"));
        let v7 = Evos{
            id         : 0x2::object::new(arg2),
            index      : arg1.index,
            name       : 0x1::string::utf8(b"Evos"),
            stage      : 0x1::string::utf8(b"Egg"),
            level      : 1,
            species    : v2.name,
            xp         : 0,
            gems       : 0,
            url        : 0x2::url::new_unsafe_from_bytes(v2.url),
            attributes : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::from_vec(v3, v5),
        };
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<Evos>(arg0, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<Evos>(&arg1.mint_cap), &v7);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::increment_supply<Evos>(&mut arg1.mint_cap, 1);
        v7
    }

    fun create_specie(arg0: 0x1::string::String, arg1: u8, arg2: vector<u8>) : Specie {
        Specie{
            name   : arg0,
            weight : arg1,
            url    : arg2,
        }
    }

    public entry fun deposit(arg0: &mut Incubator, arg1: 0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::EvosGenesisEgg, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 7);
        let v0 = Slot{
            id         : 0x2::object::new(arg3),
            deposit_at : 0x2::clock::timestamp_ms(arg2),
            owner      : 0x2::tx_context::sender(arg3),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.slots, 0x2::object::id<Slot>(&v0));
        0x2::dynamic_object_field::add<bool, 0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::EvosGenesisEgg>(&mut v0.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Slot>(&mut arg0.id, 0x2::object::id<Slot>(&v0), v0);
        arg0.inhold = arg0.inhold + 1;
    }

    public entry fun disable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Evos, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Evos, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Evos>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    fun draw_specie(arg0: &vector<Specie>, arg1: u64) : &Specie {
        let v0 = 0;
        let v1 = 0;
        while (0x1::vector::length<Specie>(arg0) > v1) {
            let v2 = 0x1::vector::borrow<Specie>(arg0, v1);
            v0 = v0 + v2.weight;
            if (arg1 <= (v0 as u64)) {
                return v2
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow<Specie>(arg0, 0x1::vector::length<Specie>(arg0) - 1)
    }

    public entry fun enable_orderbook(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<Evos, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<Evos, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Evos>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    public fun gems(arg0: &Evos) : u32 {
        arg0.gems
    }

    public fun get_evos_id_at(arg0: &Incubator, arg1: u64) : 0x2::object::ID {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.evos_created) > arg1, 0);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.evos_created, arg1)
    }

    public fun get_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, Evos>) : Evos {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft<T0, Evos>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Evos, Witness>(v0), arg0)
    }

    public fun get_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, Evos>) : (T1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<Evos, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Evos, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_field<Evos, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, Evos>(v1, arg0).id)
    }

    public entry fun get_slot_owner(arg0: 0x2::object::ID, arg1: &Incubator, arg2: &mut 0x2::tx_context::TxContext) : address {
        owner(0x2::dynamic_object_field::borrow<0x2::object::ID, Slot>(&arg1.id, arg0))
    }

    public entry fun get_slot_revealable_at(arg0: 0x2::object::ID, arg1: &Incubator, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        revealable_at(0x2::dynamic_object_field::borrow<0x2::object::ID, Slot>(&arg1.id, arg0))
    }

    public fun get_slots_id(arg0: &Incubator, arg1: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        arg0.slots
    }

    public entry fun give_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun has_attribute(arg0: &mut Evos, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::ascii::string(arg1);
        0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::get_attributes(&arg0.attributes), &v0)
    }

    public fun index(arg0: &Incubator) : u64 {
        arg0.index
    }

    public fun inhold(arg0: &Incubator) : u64 {
        arg0.inhold
    }

    fun init(arg0: EVOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<EVOS, Evos>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<EVOS>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Evos, Witness>(v5);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v8, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::collectible());
        let v9 = 0x2::display::new<Evos>(&v4, arg1);
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{index}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"species"), 0x1::string::utf8(b"{species}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"stage"), 0x1::string::utf8(b"{stage}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"xp"), 0x1::string::utf8(b"{xp}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"gems"), 0x1::string::utf8(b"{gems}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Evos>(&mut v9, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v7));
        0x2::display::update_version<Evos>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<Evos>>(v9, 0x2::tx_context::sender(arg1));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Evos, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"ev0s"), 0x1::string::utf8(b"ev0s is an evolutionary NFT adventure that pushes Dynamic NFTs to their fullest potential on Sui")));
        let v10 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v10, @0x74a54d924aca2040b6c9800123ad9232105ea5796b8d5fc23af14dd3ce0f193f);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<Evos, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v10)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::create_domain_and_add_strategy<Evos>(v6, &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::from_shares(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::from_vec_to_map<address, u16>(v10, vector[10000]), arg1), 500, arg1);
        let (v11, v12) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Evos>(&v4, arg1);
        let v13 = v12;
        let v14 = v11;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::enforce<Evos>(&mut v14, &v13);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::transfer_allowlist::enforce<Evos>(&mut v14, &v13);
        let (v15, v16) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::init_policy<Evos>(&v4, arg1);
        let v17 = v16;
        let v18 = v15;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::p2p_list::enforce<Evos>(&mut v18, &v17);
        let v19 = Specie{
            name   : 0x1::string::utf8(b"Gold"),
            weight : 5,
            url    : b"https://knw-gp.s3.eu-north-1.amazonaws.com/species/gold.png",
        };
        let v20 = Specie{
            name   : 0x1::string::utf8(b"Forest"),
            weight : 20,
            url    : b"https://knw-gp.s3.eu-north-1.amazonaws.com/species/forest.png",
        };
        let v21 = Specie{
            name   : 0x1::string::utf8(b"Water"),
            weight : 24,
            url    : b"https://knw-gp.s3.eu-north-1.amazonaws.com/species/water.png",
        };
        let v22 = Specie{
            name   : 0x1::string::utf8(b"Rock"),
            weight : 25,
            url    : b"https://knw-gp.s3.eu-north-1.amazonaws.com/species/rock.png",
        };
        let v23 = Specie{
            name   : 0x1::string::utf8(b"Fire"),
            weight : 26,
            url    : b"https://knw-gp.s3.eu-north-1.amazonaws.com/species/fire.png",
        };
        let v24 = 0x1::vector::empty<Specie>();
        let v25 = &mut v24;
        0x1::vector::push_back<Specie>(v25, v19);
        0x1::vector::push_back<Specie>(v25, v20);
        0x1::vector::push_back<Specie>(v25, v21);
        0x1::vector::push_back<Specie>(v25, v22);
        0x1::vector::push_back<Specie>(v25, v23);
        let v26 = Incubator{
            id               : 0x2::object::new(arg1),
            inhold           : 0,
            specs            : v24,
            specs_tot_weight : 100,
            index            : 0,
            slots            : 0x1::vector::empty<0x2::object::ID>(),
            version          : 1,
            mint_cap         : v2,
            evos_created     : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v27 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v27, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Incubator>(v26);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Evos>>(v13, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Evos>>(v17, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<Evos>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Evos>>(v14);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Evos>>(v18);
    }

    public entry fun init_protected_orderbook(arg0: &0x2::package::Publisher, arg1: &0x2::transfer_policy::TransferPolicy<Evos>, arg2: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<Evos, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<Evos, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<Evos>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg2));
    }

    public fun level(arg0: &Evos) : u32 {
        arg0.level
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Incubator, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    public fun name(arg0: &Specie) : 0x1::string::String {
        arg0.name
    }

    fun new_kiosk_with_evos(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<Evos>, arg1: &mut Incubator, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_evos(arg0, arg1, arg3);
        let v1 = 0x2::object::id<Evos>(&v0);
        let (v2, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new_for_address(arg2, arg3);
        let v4 = v2;
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<Evos>(&mut v4, v0, arg3);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_transfer(&mut v4, v1, @0x1dae98dcae53909f23184b273923184aa451986c4b71da1950d749def37f8ea0, arg3);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_transfer(&mut v4, v1, @0x34f23af8106ecb5ada0c4ff956333ab234534a0060350f40b6e9518f861f7e02, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        register_new_evos(arg1, v1);
    }

    public fun owner(arg0: &Slot) : address {
        arg0.owner
    }

    fun register_new_evos(arg0: &mut Incubator, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.evos_created, arg1);
    }

    fun remove_attribute(arg0: &mut Evos, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(arg1);
        if (0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::get_attributes(&arg0.attributes), &v0)) {
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::remove_attribute<Witness, Evos>(&mut arg0.attributes, &v0);
        };
    }

    public fun return_nft<T0: drop>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, Evos>, arg1: Evos) {
        let v0 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_nft<T0, Evos>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Evos, Witness>(v0), arg0, arg1);
    }

    public fun return_nft_field<T0: drop, T1: store>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<T0, Evos>, arg1: T1, arg2: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::ReturnPromise<Evos, T1>) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Evos, Witness>(v0);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::return_field<Evos, T1>(v1, &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::borrow_nft_ref_mut<T0, Evos>(v1, arg0).id, arg2, arg1);
    }

    public entry fun reveal(arg0: &mut Incubator, arg1: &mut 0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::MintTracker, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 7);
        let Slot {
            id         : v0,
            deposit_at : v1,
            owner      : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Slot>(&mut arg0.id, arg2);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg4) == v2, 1);
        assert!(revealable_in(v1, arg3) == 0, 2);
        0x2::object::delete(v3);
        0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::burn_nft(arg1, 0x2::dynamic_object_field::remove<bool, 0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::EvosGenesisEgg>(&mut v3, true), arg4);
        let v4 = Witness{dummy_field: false};
        new_kiosk_with_evos(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<Evos, Witness>(v4), arg0, v2, arg4);
        arg0.inhold = arg0.inhold - 1;
        let v5 = 0;
        while (0x1::vector::length<0x2::object::ID>(&arg0.slots) > v5) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.slots, v5) == arg2) {
                break
            };
            v5 = v5 + 1;
        };
        0x1::vector::remove<0x2::object::ID>(&mut arg0.slots, v5);
    }

    public fun revealable_at(arg0: &Slot) : u64 {
        arg0.deposit_at + 432000000
    }

    public fun revealable_in(arg0: u64, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0;
        if (v0 > 432000000) {
            0
        } else {
            432000000 - v0
        }
    }

    fun select(arg0: u64, arg1: &vector<u8>) : u64 {
        ((0x9e5962d5183664be8a7762fbe94eee6e3457c0cc701750c94c17f7f8ac5a32fb::pseudorandom::u256_from_bytes(arg1) % (arg0 as u256)) as u64)
    }

    public(friend) fun set_attribute(arg0: &mut Evos, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::get_attributes_mut(&mut arg0.attributes);
        let v1 = 0x1::ascii::string(arg1);
        if (0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(v0, &v1)) {
            if (0x1::vector::length<u8>(&arg2) == 1 && *0x1::vector::borrow<u8>(&arg2, 0) == 0) {
                remove_attribute(arg0, arg1, arg3);
            } else {
                *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(v0, &v1) = 0x1::ascii::string(arg2);
            };
        } else {
            0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::insert_attribute<Witness, Evos>(&mut arg0.attributes, v1, 0x1::ascii::string(arg2));
        };
    }

    public(friend) fun set_gems(arg0: &mut Evos, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : u32 {
        assert!(arg0.gems >= arg1, 3);
        arg0.gems = arg0.gems - arg1;
        arg0.gems
    }

    public(friend) fun set_level(arg0: &mut Evos, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.level = arg1;
    }

    public(friend) fun set_stage(arg0: &mut Evos, arg1: vector<u8>, arg2: vector<u8>, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 10);
        assert!(xp(arg0) >= arg3, 3);
        arg0.xp = arg0.xp - arg3;
        arg0.stage = 0x1::string::utf8(arg1);
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public(friend) fun set_xp(arg0: &mut Evos, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : u32 {
        assert!(arg1 < 4294967295, 5);
        arg0.xp = arg1;
        arg0.xp
    }

    public fun species(arg0: &Evos) : 0x1::string::String {
        arg0.species
    }

    public fun specs(arg0: &Incubator) : &vector<Specie> {
        &arg0.specs
    }

    public fun stage(arg0: &Evos) : 0x1::string::String {
        arg0.stage
    }

    public(friend) fun update_url(arg0: &mut Evos, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun weight(arg0: &Specie) : u8 {
        arg0.weight
    }

    public entry fun withdraw(arg0: &mut Incubator, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(1 == arg0.version, 7);
        let Slot {
            id         : v0,
            deposit_at : _,
            owner      : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Slot>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        0x2::object::delete(v3);
        let v4 = 0;
        while (0x1::vector::length<0x2::object::ID>(&arg0.slots) > v4) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.slots, v4) == arg1) {
                break
            };
            v4 = v4 + 1;
        };
        0x1::vector::remove<0x2::object::ID>(&mut arg0.slots, v4);
        0x2::transfer::public_transfer<0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::EvosGenesisEgg>(0x2::dynamic_object_field::remove<bool, 0xcca18faec0dbe4b35ffc8e95308aa008c7b3eba38c2a9ddedf861b96cbc74ee2::evosgenesisegg::EvosGenesisEgg>(&mut v3, true), 0x2::tx_context::sender(arg2));
    }

    public fun xp(arg0: &Evos) : u32 {
        arg0.xp
    }

    // decompiled from Move bytecode v6
}

