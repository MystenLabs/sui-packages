module 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::state {
    struct State<phantom T0> has store, key {
        id: 0x2::object::UID,
        mode: 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::mode::Mode,
        balance: 0x2::balance::Balance<T0>,
        threshold: u8,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        peers: 0x2::table::Table<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>,
        outbox: 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::Outbox<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>,
        inbox: 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::Inbox<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>,
        transceivers: 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::TransceiverRegistry,
        chain_id: u16,
        next_sequence: u64,
        paused: bool,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: u16, arg1: 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::mode::Mode, arg2: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (State<T0>, AdminCap) {
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<T0>>(&arg2) == 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::mode::is_locking(&arg1), 13906834444926320639);
        let v0 = AdminCap{id: 0x2::object::new(arg4)};
        let v1 = State<T0>{
            id             : 0x2::object::new(arg4),
            mode           : arg1,
            balance        : 0x2::balance::zero<T0>(),
            threshold      : 0,
            treasury_cap   : arg2,
            peers          : 0x2::table::new<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>(arg4),
            outbox         : 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::new<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(18446744073709551615, arg4),
            inbox          : 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::new<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(arg4),
            transceivers   : 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::new(arg4),
            chain_id       : arg0,
            next_sequence  : 1,
            paused         : false,
            version        : 0,
            admin_cap_id   : 0x2::object::uid_to_inner(&v0.id),
            upgrade_cap_id : arg3,
        };
        (v1, v0)
    }

    public fun borrow_inbox_item<T0>(arg0: &State<T0>, arg1: u16, arg2: 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::ntt_manager_message::NttManagerMessage<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>) : &0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::InboxItem<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer> {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::borrow_inbox_item<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&arg0.inbox, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::new_inbox_key<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(arg1, arg2))
    }

    public(friend) fun borrow_inbox_item_mut<T0>(arg0: &mut State<T0>, arg1: u16, arg2: 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::ntt_manager_message::NttManagerMessage<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>) : &mut 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::InboxItem<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer> {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::borrow_inbox_item_mut<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&mut arg0.inbox, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::new_inbox_key<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(arg1, arg2))
    }

    public(friend) fun vote<T0, T1>(arg0: &mut State<T1>, arg1: u16, arg2: 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::ntt_manager_message::NttManagerMessage<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>) {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::vote<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&mut arg0.inbox, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::transceiver_id<T0>(&arg0.transceivers), 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::new_inbox_key<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(arg1, arg2));
    }

    public fun assert_not_paused<T0>(arg0: &State<T0>) {
        assert!(!arg0.paused, 13906835647517425669);
    }

    public(friend) fun borrow_balance<T0>(arg0: &State<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public(friend) fun borrow_balance_mut<T0>(arg0: &mut State<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun borrow_mode<T0>(arg0: &State<T0>) : &0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::mode::Mode {
        &arg0.mode
    }

    public fun borrow_outbox<T0>(arg0: &State<T0>) : &0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::Outbox<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer> {
        &arg0.outbox
    }

    public(friend) fun borrow_outbox_mut<T0>(arg0: &mut State<T0>) : &mut 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::Outbox<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer> {
        &mut arg0.outbox
    }

    public fun borrow_peer<T0>(arg0: &State<T0>, arg1: u16) : &0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer {
        0x2::table::borrow<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>(&arg0.peers, arg1)
    }

    public(friend) fun borrow_peer_mut<T0>(arg0: &mut State<T0>, arg1: u16) : &mut 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer {
        0x2::table::borrow_mut<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>(&mut arg0.peers, arg1)
    }

    public(friend) fun borrow_treasury_cap<T0>(arg0: &State<T0>) : &0x2::coin::TreasuryCap<T0> {
        0x1::option::borrow<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap)
    }

    public(friend) fun borrow_treasury_cap_mut<T0>(arg0: &mut State<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)
    }

    fun check_threshold_invariants<T0>(arg0: &State<T0>) {
        let v0 = arg0.threshold;
        let v1 = 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::get_enabled_transceivers(&arg0.transceivers);
        let v2 = 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::bitmap::count_ones(&v1);
        assert!(v0 <= v2, 13906835707646836739);
        if (v2 > 0) {
            assert!(v0 > 0, 13906835729121542145);
        };
    }

    public fun create_transceiver_message<T0, T1>(arg0: &mut State<T1>, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, arg2: &0x2::clock::Clock) : 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::outbound_message::OutboundMessage<0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::auth::ManagerAuth, T0> {
        assert_not_paused<T1>(arg0);
        let v0 = 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::new_outbox_key(arg1);
        assert!(0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::try_release<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&mut arg0.outbox, v0, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::transceiver_id<T0>(&arg0.transceivers), arg2), 13906835020451938303);
        let v1 = 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::borrow<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&arg0.outbox, v0);
        let (v2, v3, v4) = 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::ntt_manager_message::destruct<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(*0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::borrow_data<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(v1));
        let v5 = 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::auth::new_auth();
        0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::outbound_message::new<0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::auth::ManagerAuth, T0, State<T1>>(&v5, arg0, 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::ntt_manager_message::new<vector<u8>>(v2, v3, 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::to_bytes(v4)), *0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::borrow_recipient_ntt_manager_address<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(v1))
    }

    public fun disable_transceiver<T0>(arg0: &mut State<T0>, arg1: &AdminCap, arg2: u8) {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::disable_transceiver(&mut arg0.transceivers, arg2);
        let v0 = 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::get_enabled_transceivers(&arg0.transceivers);
        let v1 = 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::bitmap::count_ones(&v0);
        if (v1 < arg0.threshold) {
            arg0.threshold = v1;
        };
        check_threshold_invariants<T0>(arg0);
    }

    public fun enable_transceiver<T0>(arg0: &mut State<T0>, arg1: &AdminCap, arg2: u8) {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::enable_transceiver(&mut arg0.transceivers, arg2);
        check_threshold_invariants<T0>(arg0);
    }

    public fun get_chain_id<T0>(arg0: &State<T0>) : u16 {
        arg0.chain_id
    }

    public fun get_enabled_transceivers<T0>(arg0: &State<T0>) : 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::bitmap::Bitmap {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::get_enabled_transceivers(&arg0.transceivers)
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

    public fun is_paused<T0>(arg0: &State<T0>) : bool {
        arg0.paused
    }

    public(friend) fun next_message_id<T0>(arg0: &mut State<T0>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32 {
        let v0 = arg0.next_sequence;
        arg0.next_sequence = v0 + 1;
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_u256_be((v0 as u256))
    }

    public fun pause<T0>(arg0: &AdminCap, arg1: &mut State<T0>) {
        arg1.paused = true;
    }

    public fun register_transceiver<T0, T1>(arg0: &mut State<T1>, arg1: 0x2::object::ID, arg2: &AdminCap) {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::transceiver_registry::register_transceiver<T0>(&mut arg0.transceivers, arg1);
        if (arg0.threshold == 0) {
            arg0.threshold = 1;
        };
        check_threshold_invariants<T1>(arg0);
    }

    public fun return_treasury_cap<T0>(arg0: &mut State<T0>, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x1::option::fill<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap, arg1);
    }

    public fun set_outbound_rate_limit<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::rate_limit::set_limit(0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::outbox::borrow_rate_limit_mut<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&mut arg1.outbox), arg2, arg3);
    }

    public fun set_peer<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock) {
        if (0x2::table::contains<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>(&arg1.peers, arg2)) {
            let v0 = 0x2::table::borrow_mut<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>(&mut arg1.peers, arg2);
            0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::set_address(v0, arg3);
            0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::set_token_decimals(v0, arg4);
            0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::rate_limit::set_limit(0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::borrow_inbound_rate_limit_mut(v0), arg5, arg6);
        } else {
            0x2::table::add<u16, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::Peer>(&mut arg1.peers, arg2, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::peer::new(arg3, arg4, arg5));
        };
    }

    public fun set_threshold<T0>(arg0: &AdminCap, arg1: &mut State<T0>, arg2: u8) {
        assert!(arg2 > 0, 13906835295329845249);
        arg1.threshold = arg2;
        check_threshold_invariants<T0>(arg1);
    }

    public(friend) fun set_version<T0>(arg0: &mut State<T0>, arg1: u64) {
        assert!(arg1 >= arg0.version, 13906834586660241407);
        arg0.version = arg1;
    }

    public fun take_treasury_cap<T0>(arg0: &AdminCap, arg1: &mut State<T0>) : 0x2::coin::TreasuryCap<T0> {
        0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_cap)
    }

    public fun threshold<T0>(arg0: &State<T0>) : u8 {
        arg0.threshold
    }

    public(friend) fun try_release_in<T0>(arg0: &mut State<T0>, arg1: u16, arg2: 0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::ntt_manager_message::NttManagerMessage<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>, arg3: &0x2::clock::Clock) : bool {
        0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::try_release<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::borrow_inbox_item_mut<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(&mut arg0.inbox, 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::inbox::new_inbox_key<0x11ae7874d23a1a5bdfc60956778092096ef9786b3650f742bd12df16b59f0933::native_token_transfer::NativeTokenTransfer>(arg1, arg2)), arg3)
    }

    public fun unpause<T0>(arg0: &AdminCap, arg1: &mut State<T0>) {
        arg1.paused = false;
    }

    // decompiled from Move bytecode v6
}

