module 0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct Distributor has store, key {
        id: 0x2::object::UID,
        supply: u64,
        counter: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        registry: 0x2::table::Table<u64, 0x2::object::ID>,
        is_complete: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        minter: address,
    }

    struct DistributorCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISTRIBUTOR>(arg0, arg1);
        let v1 = 0x2::display::new<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&v0, arg1);
        0x2::display::add<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{collection_name} #{number}"));
        0x2::display::add<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>>(v2);
        let v4 = Distributor{
            id          : 0x2::object::new(arg1),
            supply      : 1500,
            counter     : 0,
            name        : 0x1::string::utf8(b"Rinoco"),
            description : 0x1::string::utf8(b"Welcome to the wonderful world of Rinoco, where amazing and wondrous creatures live."),
            registry    : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            is_complete : false,
        };
        0x2::transfer::transfer<Distributor>(v4, 0x2::tx_context::sender(arg1));
        let v5 = DistributorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DistributorCap>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &DistributorCap, arg1: &mut Distributor, arg2: &0x2::transfer_policy::TransferPolicy<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<vector<0x1::string::String>>, arg6: vector<vector<0x1::string::String>>, arg7: vector<address>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_complete, 1);
        while (0x1::vector::length<0x1::string::String>(&arg4) > 0) {
            mint_single(arg0, arg1, arg2, 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg5), 0x1::vector::pop_back<vector<0x1::string::String>>(&mut arg6), 0x1::vector::pop_back<address>(&mut arg7), arg8);
        };
    }

    public entry fun mint_single(arg0: &DistributorCap, arg1: &mut Distributor, arg2: &0x2::transfer_policy::TransferPolicy<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>, arg3: u64, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_complete, 1);
        assert!(arg3 > 0, 3);
        assert!(arg3 <= arg1.supply, 2);
        arg1.counter = arg1.counter + 1;
        assert!(arg1.counter <= arg1.supply, 0);
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg1.registry, arg3), 1);
        let v0 = 0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::new(arg3, arg1.name, arg1.description, 0x1::option::some<0x1::string::String>(arg4), 0x1::option::some<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::attributes::Attributes>(0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::attributes::admin_new(arg5, arg6, arg8)), arg8);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.registry, arg3, 0x2::object::id<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&v0));
        let (v1, v2) = 0x2::kiosk::new(arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = NFTMinted{
            nft_id   : 0x2::object::id<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&v0),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
            minter   : arg7,
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::kiosk::lock<0x1ef52fbf40838e7ba35a714fb802a4504da6fd4c23efa1bc0d25d07c19144cac::rinoco::Rinoco>(&mut v4, &v3, arg2, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        if (arg1.counter == arg1.supply) {
            arg1.is_complete = true;
        };
    }

    // decompiled from Move bytecode v6
}

