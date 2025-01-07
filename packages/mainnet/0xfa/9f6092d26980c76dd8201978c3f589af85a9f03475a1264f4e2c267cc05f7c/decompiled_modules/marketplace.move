module 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::marketplace {
    struct NFTListed has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        deposit: u64,
        miners: u64,
    }

    struct NFTSold has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        admin_fee: u64,
    }

    struct NFTDelisted has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        miners_by_deposit: 0x2::table::Table<u64, vector<0x2::object::ID>>,
        miners_by_hatchery: 0x2::table::Table<u64, vector<0x2::object::ID>>,
    }

    struct Listing has store {
        nft: 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::MinerNFT,
        price: u64,
        seller: address,
        deposit: u64,
        miners: u64,
    }

    public entry fun buy_nft(arg0: &mut Marketplace, arg1: &mut 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::AdminInfo, arg2: &mut 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::Registry, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg3), 2);
        let Listing {
            nft     : v1,
            price   : v2,
            seller  : v3,
            deposit : v4,
            miners  : v5,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v2, 3);
        if (!0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::is_registered(arg2, v0)) {
            0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::register_player(arg2, v0, 1, arg5);
        };
        let v6 = v2 * (1000 as u64) / (10000 as u64);
        0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::add_admin_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg4, v6, arg6)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v2 - v6, arg6), v3);
        let v7 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_deposit, v4);
        let (v8, v9) = 0x1::vector::index_of<0x2::object::ID>(v7, &arg3);
        if (v8) {
            0x1::vector::remove<0x2::object::ID>(v7, v9);
        };
        let v10 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_hatchery, v5);
        let (v11, v12) = 0x1::vector::index_of<0x2::object::ID>(v10, &arg3);
        if (v11) {
            0x1::vector::remove<0x2::object::ID>(v10, v12);
        };
        0x2::transfer::public_transfer<0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::MinerNFT>(v1, v0);
        let v13 = NFTSold{
            nft_id    : arg3,
            price     : v2,
            seller    : v3,
            buyer     : v0,
            admin_fee : v6,
        };
        0x2::event::emit<NFTSold>(v13);
    }

    public entry fun delist_nft(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 2);
        assert!(0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1).seller == 0x2::tx_context::sender(arg2), 4);
        let Listing {
            nft     : v0,
            price   : _,
            seller  : v2,
            deposit : v3,
            miners  : v4,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        let v5 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_deposit, v3);
        let (v6, v7) = 0x1::vector::index_of<0x2::object::ID>(v5, &arg1);
        if (v6) {
            0x1::vector::remove<0x2::object::ID>(v5, v7);
        };
        let v8 = 0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_hatchery, v4);
        let (v9, v10) = 0x1::vector::index_of<0x2::object::ID>(v8, &arg1);
        if (v9) {
            0x1::vector::remove<0x2::object::ID>(v8, v10);
        };
        0x2::transfer::public_transfer<0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::MinerNFT>(v0, v2);
        let v11 = NFTDelisted{
            nft_id : arg1,
            seller : v2,
        };
        0x2::event::emit<NFTDelisted>(v11);
    }

    public fun get_listing_info(arg0: &Marketplace, arg1: 0x2::object::ID) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)) {
            0x1::option::some<address>(0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1).seller)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_listings_by_deposit(arg0: &Marketplace, arg1: u64) : vector<0x2::object::ID> {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.miners_by_deposit, arg1)) {
            *0x2::table::borrow<u64, vector<0x2::object::ID>>(&arg0.miners_by_deposit, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_listings_by_miners(arg0: &Marketplace, arg1: u64) : vector<0x2::object::ID> {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.miners_by_hatchery, arg1)) {
            *0x2::table::borrow<u64, vector<0x2::object::ID>>(&arg0.miners_by_hatchery, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                 : 0x2::object::new(arg1),
            listings           : 0x2::table::new<0x2::object::ID, Listing>(arg1),
            miners_by_deposit  : 0x2::table::new<u64, vector<0x2::object::ID>>(arg1),
            miners_by_hatchery : 0x2::table::new<u64, vector<0x2::object::ID>>(arg1),
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public entry fun list_nft(arg0: &mut Marketplace, arg1: 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::MinerNFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::MinerNFT>(&arg1);
        let v2 = 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::get_current_deposit(&arg1);
        let v3 = 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft::get_hatchery_miners(&arg1);
        let v4 = Listing{
            nft     : arg1,
            price   : arg2,
            seller  : v0,
            deposit : v2,
            miners  : v3,
        };
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v1, v4);
        if (!0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.miners_by_deposit, v2)) {
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_deposit, v2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_deposit, v2), v1);
        if (!0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.miners_by_hatchery, v3)) {
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_hatchery, v3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.miners_by_hatchery, v3), v1);
        let v5 = NFTListed{
            nft_id  : v1,
            price   : arg2,
            seller  : v0,
            deposit : v2,
            miners  : v3,
        };
        0x2::event::emit<NFTListed>(v5);
    }

    public fun withdraw_admin_fees(arg0: &0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::AdminCap, arg1: &mut 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::AdminInfo, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::player_registry::withdraw_admin_balance(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

