module 0x2c2869282816e63112d65447418dd6830742809ee6d644a9ef7da5564d813061::duchy {
    struct DUCHY has drop {
        dummy_field: bool,
    }

    struct DuchyInventory has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct DuchyOwnership has store, key {
        id: 0x2::object::UID,
        ownership: 0x2::table::Table<address, u64>,
    }

    struct DuchyLand has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        size_km2: u64,
        terrain_type: u8,
        owner: address,
        knight_minted: u64,
        county_minted: u64,
        baronet_minted: u64,
        feudal_minted: u64,
        seigniorial_reserve_minted: u64,
    }

    struct SubLand has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        parent_land_id: 0x2::object::ID,
        size_km2: u64,
        sub_type: u8,
        terrain_type: u8,
    }

    struct LandMinted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        type_id: u8,
        name: 0x1::string::String,
        current_supply: u64,
    }

    struct LandBurned has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct Rentables has drop {
        dummy_field: bool,
    }

    struct Rented has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Listed has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Rentable has store {
        object: SubLand,
        duration: u64,
        start_date: 0x1::option::Option<u64>,
        price_per_day: u64,
        kiosk_id: 0x2::object::ID,
    }

    struct RentalPolicy has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        amount_bp: u64,
    }

    struct ProtectedTP has store, key {
        id: 0x2::object::UID,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<SubLand>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<SubLand>,
    }

    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &ProtectedTP, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<Rentables>(arg0), 0);
        0x2::kiosk::set_owner(arg0, arg1, arg6);
        0x2::kiosk::list<SubLand>(arg0, arg1, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<SubLand>(arg0, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<SubLand>(&arg2.transfer_policy, v1);
        let v5 = Rentable{
            object        : v0,
            duration      : arg4,
            start_date    : 0x1::option::none<u64>(),
            price_per_day : arg5,
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        let v6 = Rentables{dummy_field: false};
        let v7 = Listed{id: arg3};
        0x2::bag::add<Listed, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v6, arg0), v7, v5);
    }

    public fun url(arg0: &DuchyLand) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn_land(arg0: DuchyLand, arg1: &mut 0x2::tx_context::TxContext) {
        let DuchyLand {
            id                         : v0,
            name                       : _,
            url                        : _,
            size_km2                   : _,
            terrain_type               : _,
            owner                      : _,
            knight_minted              : _,
            county_minted              : _,
            baronet_minted             : _,
            feudal_minted              : _,
            seigniorial_reserve_minted : _,
        } = arg0;
        0x2::object::delete(v0);
        let v11 = LandBurned{
            object_id : 0x2::object::id<DuchyLand>(&arg0),
            owner     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<LandBurned>(v11);
    }

    public fun delist(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        let v1 = Listed{id: arg2};
        let Rentable {
            object        : v2,
            duration      : _,
            start_date    : _,
            price_per_day : _,
            kiosk_id      : _,
        } = 0x2::bag::remove<Listed, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0), v1);
        0x2::kiosk::place<SubLand>(arg0, arg1, v2);
    }

    public fun end_rental(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        let v1 = Rented{id: arg3};
        let Rentable {
            object        : v2,
            duration      : v3,
            start_date    : v4,
            price_per_day : _,
            kiosk_id      : v6,
        } = 0x2::bag::remove<Rented, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg1), v1);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == v6, 4);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1::option::destroy_some<u64>(v4) + v3 * 86400000, 5);
        0x2::kiosk::place<SubLand>(arg0, arg4, v2);
    }

    fun init(arg0: DUCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"size_km2"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"website"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Duchy Land NFT - Property in Drariux Network ecosystem."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(x"7b73697a655f6b6d327d206b6dc2b2"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Drariux Network"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://drariux.network"));
        let v4 = 0x2::package::claim<DUCHY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DuchyLand>(&v4, v0, v2, arg1);
        0x2::display::update_version<DuchyLand>(&mut v5);
        let v6 = DuchyInventory{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        let v7 = DuchyOwnership{
            id        : 0x2::object::new(arg1),
            ownership : 0x2::table::new<address, u64>(arg1),
        };
        let (v8, v9) = 0x2::transfer_policy::new<SubLand>(&v4, arg1);
        let v10 = ProtectedTP{
            id              : 0x2::object::new(arg1),
            transfer_policy : v8,
            policy_cap      : v9,
        };
        let v11 = RentalPolicy{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            amount_bp : 0,
        };
        0x2::transfer::public_share_object<ProtectedTP>(v10);
        0x2::transfer::public_share_object<RentalPolicy>(v11);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce);
        0x2::transfer::public_transfer<0x2::display::Display<DuchyLand>>(v5, @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce);
        0x2::transfer::public_transfer<DuchyInventory>(v6, @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce);
        0x2::transfer::public_transfer<DuchyOwnership>(v7, @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce);
    }

    public fun install_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Rentables{dummy_field: false};
        0x2::kiosk_extension::add<Rentables>(v0, arg0, arg1, 3, arg2);
    }

    public fun mint_duchy_land(arg0: u8, arg1: u8, arg2: &mut DuchyInventory, arg3: &mut DuchyOwnership, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == @0x554a2392980b0c3e4111c9a0e8897e632d41847d04cbd41f9e081e49ba2eb04a || v0 == @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce, 6);
        assert!(arg0 >= 1 && arg0 <= 31, 1);
        assert!(arg1 <= 5, 1);
        assert!(arg2.count < 8000, 2);
        arg2.count = arg2.count + 1;
        if (!0x2::table::contains<address, u64>(&arg3.ownership, v0)) {
            0x2::table::add<address, u64>(&mut arg3.ownership, v0, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg3.ownership, v0);
        assert!(*v1 < 20, 7);
        *v1 = *v1 + 1;
        let v2 = if (arg1 == 4) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmYiGZ2oixA4YuopPFQUSAz39Rn29ag8SjaTVYsjfyhecS")
        } else if (arg1 == 3) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmRuBuso7m2pdeiPVywrpY4nptZPPYM1pXvd2Sq7apeLvS")
        } else if (arg1 == 0) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmNWufXiQs99Ls1LRF5AQWSH2U4vKmu8KMKgpB7a6WSg8f")
        } else if (arg1 == 2) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmabrBk6yVQrPttVU7ixR5AA6HNKDJX1zk3GCmpmioYYaY")
        } else if (arg1 == 1) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmUBvSGuA7DWTx65RtdQf9M4ExaoEZTeWGKbmoaa818mUP")
        } else {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmY7hACUU15guZVBEcBDQmmCuJK7ayUmvRWS7wzyecEckW")
        };
        let v3 = 0x1::string::utf8(b"Duchy Land #");
        0x1::string::append(&mut v3, u64_to_string(arg2.count));
        let v4 = DuchyLand{
            id                         : 0x2::object::new(arg4),
            name                       : v3,
            url                        : 0x2::url::new_unsafe(v2),
            size_km2                   : 1000,
            terrain_type               : arg1,
            owner                      : v0,
            knight_minted              : 0,
            county_minted              : 0,
            baronet_minted             : 0,
            feudal_minted              : 0,
            seigniorial_reserve_minted : 0,
        };
        let v5 = LandMinted{
            object_id      : 0x2::object::id<DuchyLand>(&v4),
            owner          : v0,
            type_id        : arg0,
            name           : v4.name,
            current_supply : arg2.count,
        };
        0x2::event::emit<LandMinted>(v5);
        0x2::transfer::public_transfer<DuchyLand>(v4, v0);
    }

    public fun mint_sub_land(arg0: &mut DuchyLand, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = if (arg1 == 0) {
            200
        } else if (arg1 == 1) {
            5
        } else if (arg1 == 2) {
            20
        } else if (arg1 == 3) {
            2000
        } else {
            5300
        };
        let v1 = if (arg1 == 0) {
            &mut arg0.knight_minted
        } else if (arg1 == 1) {
            &mut arg0.county_minted
        } else if (arg1 == 2) {
            &mut arg0.baronet_minted
        } else if (arg1 == 3) {
            &mut arg0.feudal_minted
        } else {
            &mut arg0.seigniorial_reserve_minted
        };
        assert!(*v1 < v0, 2);
        *v1 = *v1 + 1;
        let v2 = if (arg1 == 0) {
            4
        } else if (arg1 == 1) {
            400
        } else if (arg1 == 2) {
            25
        } else {
            1
        };
        let v3 = if (arg1 == 4) {
            0x2::url::inner_url(&arg0.url)
        } else if (arg1 == 0) {
            if (arg0.terrain_type == 4) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmcTxhV6NHuzD8z63izAUU7L7DSwYPNhanvhfhD3bcac4B")
            } else if (arg0.terrain_type == 3) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmRkyMCMwHaLPWVu5fPY6FmrontybB4ykaA3S47DzkAbpM")
            } else if (arg0.terrain_type == 0) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmVvQqR9Fvi4RVTPvu9LcRQUtpVSvsfXezWxrYCwu46Vkh")
            } else if (arg0.terrain_type == 2) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmW3TVkCiafj784vPkgq8Z3Gnwy2pA2gBGQmsa1DtHeCXa")
            } else if (arg0.terrain_type == 1) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/Qmcsetb56gM7EL4ariqJqJtXcufHV965xYxLjewPdPvzfu")
            } else {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmeebG65aRdX9iA533GviNPfeWnGjNk22ZabuAhx6K3SaE")
            }
        } else if (arg1 == 1) {
            if (arg0.terrain_type == 4) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmQzDz7AgotMCBcbTA5MKmnDsFyNsX1mZDCkzEDiMGSjR3")
            } else if (arg0.terrain_type == 3) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmRyjpoQU8DvvEZAJwmEhiNYPX827Xjr6E18Eu6bPMZ17m")
            } else if (arg0.terrain_type == 0) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmWy3zxy5SwsnueVNjf7cDLRVja2NXhsD2DFQvse3E6aM6")
            } else if (arg0.terrain_type == 2) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmS7BCr9TAnvDqhYdeTYEYencBpneoVVaNL4jCmR1Pg6Rx")
            } else if (arg0.terrain_type == 1) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmecNoBFQSh3RJmvPR5sjAY35vHqSERYgPWfPwkCKtByp5")
            } else {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmYoDxtLgRo93oLZuVMJKFeaS2Q53rpfXHYXkWifM9kc9e")
            }
        } else if (arg1 == 2) {
            if (arg0.terrain_type == 4) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmNnV4JyvospM1ygAkNwYGCBDEcGLrrpbJPmZHTMKqzZ77")
            } else if (arg0.terrain_type == 3) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmVCBSKsp61weeKzZfEP8Y7w5bCsQvBP5VcDNzD3ZG71BX")
            } else if (arg0.terrain_type == 0) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmQucLa7Qe1mJmi2D2uqpWr2QicdcS5J9BJBxvRuBBA8Hg")
            } else if (arg0.terrain_type == 2) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmcB8NykTf5pqC8TN8b4ERaZrqJmMQMKc7jcBXVFkgRco2")
            } else if (arg0.terrain_type == 1) {
                0x1::ascii::string(b"https://ipfs.io/ipfs/QmUVAe9TftbCeija6oHwAYBeRVzNKv3jbpwxgWe6wMBVkU")
            } else {
                0x1::ascii::string(b"https://ipfs.io/ipfs/Qma7qmh9Exr8od2LBQmDbRbuTzE5G4vQHnCnGtqnKRWUFD")
            }
        } else if (arg0.terrain_type == 4) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmaaJUS8hJ6s4snrvdDkGHipkMmQL7Uy8UP53JggbvRCy3")
        } else if (arg0.terrain_type == 3) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmTBGZZcsjFgTuX7UesKJycyV9YCsTafDbih6Z5okqinEU")
        } else if (arg0.terrain_type == 0) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmXEQbGTU26HHM4PshJpKPrhKomKPmLNm6pmAvrD1rJM5h")
        } else if (arg0.terrain_type == 2) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmVvewyJEaj3DxFPuKFvCv1CSKUcsRjpn6fwsEbmZRHPcH")
        } else if (arg0.terrain_type == 1) {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmaZ2mKGjPZqscva1ZiMFXcHZ84mzYfAMLBimYKJkc79op")
        } else {
            0x1::ascii::string(b"https://ipfs.io/ipfs/QmRaA572ZJ4By6aU8PGr6eMbhKKwuktNFCs81hdHSCveZx")
        };
        let v4 = if (arg1 == 4) {
            0x1::string::utf8(b"Seigniorial Reserve #")
        } else {
            0x1::string::utf8(b"Sub Land #")
        };
        let v5 = v4;
        0x1::string::append(&mut v5, u64_to_string(*v1));
        let v6 = SubLand{
            id             : 0x2::object::new(arg2),
            name           : v5,
            url            : 0x2::url::new_unsafe(v3),
            parent_land_id : 0x2::object::id<DuchyLand>(arg0),
            size_km2       : v2,
            sub_type       : arg1,
            terrain_type   : arg0.terrain_type,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, SubLand>(&mut arg0.id, 0x2::object::id<SubLand>(&v6), v6);
    }

    public fun name(arg0: &DuchyLand) : &0x1::string::String {
        &arg0.name
    }

    public fun rent(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut RentalPolicy, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk_extension::is_installed<Rentables>(arg1), 0);
        let v0 = Rentables{dummy_field: false};
        let v1 = Listed{id: arg3};
        let v2 = 0x2::bag::remove<Listed, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v0, arg0), v1);
        assert!(v2.price_per_day <= 18446744073709551615 / v2.duration, 2);
        let v3 = v2.price_per_day * v2.duration;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v3, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, (((v3 as u128) * (arg2.amount_bp as u128) / (10000 as u128)) as u64), arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg6));
        v2.start_date = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg5));
        let v4 = Rentables{dummy_field: false};
        let v5 = Rented{id: arg3};
        0x2::bag::add<Rented, Rentable>(0x2::kiosk_extension::storage_mut<Rentables>(v4, arg1), v5, v2);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun update_url(arg0: &mut DuchyLand, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == @0x554a2392980b0c3e4111c9a0e8897e632d41847d04cbd41f9e081e49ba2eb04a || v0 == @0x9e7aaf5f56ae094eadf9ca7f2856f533bcbf12fcc9bb9578e43ca770599a5dce, 6);
        arg0.url = 0x2::url::new_unsafe(arg1);
    }

    // decompiled from Move bytecode v6
}

