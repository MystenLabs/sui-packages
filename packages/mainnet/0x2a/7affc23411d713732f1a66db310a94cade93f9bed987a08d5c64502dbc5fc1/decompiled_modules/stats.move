module 0x4a76e8e2b95aa447b6eb58cc99f1f69a4a192af4732834abda51b5a4763407dc::stats {
    struct STATS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct StatsNft has store, key {
        id: 0x2::object::UID,
        leaderboard_id: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        stats: vector<StatsEntry>,
    }

    struct StatsEntry has copy, drop, store {
        key: 0x1::string::String,
        value: u64,
    }

    struct StatsMinted has copy, drop {
        stats_id: 0x2::object::ID,
        for: address,
    }

    struct StatsUpdated has copy, drop {
        stats_id: 0x2::object::ID,
        updated_keys: vector<0x1::string::String>,
        updated_values: vector<u64>,
    }

    fun is_authorized(arg0: &0x2::package::Publisher) : bool {
        0x2::display::is_authorized<StatsNft>(arg0)
    }

    public fun borrow_description(arg0: &StatsNft) : &0x1::string::String {
        &arg0.description
    }

    public fun borrow_image_url(arg0: &StatsNft) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun borrow_leaderboard_id(arg0: &StatsNft) : &0x1::string::String {
        &arg0.leaderboard_id
    }

    public fun borrow_project_url(arg0: &StatsNft) : &0x2::url::Url {
        &arg0.project_url
    }

    public fun borrow_stats(arg0: &StatsNft) : &vector<StatsEntry> {
        &arg0.stats
    }

    public fun borrow_stats_value(arg0: &StatsEntry) : &u64 {
        &arg0.value
    }

    public fun borrow_uid(arg0: &StatsNft) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_uid_mut(arg0: &mut StatsNft) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun burn_nft(arg0: StatsNft, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<StatsNft>) {
        let v0 = Witness{dummy_field: false};
        let StatsNft {
            id             : v1,
            leaderboard_id : _,
            description    : _,
            image_url      : _,
            project_url    : _,
            stats          : _,
        } = arg0;
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_burn<StatsNft>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::start_burn<StatsNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<StatsNft, Witness>(v0), &arg0), 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<StatsNft>>(arg1), v1);
    }

    public entry fun clear_stats(arg0: &0x2::package::Publisher, arg1: &mut StatsNft) {
        assert!(is_authorized(arg0), 1);
        arg1.stats = 0x1::vector::empty<StatsEntry>();
    }

    public fun create_new_mint_cap(arg0: &0x2::package::Publisher, arg1: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<StatsNft>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::display::is_authorized<StatsNft>(arg0), 1);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<StatsNft>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::split<StatsNft>(arg1, arg2, arg4), arg3);
    }

    fun get_index(arg0: &vector<StatsEntry>, arg1: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StatsEntry>(arg0)) {
            if (&0x1::vector::borrow<StatsEntry>(arg0, v0).key == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun init(arg0: STATS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Witness{dummy_field: false};
        let v2 = 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<StatsNft, Witness>(v1);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v0);
        let (v4, v5) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<STATS, StatsNft>(&arg0, 0x1::option::none<u64>(), arg1);
        let v6 = v4;
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<StatsNft>>(0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::new_unlimited<STATS, StatsNft>(&arg0, 0x2::object::id<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<StatsNft>>(&v6), arg1), v0);
        let v7 = 0x2::package::claim<STATS>(arg0, arg1);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<StatsNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(v2, &mut v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Panzerdogs"), 0x1::string::utf8(b"Panzerdogs Stats Tracking collection")));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<StatsNft, 0x2::url::Url>(v2, &mut v6, 0x2::url::new_unsafe_from_bytes(b"https://www.panzerdogs.io/"));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<StatsNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::Creators>(v2, &mut v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::creators::new(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::vec_set_from_vec<address>(&v3)));
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<StatsNft, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::Symbol>(v2, &mut v6, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::symbol::new(0x1::string::utf8(b"PNZRSTATS")));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"creator"));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v12 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v12, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::tags::game_asset());
        let v13 = 0x2::display::new_with_fields<StatsNft>(&v7, v8, v10, arg1);
        0x2::display::add<StatsNft>(&mut v13, 0x1::string::utf8(b"tags"), 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::display::from_vec(v12));
        0x2::display::update_version<StatsNft>(&mut v13);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<StatsNft>>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<StatsNft>>(v13, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<StatsNft>>(v6);
    }

    fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<StatsNft>, arg7: &mut 0x2::tx_context::TxContext) : StatsNft {
        let v0 = 0x1::vector::empty<StatsEntry>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg4);
        while (v1 > 0) {
            let v2 = StatsEntry{
                key   : 0x1::vector::pop_back<0x1::string::String>(&mut arg4),
                value : 0x1::vector::pop_back<u64>(&mut arg5),
            };
            0x1::vector::push_back<StatsEntry>(&mut v0, v2);
            v1 = v1 - 1;
        };
        let v3 = StatsNft{
            id             : 0x2::object::new(arg7),
            leaderboard_id : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            image_url      : 0x2::url::new_unsafe_from_bytes(arg2),
            project_url    : 0x2::url::new_unsafe_from_bytes(arg3),
            stats          : v0,
        };
        let v4 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_event::emit_mint<StatsNft>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<StatsNft, Witness>(v4), 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::collection_id<StatsNft>(arg6), &v3);
        v3
    }

    public entry fun mint_nft_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<StatsNft>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let v1 = StatsMinted{
            stats_id : 0x2::object::id<StatsNft>(&v0),
            for      : arg7,
        };
        0x2::event::emit<StatsMinted>(v1);
        0x2::transfer::public_transfer<StatsNft>(v0, arg7);
    }

    public entry fun set_stats(arg0: &mut StatsNft, arg1: vector<0x1::string::String>, arg2: vector<u64>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2);
        let v1 = arg0.stats;
        let v2 = StatsUpdated{
            stats_id       : 0x2::object::id<StatsNft>(arg0),
            updated_keys   : arg1,
            updated_values : arg2,
        };
        0x2::event::emit<StatsUpdated>(v2);
        while (v0 > 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            let v4 = get_index(&v1, &v3);
            if (0x1::option::is_some<u64>(&v4)) {
                0x1::vector::borrow_mut<StatsEntry>(&mut v1, 0x1::option::extract<u64>(&mut v4)).value = 0x1::vector::pop_back<u64>(&mut arg2);
            } else {
                let v5 = StatsEntry{
                    key   : v3,
                    value : 0x1::vector::pop_back<u64>(&mut arg2),
                };
                0x1::vector::push_back<StatsEntry>(&mut v1, v5);
            };
            v0 = v0 - 1;
        };
        arg0.stats = v1;
    }

    public entry fun update_fields(arg0: &0x2::package::Publisher, arg1: &mut StatsNft, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>, arg5: 0x1::option::Option<vector<u8>>) {
        assert!(is_authorized(arg0), 1);
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            arg1.leaderboard_id = 0x1::string::utf8(0x1::option::extract<vector<u8>>(&mut arg2));
        };
        if (0x1::option::is_some<vector<u8>>(&arg3)) {
            arg1.description = 0x1::string::utf8(0x1::option::extract<vector<u8>>(&mut arg3));
        };
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            arg1.image_url = 0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg4));
        };
        if (0x1::option::is_some<vector<u8>>(&arg5)) {
            arg1.project_url = 0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg5));
        };
    }

    public entry fun update_stats(arg0: &mut StatsNft, arg1: vector<0x1::string::String>, arg2: vector<u64>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2);
        let v1 = arg0.stats;
        let v2 = StatsUpdated{
            stats_id       : 0x2::object::id<StatsNft>(arg0),
            updated_keys   : arg1,
            updated_values : arg2,
        };
        0x2::event::emit<StatsUpdated>(v2);
        while (v0 > 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            let v4 = get_index(&v1, &v3);
            if (0x1::option::is_some<u64>(&v4)) {
                let v5 = 0x1::vector::borrow_mut<StatsEntry>(&mut v1, 0x1::option::extract<u64>(&mut v4));
                v5.value = v5.value + 0x1::vector::pop_back<u64>(&mut arg2);
            } else {
                let v6 = StatsEntry{
                    key   : v3,
                    value : 0x1::vector::pop_back<u64>(&mut arg2),
                };
                0x1::vector::push_back<StatsEntry>(&mut v1, v6);
            };
            v0 = v0 - 1;
        };
        arg0.stats = v1;
    }

    // decompiled from Move bytecode v6
}

