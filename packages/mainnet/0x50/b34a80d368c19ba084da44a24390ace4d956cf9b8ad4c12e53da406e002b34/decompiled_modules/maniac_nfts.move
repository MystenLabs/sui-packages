module 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_nfts {
    struct ManiacNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Admin has store {
        admin_address: address,
    }

    struct MintingControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        counter: u64,
        admin: Admin,
        price_wl: u64,
        price_public: u64,
        minting_type: u8,
        wl_address_counter: 0x2::table::Table<address, u64>,
        public_address_counter: 0x2::table::Table<address, u64>,
        used_names: 0x2::vec_map::VecMap<0x1::string::String, bool>,
    }

    struct MANIAC_NFTS has drop {
        dummy_field: bool,
    }

    struct AttributeChanged has copy, drop {
        nft_id: 0x2::object::ID,
        add_attributes: vector<0x2::object::ID>,
        remove_attributes: vector<vector<u8>>,
    }

    struct NameChanged has copy, drop {
        nft_id: 0x2::object::ID,
        new_name: vector<u8>,
    }

    public fun attributes(arg0: &ManiacNft) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    entry fun giveaway(arg0: &mut MintingControl, arg1: &0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::AttributeMapping, arg2: &0x2::random::Random, arg3: vector<address>, arg4: &0x2::transfer_policy::TransferPolicy<ManiacNft>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg5)), 3);
        assert!(0x1::vector::length<address>(&arg3) <= 50, 0);
        assert!(0x1::vector::length<address>(&arg3) + arg0.counter <= 4444, 1);
        while (!0x1::vector::is_empty<address>(&arg3)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg3);
            let (v1, v2) = 0x2::kiosk::new(arg5);
            let v3 = v2;
            let v4 = v1;
            let v5 = &mut v4;
            mint_to_address(arg0, arg1, arg2, v5, &v3, arg4, v0, arg5);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v0);
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    entry fun giveaway_to_sender(arg0: &mut MintingControl, arg1: &0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::AttributeMapping, arg2: &0x2::random::Random, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: &0x2::transfer_policy::TransferPolicy<ManiacNft>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(is_admin(arg0, v0), 3);
        assert!(arg5 + arg0.counter <= 4444, 1);
        let v1 = 0;
        while (v1 < arg5) {
            mint_to_address(arg0, arg1, arg2, arg3, arg4, arg6, v0, arg7);
            v1 = v1 + 1;
        };
    }

    public fun image_url(arg0: &ManiacNft) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: MANIAC_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CoinFever"));
        let v4 = 0x2::package::claim<MANIAC_NFTS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ManiacNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<ManiacNft>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        let (v7, v8) = 0x2::transfer_policy::new<ManiacNft>(&v4, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<ManiacNft>(&mut v10, &v9, 700, 100000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<ManiacNft>(&mut v10, &v9);
        let v11 = Admin{admin_address: v6};
        let v12 = MintingControl{
            id                     : 0x2::object::new(arg1),
            paused                 : true,
            counter                : 0,
            admin                  : v11,
            price_wl               : 12 * 1000000000,
            price_public           : 15 * 1000000000,
            minting_type           : 0,
            wl_address_counter     : 0x2::table::new<address, u64>(arg1),
            public_address_counter : 0x2::table::new<address, u64>(arg1),
            used_names             : 0x2::vec_map::empty<0x1::string::String, bool>(),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<ManiacNft>>(v5, v6);
        0x2::transfer::share_object<MintingControl>(v12);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ManiacNft>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ManiacNft>>(v9, v6);
    }

    fun is_admin(arg0: &MintingControl, arg1: address) : bool {
        arg0.admin.admin_address == arg1
    }

    entry fun mint(arg0: &mut MintingControl, arg1: &0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::AttributeMapping, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<ManiacNft>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_type == 1, 4);
        assert!(arg4 > 0 && arg4 <= 12, 0);
        assert!(arg4 + arg0.counter <= 4444, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg4 * arg0.price_public, 2);
        let v0 = 0x2::tx_context::sender(arg8);
        if (0x2::table::contains<address, u64>(&arg0.public_address_counter, v0)) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.public_address_counter, v0);
            assert!(v1 + arg4 <= 12, 1);
            0x2::table::remove<address, u64>(&mut arg0.public_address_counter, v0);
            0x2::table::add<address, u64>(&mut arg0.public_address_counter, v0, v1 + arg4);
        } else {
            0x2::table::add<address, u64>(&mut arg0.public_address_counter, v0, arg4);
        };
        let v2 = 0;
        while (v2 < arg4) {
            mint_to_address(arg0, arg1, arg2, arg5, arg6, arg7, v0, arg8);
            v2 = v2 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.admin.admin_address);
    }

    fun mint_to_address(arg0: &mut MintingControl, arg1: &0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::AttributeMapping, arg2: &0x2::random::Random, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<ManiacNft>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"Fever Maniac #");
        let v1 = 0x1::u64::to_string(arg0.counter);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        let v2 = 0x2::object::new(arg7);
        let v3 = b"https://metadata.coinfever.app/api/image/?id=";
        let v4 = 0x2::address::to_string(0x2::object::uid_to_address(&v2));
        0x1::vector::append<u8>(&mut v3, *0x1::string::as_bytes(&v4));
        arg0.counter = arg0.counter + 1;
        let v5 = 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::create_random_attribute(arg1, b"background", arg2, arg7);
        let v6 = 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::create_random_attribute(arg1, b"beard", arg2, arg7);
        let v7 = 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::create_random_attribute(arg1, b"body", arg2, arg7);
        let v8 = 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::create_random_attribute(arg1, b"hat", arg2, arg7);
        let v9 = 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::create_random_attribute(arg1, b"eyes", arg2, arg7);
        let v10 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"background"), *0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_value(&v5));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"body"), *0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_value(&v7));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"hat"), *0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_value(&v8));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"beard"), *0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_value(&v6));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"eyes"), *0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_value(&v9));
        let v11 = ManiacNft{
            id         : v2,
            name       : 0x1::string::utf8(v0),
            image_url  : 0x1::string::utf8(v3),
            attributes : v10,
        };
        0x2::kiosk::lock<ManiacNft>(arg3, arg4, arg5, v11);
        let v12 = 0x1::vector::empty<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>();
        0x1::vector::push_back<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v12, v5);
        0x1::vector::push_back<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v12, v6);
        0x1::vector::push_back<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v12, v7);
        0x1::vector::push_back<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v12, v8);
        0x1::vector::push_back<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v12, v9);
        set_attribute(0x2::object::uid_to_inner(&v11.id), arg3, arg4, v12, 0x1::vector::empty<vector<u8>>(), arg7);
    }

    entry fun mint_wl(arg0: &mut MintingControl, arg1: &0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::AttributeMapping, arg2: &0x2::random::Random, arg3: &0xb075419b71713d839b7c9ff4ccd7e2c31999174411f93e9b6f017e4594b7f044::maniac_wl::WlNft, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<ManiacNft>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_type == 0, 4);
        assert!(arg5 > 0 && arg5 <= 6, 0);
        assert!(arg5 + arg0.counter <= 4444, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg5 * arg0.price_wl, 2);
        let v0 = 0x2::tx_context::sender(arg9);
        if (0x2::table::contains<address, u64>(&arg0.wl_address_counter, v0)) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.wl_address_counter, v0);
            assert!(v1 + arg5 <= 6, 1);
            0x2::table::remove<address, u64>(&mut arg0.wl_address_counter, v0);
            0x2::table::add<address, u64>(&mut arg0.wl_address_counter, v0, v1 + arg5);
        } else {
            0x2::table::add<address, u64>(&mut arg0.wl_address_counter, v0, arg5);
        };
        let v2 = 0;
        while (v2 < arg5) {
            mint_to_address(arg0, arg1, arg2, arg6, arg7, arg8, v0, arg9);
            v2 = v2 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.admin.admin_address);
    }

    public fun name(arg0: &ManiacNft) : &0x1::string::String {
        &arg0.name
    }

    entry fun pause(arg0: &mut MintingControl, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 3);
        arg0.paused = true;
    }

    public fun set_attribute(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&arg3) <= 5, 1);
        assert!(0x1::vector::length<vector<u8>>(&arg4) <= 5, 1);
        assert!(0x1::vector::length<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&arg3) > 0 || 0x1::vector::length<vector<u8>>(&arg4) > 0, 1);
        let v0 = 0x2::kiosk::borrow_mut<ManiacNft>(arg1, arg2, arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        while (!0x1::vector::is_empty<vector<u8>>(&arg4)) {
            let v2 = 0x1::vector::pop_back<vector<u8>>(&mut arg4);
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, v2)) {
                0x2::transfer::public_transfer<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(0x2::dynamic_object_field::remove<vector<u8>, 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v0.id, v2), v1);
            };
        };
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&arg3)) {
            let v4 = 0x1::vector::pop_back<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut arg3);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, 0x2::object::id<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&v4));
            let v5 = 0x1::string::as_bytes(0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_type(&v4));
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&v0.id, *v5)) {
                0x2::transfer::public_transfer<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(0x2::dynamic_object_field::remove<vector<u8>, 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v0.id, *v5), v1);
            };
            let v6 = 0x1::string::utf8(*v5);
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.attributes, &v6);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.attributes, 0x1::string::utf8(*v5), 0x1::string::utf8(*0x1::string::as_bytes(0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::field_value(&v4))));
            0x2::dynamic_object_field::add<vector<u8>, 0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(&mut v0.id, *v5, v4);
        };
        let v9 = AttributeChanged{
            nft_id            : arg0,
            add_attributes    : v3,
            remove_attributes : arg4,
        };
        0x2::event::emit<AttributeChanged>(v9);
        0x1::vector::destroy_empty<0x50b34a80d368c19ba084da44a24390ace4d956cf9b8ad4c12e53da406e002b34::maniac_attribute::ManiacAttributeNft>(arg3);
        0x1::vector::destroy_empty<vector<u8>>(arg4);
    }

    entry fun set_mint_type_public(arg0: &mut MintingControl, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 3);
        arg0.minting_type = 1;
    }

    entry fun set_mint_type_wl(arg0: &mut MintingControl, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 3);
        arg0.minting_type = 0;
    }

    entry fun set_name(arg0: &mut MintingControl, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<u8>) {
        let v0 = 0x1::string::utf8(arg4);
        assert!(0x2::vec_map::contains<0x1::string::String, bool>(&arg0.used_names, &v0) == false, 5);
        let v1 = 0x2::kiosk::borrow_mut<ManiacNft>(arg2, arg3, arg1);
        let v2 = v1.name;
        v1.name = v0;
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, bool>(&mut arg0.used_names, &v2);
        0x2::vec_map::insert<0x1::string::String, bool>(&mut arg0.used_names, v0, true);
        let v5 = NameChanged{
            nft_id   : arg1,
            new_name : arg4,
        };
        0x2::event::emit<NameChanged>(v5);
    }

    entry fun unpause(arg0: &mut MintingControl, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 3);
        arg0.paused = false;
    }

    entry fun withdraw_royalty(arg0: &MintingControl, arg1: &mut 0x2::transfer_policy::TransferPolicy<ManiacNft>, arg2: &0x2::transfer_policy::TransferPolicyCap<ManiacNft>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg3)), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<ManiacNft>(arg1, arg2, 0x1::option::none<u64>(), arg3), arg0.admin.admin_address);
    }

    // decompiled from Move bytecode v6
}

