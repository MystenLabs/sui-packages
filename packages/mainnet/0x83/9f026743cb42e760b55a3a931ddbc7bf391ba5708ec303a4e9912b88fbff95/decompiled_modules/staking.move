module 0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::staking {
    struct Registry has store, key {
        id: 0x2::object::UID,
        peers: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Peer has store, key {
        id: 0x2::object::UID,
        peer_id: vector<u8>,
        sui_address: address,
        bond: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        is_active: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RegisterEvent has copy, drop {
        peer: address,
        peer_id: vector<u8>,
    }

    struct StakeEvent has copy, drop {
        peer: address,
        amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        peer: address,
        amount: u64,
    }

    struct SlashEvent has copy, drop {
        peer: address,
        amount: u64,
    }

    struct PeerIdUpdatedEvent has copy, drop {
        peer: address,
        old_peer_id: vector<u8>,
        new_peer_id: vector<u8>,
    }

    public fun add_stake(arg0: &Registry, arg1: &mut Peer, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.bond, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2));
        let v0 = StakeEvent{
            peer   : arg1.sui_address,
            amount : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1.bond),
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    public fun deactivate(arg0: &AdminCap, arg1: &mut Peer) {
        arg1.is_active = false;
    }

    public fun find_peer(arg0: &Registry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.peers, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.peers, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            peers : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::public_share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &Peer) : bool {
        arg0.is_active
    }

    public fun peer_id(arg0: &Peer) : &vector<u8> {
        &arg0.peer_id
    }

    public fun register(arg0: &mut Registry, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.peers, v0), 0);
        assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2) >= 1000000000, 1);
        let v1 = Peer{
            id          : 0x2::object::new(arg3),
            peer_id     : arg1,
            sui_address : v0,
            bond        : 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2),
            is_active   : true,
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.peers, v0, 0x2::object::id<Peer>(&v1));
        0x2::transfer::public_share_object<Peer>(v1);
        let v2 = RegisterEvent{
            peer    : v0,
            peer_id : arg1,
        };
        0x2::event::emit<RegisterEvent>(v2);
    }

    public fun slash(arg0: &AdminCap, arg1: &mut Peer, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1.bond) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.bond, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = SlashEvent{
            peer   : arg1.sui_address,
            amount : arg2,
        };
        0x2::event::emit<SlashEvent>(v0);
    }

    public fun sui_address(arg0: &Peer) : address {
        arg0.sui_address
    }

    public fun total_stake(arg0: &Peer) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.bond)
    }

    public fun unstake(arg0: &Registry, arg1: &mut Peer, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.sui_address, 4);
        let v0 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1.bond);
        assert!(v0 >= arg2, 2);
        assert!(v0 - arg2 >= 1000000000, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.bond, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v1 = UnstakeEvent{
            peer   : arg1.sui_address,
            amount : arg2,
        };
        0x2::event::emit<UnstakeEvent>(v1);
    }

    public fun update_peer_id(arg0: &Registry, arg1: &mut Peer, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.sui_address, 4);
        arg1.peer_id = arg2;
        let v0 = PeerIdUpdatedEvent{
            peer        : arg1.sui_address,
            old_peer_id : arg1.peer_id,
            new_peer_id : arg2,
        };
        0x2::event::emit<PeerIdUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

