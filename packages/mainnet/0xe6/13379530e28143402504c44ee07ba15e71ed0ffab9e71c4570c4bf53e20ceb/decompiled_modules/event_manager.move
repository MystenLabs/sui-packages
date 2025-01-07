module 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::event_manager {
    struct EventInfo has key {
        id: 0x2::object::UID,
        total_event: u64,
    }

    struct StallCreatorCap has key {
        id: 0x2::object::UID,
        goodie_bag_id: 0x2::object::ID,
        bumper_id: 0x2::object::ID,
    }

    struct Event_Participation_NFT has key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct Event_Participation_NFT_Info has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        name: 0x1::string::String,
        location: 0x1::string::String,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        event_name: 0x1::string::String,
        event_creator: address,
        total_stall: u64,
        stall_address: 0x2::table::Table<address, bool>,
        description: 0x1::string::String,
        location: 0x1::string::String,
        user_registered: 0x2::table::Table<address, bool>,
        registration_count: u64,
        received_participation: 0x2::table::Table<address, bool>,
    }

    struct Registration_NFT has store, key {
        id: 0x2::object::UID,
        event_name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun add_other_nft_in_goodies<T0: store + key>(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::goodie_bag::GoodieBagList, arg2: T0, arg3: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg3, 3);
        assert!(arg0.goodie_bag_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::goodie_bag::GoodieBagList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::add_other_nft<T0>(arg1, arg2);
    }

    public fun add_other_nft_in_stall_bumper<T0: store + key>(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList, arg2: T0, arg3: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg3, 3);
        assert!(arg0.bumper_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::add_nft_in_stall_bumper<T0>(arg1, arg2);
    }

    public(friend) fun add_participation_info(arg0: &Event, arg1: address, arg2: Event_Participation_NFT, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.received_participation, arg1), 4);
        let v0 = Event_Participation_NFT_Info{
            id          : 0x2::object::new(arg6),
            description : arg4,
            name        : arg5,
            location    : arg3,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Event_Participation_NFT_Info>(&mut arg2.id, 0x2::object::id<Event_Participation_NFT_Info>(&v0), v0);
        0x2::transfer::transfer<Event_Participation_NFT>(arg2, arg1);
    }

    public fun claim_bumper_prize<T0: store + key>(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList, arg2: u64, arg3: 0x2::object::ID, arg4: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg4, 3);
        assert!(arg0.bumper_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::claim_bumper_prize<T0>(arg1, arg2, arg3, arg5);
    }

    public(friend) fun create_Event(arg0: &mut EventInfo, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Event{
            id                     : 0x2::object::new(arg5),
            event_name             : arg1,
            event_creator          : arg2,
            total_stall            : 0,
            stall_address          : 0x2::table::new<address, bool>(arg5),
            description            : arg3,
            location               : arg4,
            user_registered        : 0x2::table::new<address, bool>(arg5),
            registration_count     : 0,
            received_participation : 0x2::table::new<address, bool>(arg5),
        };
        let v1 = 0x2::object::id<Event>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Event>(&mut arg0.id, v1, v0);
        arg0.total_event = arg0.total_event + 1;
        v1
    }

    public fun create_goodies_item(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::goodie_bag::GoodieBagList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg5, 3);
        assert!(arg0.goodie_bag_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::goodie_bag::GoodieBagList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::create_goodie_items(arg1, arg2, arg3, arg4, arg6);
    }

    public(friend) fun create_special_nft(arg0: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::nft_minter::InvitationCardList, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::nft_minter::create_special_nft(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun create_stall(arg0: &mut EventInfo, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Event>(&mut arg0.id, arg1).stall_address, arg2), 1);
        let v0 = StallCreatorCap{
            id            : 0x2::object::new(arg6),
            goodie_bag_id : 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::create_goodie_list(arg3, arg4, arg5, arg6),
            bumper_id     : 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::create_bumper_list(arg6),
        };
        0x2::transfer::transfer<StallCreatorCap>(v0, arg2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Event>(&mut arg0.id, arg1);
        mutate_event_registry(v1, arg2, arg6);
    }

    public fun create_stall_bumper_prize(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg5, 3);
        assert!(arg0.bumper_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::create_bumper_prize(arg1, arg2, arg3, arg4, arg6);
    }

    public fun get_random_in_bumper(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList, arg2: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg2, 3);
        assert!(arg0.bumper_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::get_random_in_bumper(arg1, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventInfo{
            id          : 0x2::object::new(arg0),
            total_event : 0,
        };
        0x2::transfer::share_object<EventInfo>(v0);
    }

    public fun mint_normal_nft(arg0: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::nft_minter::InvitationCardList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg4, 3);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::nft_minter::mint_normal_nft(arg0, arg1, arg2, arg3, arg5);
    }

    public(friend) fun mint_participation_token(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut Event, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg4.received_participation, arg0), 3);
        let v0 = Event_Participation_NFT{
            id          : 0x2::object::new(arg5),
            image_url   : arg1,
            description : arg2,
            name        : arg3,
        };
        0x2::table::add<address, bool>(&mut arg4.received_participation, arg0, true);
        0x2::transfer::transfer<Event_Participation_NFT>(v0, arg0);
    }

    public fun mint_registration_token(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut EventInfo, arg5: 0x2::object::ID, arg6: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg6, 3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Event>(&mut arg4.id, arg5);
        assert!(!0x2::table::contains<address, bool>(&v0.user_registered, arg0), 3);
        let v1 = Registration_NFT{
            id          : 0x2::object::new(arg7),
            event_name  : arg3,
            image_url   : arg1,
            description : arg2,
        };
        0x2::table::add<address, bool>(&mut v0.user_registered, arg0, true);
        v0.registration_count = v0.registration_count + 1;
        0x2::transfer::transfer<Registration_NFT>(v1, arg0);
    }

    fun mutate_event_registry(arg0: &mut Event, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.event_creator == 0x2::tx_context::sender(arg2), 0);
        0x2::table::add<address, bool>(&mut arg0.stall_address, arg1, true);
        arg0.total_stall = arg0.total_stall + 1;
    }

    public fun set_merkle_root(arg0: &StallCreatorCap, arg1: vector<u8>, arg2: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version, arg3: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::goodie_bag::GoodieBagList) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg2, 3);
        assert!(arg0.goodie_bag_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::goodie_bag::GoodieBagList>(arg3), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::stall_manager::set_merkle_root(arg1, arg3);
    }

    public fun set_wallet_address_in_stall_bumper(arg0: &StallCreatorCap, arg1: &mut 0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList, arg2: address, arg3: &0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::Version) {
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::version::checkVersion(arg3, 3);
        assert!(arg0.bumper_id == 0x2::object::id<0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::BumperPrizeList>(arg1), 2);
        0xe613379530e28143402504c44ee07ba15e71ed0ffab9e71c4570c4bf53e20ceb::bumper_prize::set_wallet_address(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

