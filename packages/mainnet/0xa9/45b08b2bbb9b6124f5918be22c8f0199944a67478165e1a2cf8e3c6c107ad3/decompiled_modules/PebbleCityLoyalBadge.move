module 0xa945b08b2bbb9b6124f5918be22c8f0199944a67478165e1a2cf8e3c6c107ad3::PebbleCityLoyalBadge {
    struct PEBBLECITYLOYALBADGE has drop {
        dummy_field: bool,
    }

    struct City {
        dummy_field: bool,
    }

    struct TicketWrapper has store, key {
        id: 0x2::object::UID,
        ticket: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::SbtTicket<City>,
    }

    struct CapWrapper has store, key {
        id: 0x2::object::UID,
        capability: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::SbtCap<City>,
        whitelist: 0x2::table::Table<address, u8>,
        metadata_base_url: 0x1::string::String,
        number: u64,
        deadline: u64,
        allow_distribution: bool,
    }

    struct Capability has store, key {
        id: 0x2::object::UID,
    }

    public fun add_metadata(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::add_metadata<City>(&arg0.capability, arg2, arg3, arg4);
    }

    public fun add_minting_count(arg0: &mut CapWrapper, arg1: &Capability, arg2: address, arg3: u8) {
        assert!(0x2::table::contains<address, u8>(&arg0.whitelist, arg2), 2);
        assert!(*0x2::table::borrow<address, u8>(&arg0.whitelist, arg2) <= 255 - arg3, 4);
        let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.whitelist, arg2);
        *v0 = *v0 + arg3;
    }

    public fun add_whitelist(arg0: &mut CapWrapper, arg1: &Capability, arg2: vector<address>, arg3: vector<u8>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u8>(&arg3), 0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::table::add<address, u8>(&mut arg0.whitelist, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u8>(&mut arg3));
        };
    }

    public fun batch_burn(arg0: &mut CapWrapper, arg1: &Capability, arg2: vector<0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::batch_burn<City>(&mut arg0.capability, arg2, arg3);
    }

    public fun batch_mint(arg0: &mut CapWrapper, arg1: &Capability, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        while (arg3 > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Pebble City: Loyal Badge : #01 City"));
            let v3 = get_metadata_url(arg0);
            0x1::vector::push_back<0x1::string::String>(&mut v2, v3);
            0x1::vector::push_back<u64>(&mut v1, arg0.number);
            arg3 = arg3 - 1;
        };
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::batch_mint<City>(&mut arg0.capability, arg2, v0, v1, v2, arg4);
    }

    public fun batch_mint_and_transfer(arg0: &mut CapWrapper, arg1: &Capability, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        while (v0 > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Pebble City: Loyal Badge : #01 City"));
            let v4 = get_metadata_url(arg0);
            0x1::vector::push_back<0x1::string::String>(&mut v3, v4);
            0x1::vector::push_back<u64>(&mut v2, arg0.number);
            v0 = v0 - 1;
        };
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::batch_mint_and_transfer<City>(&mut arg0.capability, arg2, v1, v2, v3, arg3);
    }

    public fun borrow_display(arg0: &mut CapWrapper, arg1: &Capability) : (0x2::display::Display<0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>>, 0x2::borrow::Borrow) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::borrow_display<City>(&mut arg0.capability)
    }

    public fun borrow_policy_cap(arg0: &mut CapWrapper, arg1: &Capability) : (0x2::transfer_policy::TransferPolicyCap<0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>>, 0x2::borrow::Borrow) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::borrow_policy_cap<City>(&mut arg0.capability)
    }

    public fun borrow_publisher(arg0: &mut CapWrapper, arg1: &Capability) : (0x2::package::Publisher, 0x2::borrow::Borrow) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::borrow_publisher<City>(&mut arg0.capability)
    }

    public fun burn(arg0: &mut CapWrapper, arg1: &Capability, arg2: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::burn<City>(&mut arg0.capability, arg2, arg3);
    }

    public fun burn_with_mint(arg0: &mut CapWrapper, arg1: &Capability, arg2: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::ProvisionalGrant<City>, arg3: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::burn_with_mint<City>(&mut arg0.capability, arg2, arg3, arg4);
    }

    public fun create_collection(arg0: TicketWrapper, arg1: &0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Registry, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let TicketWrapper {
            id     : v0,
            ticket : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = CapWrapper{
            id                 : 0x2::object::new(arg5),
            capability         : 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::create_collection<City>(arg1, v1, true, arg5),
            whitelist          : 0x2::table::new<address, u8>(arg5),
            metadata_base_url  : arg2,
            number             : 0,
            deadline           : arg3,
            allow_distribution : arg4,
        };
        0x2::transfer::public_share_object<CapWrapper>(v2);
        let v3 = Capability{id: 0x2::object::new(arg5)};
        0x2::transfer::public_transfer<Capability>(v3, 0x2::tx_context::sender(arg5));
    }

    fun get_metadata_url(arg0: &mut CapWrapper) : 0x1::string::String {
        assert!(arg0.number < 18446744073709551615, 4);
        arg0.number = arg0.number + 1;
        let v0 = 0x1::string::utf8(0x1::vector::empty<u8>());
        0x1::string::append(&mut v0, arg0.metadata_base_url);
        0x1::string::append(&mut v0, to_string(arg0.number));
        v0
    }

    fun init(arg0: PEBBLECITYLOYALBADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        let v1 = TicketWrapper{
            id     : 0x2::object::new(arg1),
            ticket : 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::claim_ticket<PEBBLECITYLOYALBADGE, City>(arg0, v0, arg1),
        };
        0x2::transfer::transfer<TicketWrapper>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut CapWrapper, arg1: &Capability, arg2: &mut 0x2::tx_context::TxContext) : (0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::ProvisionalGrant<City>) {
        let v0 = get_metadata_url(arg0);
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::mint<City>(&mut arg0.capability, 0x1::string::utf8(b"Pebble City: Loyal Badge : #01 City"), arg0.number, v0, arg2)
    }

    public fun mint_and_transfer(arg0: &mut CapWrapper, arg1: &Capability, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = get_metadata_url(arg0);
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::mint_and_transfer<City>(&mut arg0.capability, arg2, 0x1::string::utf8(b"Pebble City: Loyal Badge : #01 City"), arg0.number, v0, arg3);
    }

    public fun remove_granter(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::SbtGrant<City>) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::remove_granter<City>(&arg0.capability, arg2);
    }

    public fun remove_metadata(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: 0x1::string::String) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::remove_metadata<City>(&arg0.capability, arg2, arg3);
    }

    public fun remove_whitelist(arg0: &mut CapWrapper, arg1: &Capability, arg2: address) {
        0x2::table::remove<address, u8>(&mut arg0.whitelist, arg2);
    }

    public fun return_display(arg0: &mut CapWrapper, arg1: &Capability, arg2: 0x2::display::Display<0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>>, arg3: 0x2::borrow::Borrow) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::return_display<City>(&mut arg0.capability, arg2, arg3);
    }

    public fun return_policy_cap(arg0: &mut CapWrapper, arg1: &Capability, arg2: 0x2::transfer_policy::TransferPolicyCap<0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>>, arg3: 0x2::borrow::Borrow) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::return_policy_cap<City>(&mut arg0.capability, arg2, arg3);
    }

    public fun return_publisher(arg0: &mut CapWrapper, arg1: &Capability, arg2: 0x2::package::Publisher, arg3: 0x2::borrow::Borrow) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::return_publisher<City>(&mut arg0.capability, arg2, arg3);
    }

    public fun set_deadline(arg0: &mut CapWrapper, arg1: &Capability, arg2: u64) {
        arg0.deadline = arg2;
    }

    public fun set_distribution(arg0: &mut CapWrapper, arg1: &Capability, arg2: bool) {
        arg0.allow_distribution = arg2;
    }

    public fun set_granter(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::SbtGrant<City>, arg3: vector<u8>) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::set_granter<City>(&arg0.capability, arg2, arg3);
    }

    public fun set_metadata_base_url(arg0: &mut CapWrapper, arg1: &Capability, arg2: 0x1::string::String) {
        arg0.metadata_base_url = arg2;
    }

    public fun set_token_number(arg0: &mut CapWrapper, arg1: &Capability, arg2: u64) {
        assert!(arg0.number < arg2, 5);
        arg0.number = arg2;
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun transfer_with_mint(arg0: &CapWrapper, arg1: &Capability, arg2: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::ProvisionalGrant<City>, arg3: 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg4: address) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::transfer_with_mint<City>(&arg0.capability, arg2, arg3, arg4);
    }

    public fun update_metadata(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::update_metadata<City>(&arg0.capability, arg2, arg3, arg4);
    }

    public fun update_metadata_url(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: 0x1::string::String) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::update_metadata_url<City>(&arg0.capability, arg2, arg3);
    }

    public fun update_name(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: 0x1::string::String) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::update_name<City>(&arg0.capability, arg2, arg3);
    }

    public fun update_token_id(arg0: &CapWrapper, arg1: &Capability, arg2: &mut 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::Sbt<City>, arg3: u64) {
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::update_token_id<City>(&arg0.capability, arg2, arg3);
    }

    public fun user_mint(arg0: &mut CapWrapper, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.deadline, 1);
        assert!(0x2::table::contains<address, u8>(&arg0.whitelist, 0x2::tx_context::sender(arg2)), 2);
        assert!(*0x2::table::borrow<address, u8>(&arg0.whitelist, 0x2::tx_context::sender(arg2)) > 0, 3);
        let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.whitelist, 0x2::tx_context::sender(arg2));
        *v0 = *v0 - 1;
        let v1 = get_metadata_url(arg0);
        0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::soulbound::mint_and_transfer<City>(&mut arg0.capability, 0x2::tx_context::sender(arg2), 0x1::string::utf8(b"Pebble City: Loyal Badge : #01 City"), arg0.number, v1, arg2);
    }

    // decompiled from Move bytecode v6
}

