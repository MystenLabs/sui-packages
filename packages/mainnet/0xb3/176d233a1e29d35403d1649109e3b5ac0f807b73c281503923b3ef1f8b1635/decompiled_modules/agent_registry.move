module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry {
    struct Entry has store {
        handle: 0x1::string::String,
        passport: address,
        operator: address,
        pending_operator: 0x1::option::Option<address>,
        pending_passport: 0x1::option::Option<address>,
        adopted: bool,
        deposit: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<u64, Entry>,
        addresses: 0x2::table::Table<address, u64>,
        handles: 0x2::table::Table<0x1::string::String, address>,
        reserved: 0x2::table::Table<address, Reservation>,
        reserved_numbers: 0x2::table::Table<u64, address>,
        next_number: u64,
    }

    struct Reservation has drop, store {
        number: u64,
        handle: 0x1::string::String,
    }

    struct RegisteredV1 has copy, drop {
        number: u64,
        handle: 0x1::string::String,
        passport: address,
        operator: address,
        deposit: 0x2::object::ID,
    }

    struct OperatorProposedV1 has copy, drop {
        number: u64,
        proposed: address,
    }

    struct OperatorRotatedV1 has copy, drop {
        number: u64,
        old: address,
        new: address,
    }

    struct AdoptionProposedV1 has copy, drop {
        number: u64,
        passport: address,
    }

    struct AdoptedV1 has copy, drop {
        number: u64,
        passport: address,
    }

    struct ReservedV1 has copy, drop {
        number: u64,
        handle: 0x1::string::String,
        who: address,
    }

    struct UnreservedV1 has copy, drop {
        number: u64,
        who: address,
    }

    struct RotationCancelledV1 has copy, drop {
        number: u64,
    }

    struct AdoptionWithdrawnV1 has copy, drop {
        number: u64,
        passport: address,
    }

    entry fun accept_adoption(arg0: &mut Registry, arg1: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowRegistry, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg3), 7);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow_mut<u64, Entry>(&mut arg0.entries, arg3);
        assert!(!v1.adopted, 14);
        assert!(v1.passport == v1.operator, 15);
        assert!(v0 != v1.operator, 16);
        assert!(v1.pending_passport == 0x1::option::some<address>(v0), 8);
        v1.passport = v0;
        v1.adopted = true;
        v1.pending_passport = 0x1::option::none<address>();
        if (0x1::option::is_some<address>(&v1.pending_operator)) {
            v1.pending_operator = 0x1::option::none<address>();
            let v2 = RotationCancelledV1{number: arg3};
            0x2::event::emit<RotationCancelledV1>(v2);
        };
        *0x2::table::borrow_mut<0x1::string::String, address>(&mut arg0.handles, v1.handle) = v0;
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::open(arg1, v0);
        let v3 = AdoptedV1{
            number   : arg3,
            passport : v0,
        };
        0x2::event::emit<AdoptedV1>(v3);
    }

    entry fun accept_operator(arg0: &mut Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg2), 7);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, u64>(&arg0.addresses, v0), 1);
        assert!(!0x2::table::contains<address, Reservation>(&arg0.reserved, v0), 9);
        let v1 = 0x2::table::borrow_mut<u64, Entry>(&mut arg0.entries, arg2);
        assert!(v1.pending_operator == 0x1::option::some<address>(v0), 8);
        v1.operator = v0;
        v1.pending_operator = 0x1::option::none<address>();
        if (0x1::option::is_some<address>(&v1.pending_passport)) {
            let v2 = AdoptionWithdrawnV1{
                number   : arg2,
                passport : 0x1::option::extract<address>(&mut v1.pending_passport),
            };
            0x2::event::emit<AdoptionWithdrawnV1>(v2);
        };
        0x2::table::add<address, u64>(&mut arg0.addresses, v0, arg2);
        let v3 = OperatorRotatedV1{
            number : arg2,
            old    : v1.operator,
            new    : v0,
        };
        0x2::event::emit<OperatorRotatedV1>(v3);
    }

    fun assert_entry_deposit(arg0: &Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond) {
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::number(arg1)), 7);
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg1) == 0x2::table::borrow<u64, Entry>(&arg0.entries, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::number(arg1)).deposit, 19);
    }

    fun assert_owner(arg0: &Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: &0x2::tx_context::TxContext) {
        assert_entry_deposit(arg0, arg1);
        assert!(0x2::tx_context::sender(arg2) == passport_of(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::number(arg1)), 18);
    }

    public fun bond_of(arg0: &Registry, arg1: address) : 0x2::object::ID {
        0x2::table::borrow<u64, Entry>(&arg0.entries, number_of(arg0, arg1)).deposit
    }

    entry fun cancel_rotation(arg0: &mut Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg2), 7);
        let v0 = 0x2::table::borrow_mut<u64, Entry>(&mut arg0.entries, arg2);
        assert!(0x2::tx_context::sender(arg3) == v0.passport, 4);
        if (0x1::option::is_none<address>(&v0.pending_operator)) {
            return
        };
        v0.pending_operator = 0x1::option::none<address>();
        let v1 = RotationCancelledV1{number: arg2};
        0x2::event::emit<RotationCancelledV1>(v1);
    }

    fun excess_payee(arg0: &Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard) : address {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        assert_entry_deposit(arg0, arg1);
        passport_of(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::number(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id               : 0x2::object::new(arg0),
            entries          : 0x2::table::new<u64, Entry>(arg0),
            addresses        : 0x2::table::new<address, u64>(arg0),
            handles          : 0x2::table::new<0x1::string::String, address>(arg0),
            reserved         : 0x2::table::new<address, Reservation>(arg0),
            reserved_numbers : 0x2::table::new<u64, address>(arg0),
            next_number      : 670,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_current_operator(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.addresses, arg1) && 0x2::table::borrow<u64, Entry>(&arg0.entries, *0x2::table::borrow<address, u64>(&arg0.addresses, arg1)).operator == arg1
    }

    public fun is_registered(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.addresses, arg1)
    }

    fun normalise(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::into_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 >= 3 && v1 <= 32, 12);
        let v2 = b"";
        0x1::vector::reverse<u8>(&mut v0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v0)) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v0);
            let v5 = if (v4 >= 65 && v4 <= 90) {
                v4 + 32
            } else {
                v4
            };
            let v6 = if (v5 >= 97 && v5 <= 122) {
                true
            } else if (v5 >= 48 && v5 <= 57) {
                true
            } else if (v5 == 95) {
                true
            } else {
                v5 == 45
            };
            assert!(v6, 12);
            0x1::vector::push_back<u8>(&mut v2, v5);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u8>(v0);
        0x1::string::utf8(v2)
    }

    public fun number_of(arg0: &Registry, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.addresses, arg1), 0);
        *0x2::table::borrow<address, u64>(&arg0.addresses, arg1)
    }

    public fun operator_of(arg0: &Registry, arg1: u64) : address {
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg1), 7);
        0x2::table::borrow<u64, Entry>(&arg0.entries, arg1).operator
    }

    public fun passport_of(arg0: &Registry, arg1: u64) : address {
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg1), 7);
        0x2::table::borrow<u64, Entry>(&arg0.entries, arg1).passport
    }

    public fun payout_address(arg0: &Registry, arg1: address) : address {
        assert!(0x2::table::contains<address, u64>(&arg0.addresses, arg1), 0);
        0x2::table::borrow<u64, Entry>(&arg0.entries, *0x2::table::borrow<address, u64>(&arg0.addresses, arg1)).passport
    }

    entry fun propose_adoption(arg0: &mut Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg2), 7);
        let v0 = 0x2::table::borrow_mut<u64, Entry>(&mut arg0.entries, arg2);
        assert!(0x2::tx_context::sender(arg4) == v0.operator, 13);
        assert!(!v0.adopted, 14);
        assert!(v0.passport == v0.operator, 15);
        assert!(arg3 != v0.operator, 16);
        v0.pending_passport = 0x1::option::some<address>(arg3);
        let v1 = AdoptionProposedV1{
            number   : arg2,
            passport : arg3,
        };
        0x2::event::emit<AdoptionProposedV1>(v1);
    }

    entry fun register(arg0: &mut Registry, arg1: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowRegistry, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::registration_open(arg2), 11);
        let v0 = normalise(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, u64>(&arg0.addresses, v1), 1);
        let v2 = if (0x2::table::contains<address, Reservation>(&arg0.reserved, v1)) {
            let v3 = 0x2::table::remove<address, Reservation>(&mut arg0.reserved, v1);
            assert!(v3.handle == v0, 2);
            v3.number
        } else {
            assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.handles, v0), 3);
            0x2::table::add<0x1::string::String, address>(&mut arg0.handles, v0, v1);
            let v4 = arg0.next_number;
            arg0.next_number = v4 + 1;
            v4
        };
        let v5 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::new(v2, arg4);
        let v6 = Entry{
            handle           : v0,
            passport         : v1,
            operator         : v1,
            pending_operator : 0x1::option::none<address>(),
            pending_passport : 0x1::option::none<address>(),
            adopted          : false,
            deposit          : v5,
        };
        0x2::table::add<u64, Entry>(&mut arg0.entries, v2, v6);
        0x2::table::add<address, u64>(&mut arg0.addresses, v1, v2);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::open(arg1, v1);
        let v7 = RegisteredV1{
            number   : v2,
            handle   : v0,
            passport : v1,
            operator : v1,
            deposit  : v5,
        };
        0x2::event::emit<RegisteredV1>(v7);
    }

    entry fun release_excess(arg0: &Registry, arg1: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg4: &0x2::deny_list::DenyList, arg5: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::release_excess(arg1, arg2, excess_payee(arg0, arg1, arg5), arg3, arg4, arg5, arg6, arg7);
    }

    entry fun request_withdraw(arg0: &Registry, arg1: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        assert_owner(arg0, arg1, arg4);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::request_withdraw(arg1, arg2, arg3);
    }

    entry fun reserve(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Registry, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: address, arg4: u64, arg5: 0x1::string::String) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_admin(arg2, arg0);
        assert!(!0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::registration_open(arg2), 17);
        let v0 = normalise(arg5);
        assert!(arg4 > 0 && arg4 < 670, 5);
        assert!(!0x2::table::contains<address, u64>(&arg1.addresses, arg3), 1);
        assert!(!0x2::table::contains<address, Reservation>(&arg1.reserved, arg3), 9);
        assert!(!0x2::table::contains<u64, address>(&arg1.reserved_numbers, arg4), 6);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg1.handles, v0), 3);
        let v1 = Reservation{
            number : arg4,
            handle : v0,
        };
        0x2::table::add<address, Reservation>(&mut arg1.reserved, arg3, v1);
        0x2::table::add<u64, address>(&mut arg1.reserved_numbers, arg4, arg3);
        0x2::table::add<0x1::string::String, address>(&mut arg1.handles, v0, arg3);
        let v2 = ReservedV1{
            number : arg4,
            handle : v0,
            who    : arg3,
        };
        0x2::event::emit<ReservedV1>(v2);
    }

    entry fun rotate_operator(arg0: &mut Registry, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        assert!(0x2::table::contains<u64, Entry>(&arg0.entries, arg2), 7);
        assert!(!0x2::table::contains<address, u64>(&arg0.addresses, arg3), 1);
        assert!(!0x2::table::contains<address, Reservation>(&arg0.reserved, arg3), 9);
        let v0 = 0x2::table::borrow_mut<u64, Entry>(&mut arg0.entries, arg2);
        assert!(0x2::tx_context::sender(arg4) == v0.passport, 4);
        v0.pending_operator = 0x1::option::some<address>(arg3);
        let v1 = OperatorProposedV1{
            number   : arg2,
            proposed : arg3,
        };
        0x2::event::emit<OperatorProposedV1>(v1);
    }

    public fun top_up(arg0: &Registry, arg1: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg4: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg3);
        assert_owner(arg0, arg1, arg4);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::top_up(arg1, arg2, arg3);
    }

    entry fun unreserve(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::admin::AdminCap, arg1: &mut Registry, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg3: address) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg2);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_admin(arg2, arg0);
        assert!(!0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::registration_open(arg2), 17);
        assert!(0x2::table::contains<address, Reservation>(&arg1.reserved, arg3), 10);
        let v0 = 0x2::table::remove<address, Reservation>(&mut arg1.reserved, arg3);
        0x2::table::remove<u64, address>(&mut arg1.reserved_numbers, v0.number);
        0x2::table::remove<0x1::string::String, address>(&mut arg1.handles, v0.handle);
        let v1 = UnreservedV1{
            number : v0.number,
            who    : arg3,
        };
        0x2::event::emit<UnreservedV1>(v1);
    }

    entry fun withdraw(arg0: &Registry, arg1: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::outflow::OutflowWindow, arg4: &0x2::deny_list::DenyList, arg5: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg5);
        assert_owner(arg0, arg1, arg7);
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::withdraw(arg1, arg2, passport_of(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::number(arg1)), arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

