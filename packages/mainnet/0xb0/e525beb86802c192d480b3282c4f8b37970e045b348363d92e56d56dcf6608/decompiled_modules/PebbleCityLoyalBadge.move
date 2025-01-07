module 0xb0e525beb86802c192d480b3282c4f8b37970e045b348363d92e56d56dcf6608::PebbleCityLoyalBadge {
    struct PEBBLECITYLOYALBADGE has drop {
        dummy_field: bool,
    }

    struct Slot {
        dummy_field: bool,
    }

    struct TicketWrapper has store, key {
        id: 0x2::object::UID,
        ticket: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::SbtTicket<Slot>,
    }

    struct CapWrapper has store, key {
        id: 0x2::object::UID,
        capability: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::OperatorCap<Slot>,
        whitelist: 0x2::table::Table<address, u8>,
        deadline: u64,
        allow_distribution: bool,
    }

    public fun transfer(arg0: &mut CapWrapper, arg1: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::transfer<Slot>(&mut arg0.capability, arg1, arg2, arg3, arg4);
    }

    public fun add_properties(arg0: &CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: &mut 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::add_properties<Slot>(&arg0.capability, arg2, arg3, arg4, arg5);
    }

    public fun batch_burn(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::batch_burn<Slot>(&mut arg0.capability, arg2, arg3);
    }

    public fun batch_mint(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        while (arg3 > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Pebble City: Loyal Badge : #03 Slot"));
            arg3 = arg3 - 1;
        };
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::batch_mint<Slot>(&mut arg0.capability, arg2, v0, arg4);
    }

    public fun batch_mint_and_transfer(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (v0 > 0) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Pebble City: Loyal Badge : #03 Slot"));
            v0 = v0 - 1;
        };
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::batch_mint_and_transfer<Slot>(&mut arg0.capability, arg2, v1, arg3);
    }

    public fun batch_transfer(arg0: &mut CapWrapper, arg1: vector<0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>>, arg2: vector<address>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::batch_transfer<Slot>(&mut arg0.capability, arg1, arg2, arg3, arg4);
    }

    public fun burn(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg3: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::burn<Slot>(&mut arg0.capability, arg2, arg3);
    }

    public fun burn_with_mint(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::ProvisionalGrant<Slot>, arg3: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg4: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::burn_with_mint<Slot>(&mut arg0.capability, arg2, arg3, arg4);
    }

    public fun create_collection(arg0: TicketWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Registry, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let TicketWrapper {
            id     : v0,
            ticket : v1,
        } = arg0;
        0x2::object::delete(v0);
        let (v2, v3) = 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::create_collection<Slot>(arg1, v1, arg4);
        let v4 = CapWrapper{
            id                 : 0x2::object::new(arg4),
            capability         : v3,
            whitelist          : 0x2::table::new<address, u8>(arg4),
            deadline           : arg2,
            allow_distribution : arg3,
        };
        0x2::transfer::public_share_object<CapWrapper>(v4);
        0x2::transfer::public_transfer<0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun grant_burner_addresses(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::grant_burner_addresses<Slot>(arg1, &mut arg0.capability, arg2);
    }

    public fun grant_minter_addresses(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::grant_minter_addresses<Slot>(arg1, &mut arg0.capability, arg2);
    }

    public fun mint(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: &mut 0x2::tx_context::TxContext) : (0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::ProvisionalGrant<Slot>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::mint<Slot>(&mut arg0.capability, 0x1::string::utf8(b"Pebble City: Loyal Badge : #03 Slot"), arg2)
    }

    public fun mint_and_transfer(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::mint_and_transfer<Slot>(&mut arg0.capability, arg2, 0x1::string::utf8(b"Pebble City: Loyal Badge : #03 Slot"), arg3);
    }

    public fun remove_properties(arg0: &CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: &mut 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg3: vector<0x1::string::String>, arg4: &0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::remove_properties<Slot>(&arg0.capability, arg2, arg3, arg4);
    }

    public fun revoke_burner_addresses(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::revoke_burner_addresses<Slot>(arg1, &mut arg0.capability, arg2);
    }

    public fun revoke_minter_addresses(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::revoke_minter_addresses<Slot>(arg1, &mut arg0.capability, arg2);
    }

    public fun transfer_with_mint(arg0: &CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::ProvisionalGrant<Slot>, arg3: 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::transfer_with_mint<Slot>(&arg0.capability, arg2, arg3, arg4, arg5);
    }

    public fun update_name(arg0: &CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: &mut 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::update_name<Slot>(&arg0.capability, arg2, arg3, arg4);
    }

    public fun update_properties(arg0: &CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: &mut 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::Sbt<Slot>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::update_properties<Slot>(&arg0.capability, arg2, arg3, arg4, arg5);
    }

    public fun add_minting_count(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: address, arg3: u8) {
        assert!(0x2::table::contains<address, u8>(&arg0.whitelist, arg2), 2);
        assert!(*0x2::table::borrow<address, u8>(&arg0.whitelist, arg2) <= 255 - arg3, 4);
        let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.whitelist, arg2);
        *v0 = *v0 + arg3;
    }

    public fun add_whitelist(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>, arg3: vector<u8>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u8>(&arg3), 0);
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::grant_minter_addresses<Slot>(arg1, &mut arg0.capability, arg2);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::table::add<address, u8>(&mut arg0.whitelist, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u8>(&mut arg3));
        };
    }

    fun init(arg0: PEBBLECITYLOYALBADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        let v1 = TicketWrapper{
            id     : 0x2::object::new(arg1),
            ticket : 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::claim_ticket<PEBBLECITYLOYALBADGE, Slot>(arg0, v0, arg1),
        };
        0x2::transfer::transfer<TicketWrapper>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_transfer_granter(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::remove_transfer_granter_public_key<Slot>(arg1, &mut arg0.capability);
    }

    public fun remove_whitelist(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<address>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::revoke_minter_addresses<Slot>(arg1, &mut arg0.capability, arg2);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::table::remove<address, u8>(&mut arg0.whitelist, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun set_deadline(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: u64) {
        arg0.deadline = arg2;
    }

    public fun set_distribution(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: bool) {
        arg0.allow_distribution = arg2;
    }

    public fun set_transfer_granter(arg0: &mut CapWrapper, arg1: &0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::AdminCap<Slot>, arg2: vector<u8>) {
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::set_transfer_granter_public_key<Slot>(arg1, &mut arg0.capability, arg2);
    }

    public fun user_mint(arg0: &mut CapWrapper, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline, 1);
        assert!(0x2::table::contains<address, u8>(&arg0.whitelist, 0x2::tx_context::sender(arg4)), 2);
        assert!(*0x2::table::borrow<address, u8>(&arg0.whitelist, 0x2::tx_context::sender(arg4)) > 0, 3);
        let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.whitelist, 0x2::tx_context::sender(arg4));
        let v1 = 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::get_transfer_granter_public_key<Slot>(&arg0.capability);
        let v2 = 0x2::bcs::to_bytes<u8>(v0);
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(0x2::tx_context::sender(arg4)));
        0x1::vector::append<u8>(&mut v2, arg1);
        let v3 = 0x2::hash::blake2b256(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v1, &v3) == true, 5);
        *v0 = *v0 - 1;
        0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::soulbound::mint_and_transfer<Slot>(&mut arg0.capability, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"Pebble City: Loyal Badge : #03 Slot"), arg4);
    }

    // decompiled from Move bytecode v6
}

