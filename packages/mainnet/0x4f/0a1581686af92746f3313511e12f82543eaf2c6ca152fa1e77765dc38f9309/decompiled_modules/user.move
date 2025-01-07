module 0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::user {
    struct USER has drop {
        dummy_field: bool,
    }

    struct UserRegistry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, address>,
    }

    struct User has key {
        id: 0x2::object::UID,
        owner: address,
        created: 0x2::table_vec::TableVec<UserAuction>,
        bids: 0x2::table_vec::TableVec<UserBid>,
    }

    struct UserAuction has copy, store {
        auction_addr: address,
        time: u64,
    }

    struct UserBid has copy, store {
        auction_addr: address,
        time: u64,
        amount: u64,
    }

    struct UserRequest {
        user: User,
    }

    public(friend) fun add_bid(arg0: &mut UserRequest, arg1: address, arg2: u64, arg3: u64) {
        let v0 = UserBid{
            auction_addr : arg1,
            time         : arg2,
            amount       : arg3,
        };
        0x2::table_vec::push_back<UserBid>(&mut arg0.user.bids, v0);
    }

    public(friend) fun add_created(arg0: &mut UserRequest, arg1: address, arg2: u64) {
        let v0 = UserAuction{
            auction_addr : arg1,
            time         : arg2,
        };
        0x2::table_vec::push_back<UserAuction>(&mut arg0.user.created, v0);
    }

    public fun bids(arg0: &User) : &0x2::table_vec::TableVec<UserBid> {
        &arg0.bids
    }

    public fun created(arg0: &User) : &0x2::table_vec::TableVec<UserAuction> {
        &arg0.created
    }

    public fun destroy_user_request(arg0: UserRequest, arg1: &0x2::tx_context::TxContext) {
        let UserRequest { user: v0 } = arg0;
        0x2::transfer::transfer<User>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun existing_user_request(arg0: User) : UserRequest {
        UserRequest{user: arg0}
    }

    public fun get_auctions_and_bids(arg0: &User, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : (u64, u64, vector<UserAuction>, vector<UserBid>, bool, bool, u64, u64) {
        let (v0, v1, v2) = get_auctions_created(arg0, arg1, arg3, arg5);
        let (v3, v4, v5) = get_bids_placed(arg0, arg2, arg4, arg5);
        (0x2::table_vec::length<UserAuction>(&arg0.created), 0x2::table_vec::length<UserBid>(&arg0.bids), v0, v3, v1, v4, v2, v5)
    }

    public fun get_auctions_created(arg0: &User, arg1: u64, arg2: u64, arg3: bool) : (vector<UserAuction>, bool, u64) {
        0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::paginator::get_page<UserAuction>(&arg0.created, arg1, arg2, arg3)
    }

    public fun get_bids_placed(arg0: &User, arg1: u64, arg2: u64, arg3: bool) : (vector<UserBid>, bool, u64) {
        0x4f0a1581686af92746f3313511e12f82543eaf2c6ca152fa1e77765dc38f9309::paginator::get_page<UserBid>(&arg0.bids, arg1, arg2, arg3)
    }

    public fun get_user_address(arg0: &UserRegistry, arg1: address) : address {
        if (0x2::table::contains<address, address>(&arg0.users, arg1)) {
            *0x2::table::borrow<address, address>(&arg0.users, arg1)
        } else {
            @0x0
        }
    }

    public fun get_user_addresses(arg0: &UserRegistry, arg1: vector<address>) : vector<address> {
        let v0 = vector[];
        0x1::vector::reverse<address>(&mut arg1);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            let v2 = if (0x2::table::contains<address, address>(&arg0.users, v1)) {
                *0x2::table::borrow<address, address>(&arg0.users, v1)
            } else {
                @0x0
            };
            0x1::vector::push_back<address>(&mut v0, v2);
        };
        0x1::vector::destroy_empty<address>(arg1);
        v0
    }

    fun init(arg0: USER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<USER>(arg0, arg1);
        let v1 = new_registry(arg1);
        0x2::transfer::share_object<UserRegistry>(v1);
        let v2 = 0x2::display::new<UserRegistry>(&v0, arg1);
        0x2::display::add<UserRegistry>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Bidder User Registry"));
        0x2::display::add<UserRegistry>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"All BIDDER users (addresses that have created auctions or placed bids)."));
        0x2::display::add<UserRegistry>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://bidder.polymedia.app"));
        0x2::display::add<UserRegistry>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml,%3Csvg%20width%3D%22100%25%22%20height%3D%22100%25%22%20viewBox%3D%220%200%20100%20100%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20width%3D%22100%22%20height%3D%22100%22%20fill%3D%22%230F4C75%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%2250%22%20font-family%3D%22system-ui%2Csans-serif%22%20font-size%3D%2216%22%20font-weight%3D%22bold%22%20fill%3D%22%23fff%22%20text-anchor%3D%22middle%22%20dominant-baseline%3D%22middle%22%3E%3Ctspan%20x%3D%2250%22%20dy%3D%22-0.5em%22%3EUSER%3C%2Ftspan%3E%3Ctspan%20x%3D%2250%22%20dy%3D%221.3em%22%3EREGISTRY%3C%2Ftspan%3E%3C%2Ftext%3E%3Ctext%20x%3D%2294%22%20y%3D%2294%22%20font-family%3D%22system-ui%2Csans-serif%22%20font-size%3D%227%22%20font-weight%3D%22bold%22%20text-anchor%3D%22end%22%20dominant-baseline%3D%22text-bottom%22%3E%3Ctspan%20fill%3D%22yellow%22%20stroke%3D%22black%22%20stroke-width%3D%220.7%22%20paint-order%3D%22stroke%22%3EBIDDER%3C%2Ftspan%3E%3C%2Ftext%3E%3C%2Fsvg%3E"));
        0x2::display::add<UserRegistry>(&mut v2, 0x1::string::utf8(b"project_name"), 0x1::string::utf8(b"BIDDER | Polymedia"));
        0x2::display::add<UserRegistry>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bidder.polymedia.app"));
        0x2::display::update_version<UserRegistry>(&mut v2);
        let v3 = 0x2::display::new<User>(&v0, arg1);
        0x2::display::add<User>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"BIDDER User"));
        0x2::display::add<User>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Auctions created and bids placed by this address."));
        0x2::display::add<User>(&mut v3, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://bidder.polymedia.app/user/{owner}/bids"));
        0x2::display::add<User>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml,%3Csvg%20width%3D%22100%25%22%20height%3D%22100%25%22%20viewBox%3D%220%200%20100%20100%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20width%3D%22100%22%20height%3D%22100%22%20fill%3D%22%230F4C75%22%2F%3E%3Ctext%20x%3D%2250%22%20y%3D%2250%22%20font-family%3D%22system-ui%2Csans-serif%22%20font-size%3D%2225%22%20font-weight%3D%22bold%22%20fill%3D%22%23fff%22%20text-anchor%3D%22middle%22%20dominant-baseline%3D%22middle%22%3E%3Ctspan%20x%3D%2250%22%20dy%3D%220%22%3EUSER%3C%2Ftspan%3E%3C%2Ftext%3E%3Ctext%20x%3D%2294%22%20y%3D%2294%22%20font-family%3D%22system-ui%2Csans-serif%22%20font-size%3D%227%22%20font-weight%3D%22bold%22%20text-anchor%3D%22end%22%20dominant-baseline%3D%22text-bottom%22%3E%3Ctspan%20fill%3D%22yellow%22%20stroke%3D%22black%22%20stroke-width%3D%220.7%22%20paint-order%3D%22stroke%22%3EBIDDER%3C%2Ftspan%3E%3C%2Ftext%3E%3C%2Fsvg%3E"));
        0x2::display::add<User>(&mut v3, 0x1::string::utf8(b"project_name"), 0x1::string::utf8(b"BIDDER | Polymedia"));
        0x2::display::add<User>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bidder.polymedia.app"));
        0x2::display::update_version<User>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<UserRegistry>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<User>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : UserRegistry {
        UserRegistry{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, address>(arg0),
        }
    }

    fun new_user(arg0: &mut 0x2::tx_context::TxContext) : User {
        User{
            id      : 0x2::object::new(arg0),
            owner   : 0x2::tx_context::sender(arg0),
            created : 0x2::table_vec::empty<UserAuction>(arg0),
            bids    : 0x2::table_vec::empty<UserBid>(arg0),
        }
    }

    public fun new_user_request(arg0: &mut UserRegistry, arg1: &mut 0x2::tx_context::TxContext) : UserRequest {
        assert!(!0x2::table::contains<address, address>(&arg0.users, 0x2::tx_context::sender(arg1)), 6000);
        let v0 = new_user(arg1);
        0x2::table::add<address, address>(&mut arg0.users, 0x2::tx_context::sender(arg1), 0x2::object::uid_to_address(&v0.id));
        UserRequest{user: v0}
    }

    public fun users(arg0: &UserRegistry) : &0x2::table::Table<address, address> {
        &arg0.users
    }

    // decompiled from Move bytecode v6
}

