module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::identity_access {
    struct RegistrationRegistry has key {
        id: 0x2::object::UID,
        event_registrations: 0x2::table::Table<0x2::object::ID, EventRegistrations>,
        user_registrations: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct EventRegistrations has store {
        registrations: 0x2::table::Table<address, Registration>,
        pass_mappings: 0x2::table::Table<vector<u8>, PassInfo>,
        total_registered: u64,
    }

    struct Registration has copy, drop, store {
        wallet: address,
        registered_at: u64,
        pass_hash: vector<u8>,
        checked_in: bool,
        platform_fee_paid: u64,
    }

    struct PassInfo has copy, drop, store {
        wallet: address,
        event_id: 0x2::object::ID,
        created_at: u64,
        expires_at: u64,
        used: bool,
        pass_id: u64,
    }

    struct UserRegistered has copy, drop {
        event_id: 0x2::object::ID,
        wallet: address,
        registered_at: u64,
        platform_fee_paid: u64,
    }

    struct PassGenerated has copy, drop {
        event_id: 0x2::object::ID,
        wallet: address,
        pass_id: u64,
        expires_at: u64,
    }

    struct PassValidated has copy, drop {
        event_id: 0x2::object::ID,
        wallet: address,
        pass_id: u64,
    }

    struct PlatformFeeCollected has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        organizer: address,
        fee_amount: u64,
        registration_fee: u64,
        timestamp: u64,
    }

    public fun calculate_organizer_revenue(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::UserSubscription) : (u64, u64, u64) {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_fee_amount(arg0);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::get_subscription_type(arg1);
        let v2 = if (v1 == 0 && v0 > 0) {
            v0 * 500 / 10000
        } else if (v1 == 1 && v0 > 0) {
            v0 * 300 / 10000
        } else {
            0
        };
        (v0, v2, v0 - v2)
    }

    public fun calculate_registration_cost(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::UserSubscription) : (u64, u64, u64) {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_fee_amount(arg0);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::get_subscription_type(arg1);
        let v2 = if (v1 == 0 && v0 > 0) {
            v0 * 500 / 10000
        } else if (v1 == 1 && v0 > 0) {
            v0 * 300 / 10000
        } else {
            0
        };
        (v0, v2, v0)
    }

    fun generate_pass_hash(arg0: u64, arg1: 0x2::object::ID, arg2: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg2));
        0x2::hash::keccak256(&v0)
    }

    fun generate_pass_id(arg0: address, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 8) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(&v1, v3) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    public fun get_registration(arg0: address, arg1: 0x2::object::ID, arg2: &RegistrationRegistry) : (u64, bool, u64) {
        let v0 = 0x2::table::borrow<address, Registration>(&0x2::table::borrow<0x2::object::ID, EventRegistrations>(&arg2.event_registrations, arg1).registrations, arg0);
        (v0.registered_at, v0.checked_in, v0.platform_fee_paid)
    }

    public fun get_user_events(arg0: address, arg1: &RegistrationRegistry) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_registrations, arg0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg1.user_registrations, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistrationRegistry{
            id                  : 0x2::object::new(arg0),
            event_registrations : 0x2::table::new<0x2::object::ID, EventRegistrations>(arg0),
            user_registrations  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<RegistrationRegistry>(v0);
    }

    public fun is_registered(arg0: address, arg1: 0x2::object::ID, arg2: &RegistrationRegistry) : bool {
        if (!0x2::table::contains<0x2::object::ID, EventRegistrations>(&arg2.event_registrations, arg1)) {
            return false
        };
        0x2::table::contains<address, Registration>(&0x2::table::borrow<0x2::object::ID, EventRegistrations>(&arg2.event_registrations, arg1).registrations, arg0)
    }

    public fun mark_checked_in(arg0: address, arg1: 0x2::object::ID, arg2: &mut RegistrationRegistry) {
        0x2::table::borrow_mut<address, Registration>(&mut 0x2::table::borrow_mut<0x2::object::ID, EventRegistrations>(&mut arg2.event_registrations, arg1).registrations, arg0).checked_in = true;
    }

    public fun regenerate_pass(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: &mut RegistrationRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::is_event_active(arg0), 1);
        assert!(0x2::table::contains<0x2::object::ID, EventRegistrations>(&arg1.event_registrations, v1), 4);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, EventRegistrations>(&mut arg1.event_registrations, v1);
        assert!(0x2::table::contains<address, Registration>(&v2.registrations, v0), 4);
        let v3 = 0x2::table::borrow_mut<address, Registration>(&mut v2.registrations, v0);
        0x2::table::remove<vector<u8>, PassInfo>(&mut v2.pass_mappings, v3.pass_hash);
        let v4 = 0x2::clock::timestamp_ms(arg2);
        let v5 = generate_pass_id(v0, v1, v4);
        let v6 = generate_pass_hash(v5, v1, v0);
        let v7 = v4 + 1814400000;
        v3.pass_hash = v6;
        let v8 = PassInfo{
            wallet     : v0,
            event_id   : v1,
            created_at : v4,
            expires_at : v7,
            used       : false,
            pass_id    : v5,
        };
        0x2::table::add<vector<u8>, PassInfo>(&mut v2.pass_mappings, v6, v8);
        let v9 = PassGenerated{
            event_id   : v1,
            wallet     : v0,
            pass_id    : v5,
            expires_at : v7,
        };
        0x2::event::emit<PassGenerated>(v9);
    }

    public fun register_for_event(arg0: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: &mut RegistrationRegistry, arg2: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::UserSubscription, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg4: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury::PlatformTreasury, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        let v2 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0);
        let v3 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_fee_amount(arg0);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::is_event_active(arg0), 1);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_current_attendees(arg0) < 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_capacity(arg0), 3);
        let v4 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::get_subscription_type(arg2);
        let (v5, v6) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::get_subscription_status(arg2, arg6);
        assert!(v5 && !v6, 5);
        if (v4 == 0) {
            assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::can_add_attendees(arg2, arg3, 1, arg6), 5);
        };
        let v7 = if (v3 > 0) {
            if (v4 == 0) {
                v3 * 500 / 10000
            } else if (v4 == 1) {
                v3 * 300 / 10000
            } else {
                0
            }
        } else {
            0
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v3, 6);
        let (arg5, v8) = if (v7 > 0) {
            (arg5, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v7, arg7))
        } else {
            (arg5, 0x2::coin::zero<0x2::sui::SUI>(arg7))
        };
        if (!0x2::table::contains<0x2::object::ID, EventRegistrations>(&arg1.event_registrations, v1)) {
            let v9 = EventRegistrations{
                registrations    : 0x2::table::new<address, Registration>(arg7),
                pass_mappings    : 0x2::table::new<vector<u8>, PassInfo>(arg7),
                total_registered : 0,
            };
            0x2::table::add<0x2::object::ID, EventRegistrations>(&mut arg1.event_registrations, v1, v9);
        };
        let v10 = 0x2::table::borrow_mut<0x2::object::ID, EventRegistrations>(&mut arg1.event_registrations, v1);
        assert!(!0x2::table::contains<address, Registration>(&v10.registrations, v0), 2);
        let v11 = 0x2::clock::timestamp_ms(arg6);
        let v12 = generate_pass_id(v0, v1, v11);
        let v13 = generate_pass_hash(v12, v1, v0);
        let v14 = Registration{
            wallet            : v0,
            registered_at     : v11,
            pass_hash         : v13,
            checked_in        : false,
            platform_fee_paid : v7,
        };
        0x2::table::add<address, Registration>(&mut v10.registrations, v0, v14);
        v10.total_registered = v10.total_registered + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_registrations, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_registrations, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_registrations, v0), v1);
        let v15 = v11 + 1814400000;
        let v16 = PassInfo{
            wallet     : v0,
            event_id   : v1,
            created_at : v11,
            expires_at : v15,
            used       : false,
            pass_id    : v12,
        };
        0x2::table::add<vector<u8>, PassInfo>(&mut v10.pass_mappings, v13, v16);
        if (v7 > 0) {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury::deposit_platform_fee(arg4, v8, 0x1::string::utf8(b"event_registration"), arg6, arg7);
            let v17 = PlatformFeeCollected{
                event_id         : v1,
                attendee         : v0,
                organizer        : v2,
                fee_amount       : v7,
                registration_fee : v3,
                timestamp        : v11,
            };
            0x2::event::emit<PlatformFeeCollected>(v17);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        };
        let v18 = v3 - v7;
        if (v18 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v18, arg7), v2);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        let v19 = UserRegistered{
            event_id          : v1,
            wallet            : v0,
            registered_at     : v11,
            platform_fee_paid : v7,
        };
        0x2::event::emit<UserRegistered>(v19);
        let v20 = PassGenerated{
            event_id   : v1,
            wallet     : v0,
            pass_id    : v12,
            expires_at : v15,
        };
        0x2::event::emit<PassGenerated>(v20);
    }

    public fun register_for_free_event(arg0: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: &mut RegistrationRegistry, arg2: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::UserSubscription, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_fee_amount(arg0) == 0, 7);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::is_event_active(arg0), 1);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_current_attendees(arg0) < 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_capacity(arg0), 3);
        let (v2, v3) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::get_subscription_status(arg2, arg4);
        assert!(v2 && !v3, 5);
        if (0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::get_subscription_type(arg2) == 0) {
            assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription::can_add_attendees(arg2, arg3, 1, arg4), 5);
        };
        if (!0x2::table::contains<0x2::object::ID, EventRegistrations>(&arg1.event_registrations, v1)) {
            let v4 = EventRegistrations{
                registrations    : 0x2::table::new<address, Registration>(arg5),
                pass_mappings    : 0x2::table::new<vector<u8>, PassInfo>(arg5),
                total_registered : 0,
            };
            0x2::table::add<0x2::object::ID, EventRegistrations>(&mut arg1.event_registrations, v1, v4);
        };
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, EventRegistrations>(&mut arg1.event_registrations, v1);
        assert!(!0x2::table::contains<address, Registration>(&v5.registrations, v0), 2);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        let v7 = generate_pass_id(v0, v1, v6);
        let v8 = generate_pass_hash(v7, v1, v0);
        let v9 = Registration{
            wallet            : v0,
            registered_at     : v6,
            pass_hash         : v8,
            checked_in        : false,
            platform_fee_paid : 0,
        };
        0x2::table::add<address, Registration>(&mut v5.registrations, v0, v9);
        v5.total_registered = v5.total_registered + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_registrations, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_registrations, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_registrations, v0), v1);
        let v10 = v6 + 1814400000;
        let v11 = PassInfo{
            wallet     : v0,
            event_id   : v1,
            created_at : v6,
            expires_at : v10,
            used       : false,
            pass_id    : v7,
        };
        0x2::table::add<vector<u8>, PassInfo>(&mut v5.pass_mappings, v8, v11);
        let v12 = UserRegistered{
            event_id          : v1,
            wallet            : v0,
            registered_at     : v6,
            platform_fee_paid : 0,
        };
        0x2::event::emit<UserRegistered>(v12);
        let v13 = PassGenerated{
            event_id   : v1,
            wallet     : v0,
            pass_id    : v7,
            expires_at : v10,
        };
        0x2::event::emit<PassGenerated>(v13);
    }

    public fun validate_pass(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: &mut RegistrationRegistry, arg3: &0x2::clock::Clock) : (bool, address) {
        if (!0x2::table::contains<0x2::object::ID, EventRegistrations>(&arg2.event_registrations, arg1)) {
            return (false, @0x0)
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, EventRegistrations>(&mut arg2.event_registrations, arg1);
        if (!0x2::table::contains<vector<u8>, PassInfo>(&v0.pass_mappings, arg0)) {
            return (false, @0x0)
        };
        let v1 = 0x2::table::borrow_mut<vector<u8>, PassInfo>(&mut v0.pass_mappings, arg0);
        if (v1.used || 0x2::clock::timestamp_ms(arg3) > v1.expires_at) {
            return (false, @0x0)
        };
        v1.used = true;
        let v2 = PassValidated{
            event_id : arg1,
            wallet   : v1.wallet,
            pass_id  : v1.pass_id,
        };
        0x2::event::emit<PassValidated>(v2);
        (true, v1.wallet)
    }

    // decompiled from Move bytecode v6
}

