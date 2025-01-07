module 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::koseli {
    struct KoseliRegistry has store, key {
        id: 0x2::object::UID,
        verified_address: 0x2::table::Table<address, vector<0x1::string::String>>,
    }

    struct NFTMetaData has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct KoseliCap has key {
        id: 0x2::object::UID,
    }

    struct EventAdminCap has key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        bumper_id: 0x2::object::ID,
    }

    public fun get_random_in_event_bumper(arg0: &EventAdminCap, arg1: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList, arg2: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg2, 1);
        assert!(arg0.bumper_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList>(arg1), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::get_random_in_event_bumper(arg1, arg3);
    }

    public fun set_verified_wallet_address(arg0: &EventAdminCap, arg1: address, arg2: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList, arg3: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg3, 1);
        assert!(arg0.bumper_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList>(arg2), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::set_verified_wallet_address(arg1, arg2);
    }

    public fun add_participation_info(arg0: &EventAdminCap, arg1: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::Event, arg2: address, arg3: 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::Event_Participation_NFT, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg7, 1);
        assert!(arg0.event_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::Event>(arg1), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::add_participation_info(arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun create_special_nft(arg0: &EventAdminCap, arg1: 0x2::object::ID, arg2: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::nft_minter::InvitationCardList, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg7, 1);
        assert!(arg0.event_id == arg1, 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::create_special_nft(arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_stall(arg0: &EventAdminCap, arg1: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::EventInfo, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg7, 1);
        assert!(arg0.event_id == arg2, 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::create_stall(arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun mint_participation_token(arg0: &EventAdminCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::Event, arg6: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg6, 1);
        assert!(arg0.event_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::Event>(arg5), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::mint_participation_token(arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun add_nft_in_event_bumper<T0: store + key>(arg0: &EventAdminCap, arg1: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList, arg2: T0, arg3: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg3, 1);
        assert!(arg0.bumper_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList>(arg1), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::add_other_nft_in_event_bumper<T0>(arg1, arg2);
    }

    public fun claim_event_bumper_prize<T0: store + key>(arg0: &EventAdminCap, arg1: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList, arg2: u64, arg3: 0x2::object::ID, arg4: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg4, 1);
        assert!(arg0.bumper_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList>(arg1), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::claim_bumper_prize<T0>(arg1, arg2, arg3, arg5);
    }

    public fun create_event_bumper_prize(arg0: &EventAdminCap, arg1: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg5, 1);
        assert!(arg0.bumper_id == 0x2::object::id<0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::Event_BumperPrizeList>(arg1), 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::create_bumper_prize(arg1, arg2, arg3, arg4, arg6);
    }

    public fun create_invitation(arg0: &EventAdminCap, arg1: 0x2::object::ID, arg2: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg2, 1);
        assert!(arg0.event_id == arg1, 2);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::stall_manager::create_invitation(arg3)
    }

    public fun handle_event_creator(arg0: &KoseliCap, arg1: &mut KoseliRegistry, arg2: &mut 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::EventInfo, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::version::checkVersion(arg7, 1);
        let v0 = if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg1.verified_address, arg3)) {
            let v1 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v1, arg4);
            0x2::table::add<address, vector<0x1::string::String>>(&mut arg1.verified_address, arg3, v1);
            0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::create_Event(arg2, arg4, arg3, arg5, arg6, arg8)
        } else {
            assert!(!0x1::vector::contains<0x1::string::String>(0x2::table::borrow<address, vector<0x1::string::String>>(&arg1.verified_address, arg3), &arg4), 1);
            0x1::vector::push_back<0x1::string::String>(0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg1.verified_address, arg3), arg4);
            0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_manager::create_Event(arg2, arg4, arg3, arg5, arg6, arg8)
        };
        let v2 = EventAdminCap{
            id        : 0x2::object::new(arg8),
            event_id  : v0,
            bumper_id : 0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::event_bumper_prize::create_event_bumper_list(arg8),
        };
        0x2::transfer::transfer<EventAdminCap>(v2, arg3);
        0xd8233a7ee0627f54069d9ce3e985151597543a485f15e3edd6f4e8548d0570fa::goodie_bag::create_pop_object(arg8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KoseliRegistry{
            id               : 0x2::object::new(arg0),
            verified_address : 0x2::table::new<address, vector<0x1::string::String>>(arg0),
        };
        let v1 = KoseliCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KoseliCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<KoseliRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

