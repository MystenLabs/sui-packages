module 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::state {
    struct State<phantom T0> has store, key {
        id: 0x2::object::UID,
        mode: 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::mode::Mode,
        balance: 0x2::balance::Balance<T0>,
        threshold: u8,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        peers: 0x2::table::Table<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>,
        outbox: 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::Outbox<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>,
        inbox: 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::Inbox<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>,
        transceivers: 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::TransceiverRegistry,
        chain_id: u16,
        next_sequence: u64,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: u16, arg1: 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::mode::Mode, arg2: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (State<T0>, AdminCap) {
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<T0>>(&arg2) == 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::mode::is_locking(&arg1), 13906834389091745791);
        let v0 = AdminCap{id: 0x2::object::new(arg4)};
        let v1 = State<T0>{
            id             : 0x2::object::new(arg4),
            mode           : arg1,
            balance        : 0x2::balance::zero<T0>(),
            threshold      : 0,
            treasury_cap   : arg2,
            peers          : 0x2::table::new<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>(arg4),
            outbox         : 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::new<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(18446744073709551615, arg4),
            inbox          : 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::new<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(arg4),
            transceivers   : 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::new(arg4),
            chain_id       : arg0,
            next_sequence  : 1,
            version        : 0,
            admin_cap_id   : 0x2::object::uid_to_inner(&v0.id),
            upgrade_cap_id : arg3,
        };
        (v1, v0)
    }

    public fun borrow_inbox_item<T0>(arg0: &State<T0>, arg1: u16, arg2: 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::ntt_manager_message::NttManagerMessage<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>) : &0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::InboxItem<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer> {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::borrow_inbox_item<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&arg0.inbox, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::new_inbox_key<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(arg1, arg2))
    }

    public(friend) fun borrow_inbox_item_mut<T0>(arg0: &mut State<T0>, arg1: u16, arg2: 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::ntt_manager_message::NttManagerMessage<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>) : &mut 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::InboxItem<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer> {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::borrow_inbox_item_mut<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&mut arg0.inbox, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::new_inbox_key<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(arg1, arg2))
    }

    public(friend) fun vote<T0, T1>(arg0: &mut State<T1>, arg1: u16, arg2: 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::ntt_manager_message::NttManagerMessage<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>) {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::vote<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&mut arg0.inbox, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::transceiver_id<T0>(&arg0.transceivers), 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::new_inbox_key<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(arg1, arg2));
    }

    public(friend) fun borrow_balance<T0>(arg0: &State<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut State<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun borrow_mode<T0>(arg0: &State<T0>) : &0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::mode::Mode {
        &arg0.mode
    }

    public fun borrow_outbox<T0>(arg0: &State<T0>) : &0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::Outbox<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer> {
        &arg0.outbox
    }

    public(friend) fun borrow_outbox_mut<T0>(arg0: &mut State<T0>) : &mut 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::Outbox<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer> {
        &mut arg0.outbox
    }

    public fun borrow_peer<T0>(arg0: &State<T0>, arg1: u16) : &0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer {
        0x2::table::borrow<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>(&arg0.peers, arg1)
    }

    public(friend) fun borrow_peer_mut<T0>(arg0: &mut State<T0>, arg1: u16) : &mut 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer {
        0x2::table::borrow_mut<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>(&mut arg0.peers, arg1)
    }

    public(friend) fun borrow_treasury_cap<T0>(arg0: &State<T0>) : &0x2::coin::TreasuryCap<T0> {
        0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap)
    }

    public(friend) fun borrow_treasury_cap_mut<T0>(arg0: &mut State<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)
    }

    public fun create_transceiver_message<T0, T1>(arg0: &mut State<T1>, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, arg2: &0x2::clock::Clock) : 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::outbound_message::OutboundMessage<0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::auth::ManagerAuth, T0> {
        let v0 = 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::new_outbox_key(arg1);
        assert!(0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::try_release<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&mut arg0.outbox, v0, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::transceiver_id<T0>(&arg0.transceivers), arg2), 13906834956027428863);
        let v1 = 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::borrow<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&arg0.outbox, v0);
        let (v2, v3, v4) = 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::ntt_manager_message::destruct<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(*0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::borrow_data<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(v1));
        let v5 = 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::auth::new_auth();
        0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::outbound_message::new<0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::auth::ManagerAuth, T0, State<T1>>(&v5, arg0, 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::ntt_manager_message::new<vector<u8>>(v2, v3, 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::to_bytes(v4)), *0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::borrow_recipient_ntt_manager_address<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(v1))
    }

    public fun disable_transceiver<T0>(arg0: &mut State<T0>, arg1: &AdminCap, arg2: u8) {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::disable_transceiver(&mut arg0.transceivers, arg2);
    }

    public fun enable_transceiver<T0>(arg0: &mut State<T0>, arg1: &AdminCap, arg2: u8) {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::enable_transceiver(&mut arg0.transceivers, arg2);
    }

    public fun get_chain_id<T0>(arg0: &State<T0>) : u16 {
        arg0.chain_id
    }

    public fun get_enabled_transceivers<T0>(arg0: &State<T0>) : 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::bitmap::Bitmap {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::get_enabled_transceivers(&arg0.transceivers)
    }

    public fun get_next_sequence<T0>(arg0: &State<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_u256_be((arg0.next_sequence as u256))
    }

    public fun get_threshold<T0>(arg0: &State<T0>) : u8 {
        arg0.threshold
    }

    public fun get_version<T0>(arg0: &State<T0>) : u64 {
        arg0.version
    }

    public(friend) fun next_message_id<T0>(arg0: &mut State<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        let v0 = arg0.next_sequence;
        arg0.next_sequence = v0 + 1;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_u256_be((v0 as u256))
    }

    public fun register_transceiver<T0, T1>(arg0: &mut State<T1>, arg1: 0x2::object::ID, arg2: &AdminCap) {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::transceiver_registry::register_transceiver<T0>(&mut arg0.transceivers, arg1);
    }

    public fun set_outbound_rate_limit<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::rate_limit::set_limit(0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::outbox::borrow_rate_limit_mut<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&mut arg1.outbox), arg2, arg3);
    }

    public fun set_peer<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock) {
        if (0x2::table::contains<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>(&arg1.peers, arg2)) {
            let v0 = 0x2::table::borrow_mut<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>(&mut arg1.peers, arg2);
            0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::set_address(v0, arg3);
            0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::set_token_decimals(v0, arg4);
            0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::rate_limit::set_limit(0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::borrow_inbound_rate_limit_mut(v0), arg5, arg6);
        } else {
            0x2::table::add<u16, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::Peer>(&mut arg1.peers, arg2, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::peer::new(arg3, arg4, arg5));
        };
    }

    public fun set_threshold<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u8) {
        arg1.threshold = arg2;
    }

    public(friend) fun set_version<T0>(arg0: &mut State<T0>, arg1: u64) {
        assert!(arg1 >= arg0.version, 13906834530825666559);
        arg0.version = arg1;
    }

    public(friend) fun try_release_in<T0>(arg0: &mut State<T0>, arg1: u16, arg2: 0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::ntt_manager_message::NttManagerMessage<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>, arg3: &0x2::clock::Clock) : bool {
        0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::try_release<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::borrow_inbox_item_mut<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(&mut arg0.inbox, 0xc9e63118b6b1566fa38975f067ea8d56627e227290d1a52dbd96096f0ce376df::inbox::new_inbox_key<0xbba3cc8a05ab6f62ca8b42ac022a08f8d63ff463f8578978c3e4cab37ad8de3a::native_token_transfer::NativeTokenTransfer>(arg1, arg2)), arg3)
    }

    // decompiled from Move bytecode v6
}

