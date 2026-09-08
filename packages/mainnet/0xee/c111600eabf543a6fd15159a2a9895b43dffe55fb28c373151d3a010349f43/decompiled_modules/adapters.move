module 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::adapters {
    public fun commander(arg0: &0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>();
        let v1 = 0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::doctrine(arg0);
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_coded<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(&mut v0, b"doctrine", doctrine_name(v1), (v1 as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(&mut v0, b"command", (0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::command(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(&mut v0, b"cunning", (0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::cunning(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(&mut v0, b"logistics", (0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::logistics(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(&mut v0, b"serial", 0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::serial(arg0));
        v0
    }

    public fun weapon(arg0: &0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>();
        let v1 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::kind(arg0);
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_coded<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut v0, b"kind", kind_name(v1), (v1 as u64));
        let v2 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::rarity(arg0);
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_coded<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut v0, b"rarity", rarity_name(v2), (v2 as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut v0, b"serial", 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::serial(arg0));
        let v3 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::attributes(arg0);
        let v4 = 0x1::string::utf8(b"LEVEL");
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(v3, &v4)) {
            0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_text<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut v0, b"level", *0x1::string::as_bytes(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(v3, &v4)));
        } else {
            0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut v0, b"level", 1);
        };
        v0
    }

    public fun rig(arg0: &0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig>();
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig>(&mut v0, b"drill", (0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::drill(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig>(&mut v0, b"capacity", (0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::capacity(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig>(&mut v0, b"armour", (0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::armour(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::Rig>(&mut v0, b"serial", 0x283ec22de8e5a2c998f71e818a1583d76791bcb64a7bc42eecd22ee99eb6b3e2::rig::serial(arg0));
        v0
    }

    public fun turret(arg0: &0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret>();
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret>(&mut v0, b"power", (0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::power(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret>(&mut v0, b"range", (0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::range(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret>(&mut v0, b"armour", (0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::armour(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::Turret>(&mut v0, b"serial", 0x6480120cd5f528b87128c9916e2175d5f9daab5e13be40629a73b8f790867e8c::turret::serial(arg0));
        v0
    }

    public fun wall_builder(arg0: &0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>();
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(&mut v0, b"build", (0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::build(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(&mut v0, b"stock", (0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::stock(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(&mut v0, b"armour", (0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::armour(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(&mut v0, b"serial", 0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::serial(arg0));
        v0
    }

    public fun harvester(arg0: &0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>();
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>(&mut v0, b"armour", (0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::armour(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>(&mut v0, b"speed", (0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::speed(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>(&mut v0, b"serial", 0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::serial(arg0));
        v0
    }

    public fun bot(arg0: &0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai::Nft) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai::Nft> {
        from_map<0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai::Nft>(0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai::attributes(arg0))
    }

    public fun bot_in_kiosk(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai::Nft> {
        bot(0x2::kiosk::borrow<0x54e007d4ef30e94dbefae73bba7605c9b0a5c49d6030449d35cff62641db47c0::boom_bots_ai::Nft>(arg0, arg1, arg2))
    }

    fun doctrine_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"quartermaster"
        } else if (arg0 == 1) {
            b"warden"
        } else if (arg0 == 2) {
            b"warlord"
        } else if (arg0 == 3) {
            b"pathfinder"
        } else {
            b"unknown"
        }
    }

    fun from_map<T0>(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<T0> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<T0>();
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(arg0);
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(&v1, v2);
            let v5 = snake(*0x1::string::as_bytes(v4));
            if (v5 == b"weapon") {
                v3 = true;
            };
            0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_text<T0>(&mut v0, v5, *0x1::string::as_bytes(0x2::vec_map::get<0x1::string::String, 0x1::string::String>(arg0, v4)));
            v2 = v2 + 1;
        };
        if (!v3) {
            0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_text<T0>(&mut v0, b"weapon", b"none");
        };
        v0
    }

    fun kind_name(arg0: u8) : vector<u8> {
        if (arg0 == 1) {
            b"scattergun"
        } else if (arg0 == 2) {
            b"minigun"
        } else if (arg0 == 3) {
            b"heavy-cannon"
        } else if (arg0 == 4) {
            b"railgun"
        } else if (arg0 == 5) {
            b"missile-pod"
        } else if (arg0 == 6) {
            b"plasma-storm"
        } else if (arg0 == 7) {
            b"boomdust-mortar"
        } else if (arg0 == 8) {
            b"relic"
        } else {
            b"unknown"
        }
    }

    public fun none<T0>() : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<T0> {
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<T0>()
    }

    public fun prime_core(arg0: &0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::PrimeCore) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::PrimeCore> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::PrimeCore>();
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::PrimeCore>(&mut v0, b"serial", 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::serial(arg0));
        let v1 = 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::struck_in(arg0);
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_text<0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::PrimeCore>(&mut v0, b"struck_in", *0x1::string::as_bytes(&v1));
        v0
    }

    fun rarity_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"common"
        } else if (arg0 == 1) {
            b"uncommon"
        } else if (arg0 == 2) {
            b"rare"
        } else if (arg0 == 3) {
            b"legendary"
        } else if (arg0 == 4) {
            b"forged"
        } else {
            b"unknown"
        }
    }

    public fun repair_truck(arg0: &0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck) : 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::Attrs<0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck> {
        let v0 = 0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::new_attrs<0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck>();
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck>(&mut v0, b"rig", (0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::rig(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck>(&mut v0, b"armour", (0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::armour(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck>(&mut v0, b"speed", (0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::speed(arg0) as u64));
        0xeec111600eabf543a6fd15159a2a9895b43dffe55fb28c373151d3a010349f43::collection_bids::push_num<0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::RepairTruck>(&mut v0, b"serial", 0xf8ad84545313f3545d519a16a933f703fec144b38b7cdb213996513ec104250a::repair_truck::serial(arg0));
        v0
    }

    fun snake(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 == 32) {
                0x1::vector::push_back<u8>(&mut v0, 95);
            } else if (v2 >= 65 && v2 <= 90) {
                0x1::vector::push_back<u8>(&mut v0, v2 + 32);
            } else {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

