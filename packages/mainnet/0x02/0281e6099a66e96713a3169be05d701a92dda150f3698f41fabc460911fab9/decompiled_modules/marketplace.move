module 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        profits: 0x2::table::Table<address, 0x2::balance::Balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>>,
    }

    struct Profit has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        owner: address,
        nft_id: 0x2::object::ID,
    }

    public fun buy(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player, arg1: &mut Marketplace, arg2: 0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&mut arg1.id, arg2);
        let Listing {
            id     : v1,
            price  : v2,
            owner  : v3,
            nft_id : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg1.listings, 0x2::object::id<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&v0));
        assert!(0x2::balance::value<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::point_balance(arg0)) >= v2, 1);
        let v5 = Profit{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::split<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::point_balance_mut(arg0), v2),
        };
        0x2::transfer::transfer<Profit>(v5, v3);
        0x2::transfer::public_transfer<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(v0, 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0));
        0x2::object::delete(v1);
    }

    public fun delist(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player, arg1: &mut Marketplace, arg2: 0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>) {
        let v0 = 0x2::transfer::public_receive<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&mut arg1.id, arg2);
        let Listing {
            id     : v1,
            price  : _,
            owner  : v3,
            nft_id : _,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg1.listings, 0x2::object::id<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&v0));
        assert!(v3 == 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0), 0);
        0x2::transfer::public_transfer<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(v0, 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0));
        0x2::object::delete(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id       : 0x2::object::new(arg0),
            listings : 0x2::table::new<0x2::object::ID, Listing>(arg0),
            profits  : 0x2::table::new<address, 0x2::balance::Balance<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>>(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public fun list(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player, arg1: &mut Marketplace, arg2: 0x2::transfer::Receiving<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::uid_mut(arg0), arg2);
        let v1 = 0x2::object::id<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(&v0);
        let v2 = Listing{
            id     : 0x2::object::new(arg4),
            price  : arg3,
            owner  : 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::to_address(arg0),
            nft_id : v1,
        };
        0x2::transfer::public_transfer<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::alphabet::Alphabet>(v0, to_address(arg1));
        0x2::table::add<0x2::object::ID, Listing>(&mut arg1.listings, v1, v2);
    }

    public fun take_profit(arg0: &mut 0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::Player, arg1: 0x2::transfer::Receiving<Profit>) {
        let Profit {
            id      : v0,
            balance : v1,
        } = 0x2::transfer::receive<Profit>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::uid_mut(arg0), arg1);
        0x2::object::delete(v0);
        0x2::balance::join<0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::point::POINT>(0x20281e6099a66e96713a3169be05d701a92dda150f3698f41fabc460911fab9::player::point_balance_mut(arg0), v1);
    }

    public fun to_address(arg0: &Marketplace) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

