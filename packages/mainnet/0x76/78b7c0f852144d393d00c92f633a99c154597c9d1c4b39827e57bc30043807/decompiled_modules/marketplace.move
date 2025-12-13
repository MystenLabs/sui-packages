module 0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        template: 0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::registry::ProfileData,
    }

    public fun buy_design(arg0: &mut 0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::registry::RootIdRegistry, arg1: &mut Marketplace, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg1.listings, arg2), 1);
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg1.listings, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0.seller);
        0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::registry::add_template(arg0, arg4, v0.template);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id       : 0x2::object::new(arg0),
            listings : 0x2::table::new<0x2::object::ID, Listing>(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun list_design(arg0: &0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::registry::RootIdRegistry, arg1: &mut Marketplace, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Listing{
            id       : v0,
            seller   : 0x2::tx_context::sender(arg4),
            price    : arg3,
            template : 0x7678b7c0f852144d393d00c92f633a99c154597c9d1c4b39827e57bc30043807::registry::get_template_for_listing(arg0, arg2),
        };
        0x2::table::add<0x2::object::ID, Listing>(&mut arg1.listings, 0x2::object::uid_to_inner(&v0), v1);
    }

    // decompiled from Move bytecode v6
}

