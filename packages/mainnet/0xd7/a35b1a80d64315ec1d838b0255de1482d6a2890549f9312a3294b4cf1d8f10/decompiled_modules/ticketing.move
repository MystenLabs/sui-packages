module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing {
    struct Registry has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        version: u64,
        admin_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TicketTypeConfig<phantom T0> has store {
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Ticket<T0>>,
        display: 0x2::display::Display<Ticket<T0>>,
        creator_profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TypeCaps<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TicketTypeProof<phantom T0> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct Ticket<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        occasion: 0x1::string::String,
        event_id: 0x2::object::ID,
        event_type: 0x1::string::String,
        tier: 0x1::string::String,
        price: 0x1::string::String,
        traits: 0x2::table::Table<0x1::string::String, Trait>,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
    }

    struct Trait has copy, drop, store {
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct MintProof {
        ticket_id: 0x2::object::ID,
        requires_lock: bool,
    }

    struct TICKETING has drop {
        dummy_field: bool,
    }

    fun add_trait_to_ticket<T0>(arg0: &mut Ticket<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, Trait>(&arg0.traits, arg1), 2);
        let v0 = Trait{
            name  : arg1,
            value : arg2,
        };
        0x2::table::add<0x1::string::String, Trait>(&mut arg0.traits, v0.name, v0);
    }

    public fun admin_bump_registry_version(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::AdminCap, arg1: &mut Registry) {
        arg1.version = 1;
    }

    public fun admin_split_profits<T0>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::AdminCap, arg1: &mut Registry, arg2: &mut 0x2::transfer_policy::TransferPolicy<Ticket<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        split_profits_from_transfer_policy<T0>(arg1, arg2, arg3);
    }

    public fun admin_withdraw_all(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::AdminCap, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.admin_fees, 0x2::balance::value<0x2::sui::SUI>(&arg1.admin_fees), arg2)
    }

    public fun calc_fee_amount(arg0: u16, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / 10000) as u64)
    }

    public fun claim_ticket_type_proof<T0: drop, T1>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 7);
        let v0 = 0x2::package::claim<T0>(arg0, arg1);
        assert!(0x2::package::from_module<T1>(&v0), 8);
        let v1 = TicketTypeProof<T1>{
            id        : 0x2::object::new(arg1),
            publisher : v0,
        };
        0x2::transfer::public_transfer<TicketTypeProof<T1>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun collaborator_add_trait_to_ticket<T0>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::Event, arg1: &mut Ticket<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::get_event_id(arg0) == arg1.event_id, 4);
        assert!(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::is_collaborator(arg0, 0x2::tx_context::sender(arg4)), 3);
        add_trait_to_ticket<T0>(arg1, arg2, arg3);
    }

    public fun creator_add_trait_to_ticket<T0>(arg0: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::Event, arg1: &mut Ticket<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::get_event_id(arg0) == arg1.event_id, 4);
        assert!(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::is_creator(arg0, 0x2::tx_context::sender(arg4)), 3);
        add_trait_to_ticket<T0>(arg1, arg2, arg3);
    }

    public fun creator_mint_for_kiosk<T0>(arg0: &TicketTypeProof<T0>, arg1: &mut 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::Event, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: bool, arg11: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::Blacklist, arg12: &mut 0x2::tx_context::TxContext) : (Ticket<T0>, MintProof) {
        assert!(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::is_creator(arg1, 0x2::tx_context::sender(arg12)), 3);
        assert!(!0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::is_blacklisted(arg11, 0x2::tx_context::sender(arg12)), 5);
        let v0 = mint<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v1 = MintProof{
            ticket_id     : *0x2::object::uid_as_inner(&v0.id),
            requires_lock : arg10,
        };
        (v0, v1)
    }

    public fun creator_split_profits<T0>(arg0: &TicketTypeProof<T0>, arg1: &mut Registry, arg2: &mut 0x2::transfer_policy::TransferPolicy<Ticket<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        split_profits_from_transfer_policy<T0>(arg1, arg2, arg3);
    }

    public fun creator_withdraw_all<T0>(arg0: &TicketTypeProof<T0>, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = TypeCaps<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TypeCaps<T0>, TicketTypeConfig<T0>>(&mut arg1.id, v0);
        0x2::coin::take<0x2::sui::SUI>(&mut v1.creator_profits, 0x2::balance::value<0x2::sui::SUI>(&v1.creator_profits), arg2)
    }

    public fun get_display<T0>(arg0: &TicketTypeConfig<T0>) : &0x2::display::Display<Ticket<T0>> {
        &arg0.display
    }

    public fun get_ticket_id<T0>(arg0: &Ticket<T0>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun get_ticket_trait_value<T0>(arg0: &Ticket<T0>, arg1: 0x1::string::String) : &0x1::string::String {
        let v0 = &arg0.traits;
        assert!(0x2::table::contains<0x1::string::String, Trait>(v0, arg1), 6);
        &0x2::table::borrow<0x1::string::String, Trait>(v0, arg1).value
    }

    fun init(arg0: TICKETING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id         : 0x2::object::new(arg1),
            publisher  : 0x2::package::claim<TICKETING>(arg0, arg1),
            version    : 1,
            admin_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_valid_version(arg0: &Registry) : bool {
        arg0.version == 1
    }

    public(friend) fun mint<T0>(arg0: &mut 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::Event, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Ticket<T0> {
        assert!(0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::can_mint_tickets_for_event(arg0, 1), 1);
        let v0 = Ticket<T0>{
            id          : 0x2::object::new(arg9),
            name        : arg1,
            description : arg2,
            occasion    : arg3,
            event_id    : 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::get_event_id(arg0),
            event_type  : arg4,
            tier        : arg5,
            price       : arg6,
            traits      : 0x2::table::new<0x1::string::String, Trait>(arg9),
            image_url   : arg7,
            video_url   : arg8,
        };
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event::update_event_current_supply(arg0);
        v0
    }

    public(friend) fun publisher(arg0: &Registry) : &0x2::package::Publisher {
        &arg0.publisher
    }

    public fun setup<T0>(arg0: &mut Registry, arg1: &TicketTypeProof<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_version(arg0), 9);
        let v0 = TypeCaps<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<TypeCaps<T0>>(&arg0.id, v0), 10);
        let v1 = 0x2::display::new<Ticket<T0>>(&arg0.publisher, arg6);
        0x2::display::add<Ticket<T0>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Ticket<T0>>(&mut v1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::add<Ticket<T0>>(&mut v1, 0x1::string::utf8(b"video_url"), arg3);
        0x2::display::update_version<Ticket<T0>>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Ticket<T0>>(&arg0.publisher, arg6);
        let v4 = v3;
        let v5 = v2;
        if (arg5) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Ticket<T0>>(&mut v5, &v4);
        };
        if (arg4 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Ticket<T0>>(&mut v5, &v4, arg4, 0);
        };
        let v6 = TypeCaps<T0>{dummy_field: false};
        let v7 = TicketTypeConfig<T0>{
            policy_cap      : v4,
            display         : v1,
            creator_profits : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::dynamic_field::add<TypeCaps<T0>, TicketTypeConfig<T0>>(&mut arg0.id, v6, v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Ticket<T0>>>(v5);
    }

    public(friend) fun solve_mint_proof(arg0: MintProof) : (0x2::object::ID, bool) {
        let MintProof {
            ticket_id     : v0,
            requires_lock : v1,
        } = arg0;
        (v0, v1)
    }

    fun split_profits_from_transfer_policy<T0>(arg0: &mut Registry, arg1: &mut 0x2::transfer_policy::TransferPolicy<Ticket<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TypeCaps<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TypeCaps<T0>, TicketTypeConfig<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::transfer_policy::withdraw<Ticket<T0>>(arg1, &v1.policy_cap, 0x1::option::none<u64>(), arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.admin_fees, 0x2::coin::split<0x2::sui::SUI>(&mut v2, calc_fee_amount(1000, 0x2::coin::value<0x2::sui::SUI>(&v2)), arg2));
        0x2::coin::put<0x2::sui::SUI>(&mut v1.creator_profits, v2);
    }

    // decompiled from Move bytecode v6
}

