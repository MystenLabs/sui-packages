module 0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::marketplace {
    struct Listing has key {
        id: 0x2::object::UID,
        session: 0x2::object::ID,
        owner: address,
        price: u64,
        title: 0x1::string::String,
        blurb: 0x1::string::String,
        cap: 0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::SessionCap,
    }

    struct ListingCreated has copy, drop {
        listing: 0x2::object::ID,
        session: 0x2::object::ID,
        owner: address,
        price: u64,
        title: 0x1::string::String,
    }

    struct Purchased has copy, drop {
        listing: 0x2::object::ID,
        session: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    public entry fun list_for_sale(arg0: 0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::SessionCap, arg1: &mut 0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::Session, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::add_member(&arg0, arg1, arg5);
        let v0 = Listing{
            id      : 0x2::object::new(arg6),
            session : 0x2::object::id<0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::Session>(arg1),
            owner   : 0x2::tx_context::sender(arg6),
            price   : arg2,
            title   : arg3,
            blurb   : arg4,
            cap     : arg0,
        };
        let v1 = ListingCreated{
            listing : 0x2::object::id<Listing>(&v0),
            session : 0x2::object::id<0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::Session>(arg1),
            owner   : 0x2::tx_context::sender(arg6),
            price   : arg2,
            title   : arg3,
        };
        0x2::event::emit<ListingCreated>(v1);
        0x2::transfer::share_object<Listing>(v0);
    }

    public fun listing_blurb(arg0: &Listing) : 0x1::string::String {
        arg0.blurb
    }

    public fun listing_owner(arg0: &Listing) : address {
        arg0.owner
    }

    public fun listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun listing_session(arg0: &Listing) : 0x2::object::ID {
        arg0.session
    }

    public fun listing_title(arg0: &Listing) : 0x1::string::String {
        arg0.title
    }

    public entry fun purchase(arg0: &mut Listing, arg1: &mut 0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::Session, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::Session>(arg1) == arg0.session, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.price, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.owner);
        0x76768f18e5c5b20a53b7ef34d54f8cafd8a7fe1b14573b93b372436492cc0c83::session::add_member(&arg0.cap, arg1, 0x2::tx_context::sender(arg3));
        let v0 = Purchased{
            listing : 0x2::object::id<Listing>(arg0),
            session : arg0.session,
            buyer   : 0x2::tx_context::sender(arg3),
            price   : arg0.price,
        };
        0x2::event::emit<Purchased>(v0);
    }

    // decompiled from Move bytecode v6
}

