module 0xb6b0378ec9cbf88454c6df8be4acfefb2a66774ffff6a0a4929aa3a06ad11f01::club {
    struct Global has store, key {
        id: 0x2::object::UID,
        version: u64,
        admins: 0x2::vec_set::VecSet<address>,
        fee_receiver: address,
        clubs: 0x2::table::Table<u64, 0x2::object::ID>,
        clubs_type_indexer: 0x2::table::Table<0x1::ascii::String, vector<0x2::object::ID>>,
        clubs_owner_indexer: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct Club has store, key {
        id: 0x2::object::UID,
        index: u64,
        creator: address,
        admins: 0x2::vec_set::VecSet<address>,
        name: 0x1::string::String,
        logo: 0x1::string::String,
        description: 0x1::string::String,
        announcement: 0x1::string::String,
        type_name: 0x1::ascii::String,
        threshold: u64,
        channels: vector<Channel>,
    }

    struct Channel has store {
        name: 0x1::string::String,
        deleted: bool,
    }

    struct ClubCreated has copy, drop {
        index: u64,
        id: 0x2::object::ID,
        creator: address,
        admins: vector<address>,
        name: 0x1::string::String,
        logo: 0x1::string::String,
        description: 0x1::string::String,
        announcement: 0x1::string::String,
        type_name: 0x1::ascii::String,
        threshold: u64,
        channels: vector<0x1::string::String>,
    }

    public entry fun add_club_admin(arg0: &Global, arg1: &mut Club, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.creator, 1);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 4);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
    }

    public entry fun add_club_channel(arg0: &Global, arg1: &mut Club, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        let v0 = Channel{
            name    : 0x1::string::utf8(arg2),
            deleted : false,
        };
        0x1::vector::push_back<Channel>(&mut arg1.channels, v0);
    }

    public entry fun create_club<T0>(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 2);
        assert!(0x1::vector::length<u8>(&arg7) > 0, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_receiver);
        let v0 = 0x1::string::utf8(arg7);
        let v1 = Channel{
            name    : v0,
            deleted : false,
        };
        let v2 = 0x2::table::length<u64, 0x2::object::ID>(&arg0.clubs);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = Club{
            id           : 0x2::object::new(arg8),
            index        : v2,
            creator      : 0x2::tx_context::sender(arg8),
            admins       : 0x2::vec_set::empty<address>(),
            name         : 0x1::string::utf8(arg2),
            logo         : 0x1::string::utf8(arg3),
            description  : 0x1::string::utf8(arg4),
            announcement : 0x1::string::utf8(arg5),
            type_name    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            threshold    : arg6,
            channels     : 0x1::vector::singleton<Channel>(v1),
        };
        let v5 = 0x2::object::id<Club>(&v4);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.clubs, v2, v5);
        if (!0x2::table::contains<0x1::ascii::String, vector<0x2::object::ID>>(&arg0.clubs_type_indexer, v3)) {
            0x2::table::add<0x1::ascii::String, vector<0x2::object::ID>>(&mut arg0.clubs_type_indexer, v3, 0x1::vector::singleton<0x2::object::ID>(v5));
        } else {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::ascii::String, vector<0x2::object::ID>>(&mut arg0.clubs_type_indexer, v3), v5);
        };
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.clubs_owner_indexer, v4.creator)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.clubs_owner_indexer, v4.creator, 0x1::vector::singleton<0x2::object::ID>(v5));
        } else {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.clubs_owner_indexer, v4.creator), v5);
        };
        let v6 = ClubCreated{
            index        : v2,
            id           : v5,
            creator      : v4.creator,
            admins       : *0x2::vec_set::keys<address>(&v4.admins),
            name         : v4.name,
            logo         : v4.logo,
            description  : v4.description,
            announcement : v4.announcement,
            type_name    : v4.type_name,
            threshold    : v4.threshold,
            channels     : 0x1::vector::singleton<0x1::string::String>(v0),
        };
        0x2::event::emit<ClubCreated>(v6);
        0x2::transfer::share_object<Club>(v4);
    }

    public entry fun delete_club_channel(arg0: &Global, arg1: &mut Club, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        assert!(arg2 < 0x1::vector::length<Channel>(&arg1.channels), 6);
        0x1::vector::borrow_mut<Channel>(&mut arg1.channels, arg2).deleted = true;
    }

    public fun get_club_by_index(arg0: &Global, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.clubs, arg1)
    }

    public fun get_clubs_by_owner(arg0: &Global, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.clubs_owner_indexer, arg1)) {
            0x1::vector::empty<0x2::object::ID>()
        } else {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.clubs_owner_indexer, arg1)
        }
    }

    public fun get_clubs_by_type<T0>(arg0: &Global) : vector<0x2::object::ID> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, vector<0x2::object::ID>>(&arg0.clubs_type_indexer, v0)) {
            0x1::vector::empty<0x2::object::ID>()
        } else {
            *0x2::table::borrow<0x1::ascii::String, vector<0x2::object::ID>>(&arg0.clubs_type_indexer, v0)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Global{
            id                  : 0x2::object::new(arg0),
            version             : 0,
            admins              : 0x2::vec_set::singleton<address>(v0),
            fee_receiver        : v0,
            clubs               : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            clubs_type_indexer  : 0x2::table::new<0x1::ascii::String, vector<0x2::object::ID>>(arg0),
            clubs_owner_indexer : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<Global>(v1);
    }

    fun is_authorized_to_update_club_info(arg0: &Club, arg1: address) : bool {
        arg1 == arg0.creator || 0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun remove_club_admin(arg0: &Global, arg1: &mut Club, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.creator, 1);
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 5);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
    }

    public entry fun update_club_announcement(arg0: &Global, arg1: &mut Club, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg1.announcement = 0x1::string::utf8(arg2);
    }

    public entry fun update_club_channel_name(arg0: &Global, arg1: &mut Club, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg4)), 1);
        assert!(arg2 < 0x1::vector::length<Channel>(&arg1.channels), 6);
        0x1::vector::borrow_mut<Channel>(&mut arg1.channels, arg2).name = 0x1::string::utf8(arg3);
    }

    public entry fun update_club_description(arg0: &Global, arg1: &mut Club, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg1.description = 0x1::string::utf8(arg2);
    }

    public entry fun update_club_logo(arg0: &Global, arg1: &mut Club, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg1.logo = 0x1::string::utf8(arg2);
    }

    public entry fun update_club_name(arg0: &Global, arg1: &mut Club, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg1.name = 0x1::string::utf8(arg2);
    }

    public entry fun update_club_threshold(arg0: &Global, arg1: &mut Club, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized_to_update_club_info(arg1, 0x2::tx_context::sender(arg3)), 1);
        arg1.threshold = arg2;
    }

    // decompiled from Move bytecode v6
}

