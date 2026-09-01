module 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::reserve {
    struct PlatformReserve has key {
        id: 0x2::object::UID,
        admin: address,
        authorized_callers: vector<address>,
        wal_balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    public fun id(arg0: &PlatformReserve) : &0x2::object::UID {
        &arg0.id
    }

    public fun admin(arg0: &PlatformReserve) : address {
        arg0.admin
    }

    public(friend) fun assert_caller_authorized(arg0: &PlatformReserve, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || 0x1::vector::contains<address>(&arg0.authorized_callers, &v0), 1);
    }

    public fun authorize_caller(arg0: &mut PlatformReserve, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (!0x1::vector::contains<address>(&arg0.authorized_callers, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_callers, arg1);
        };
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_reserve_caller_authorized(0x2::object::id<PlatformReserve>(arg0), arg0.admin, arg1);
    }

    public fun authorized_callers(arg0: &PlatformReserve) : &vector<address> {
        &arg0.authorized_callers
    }

    fun create_and_share_reserve(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformReserve{
            id                 : 0x2::object::new(arg0),
            admin              : 0x2::tx_context::sender(arg0),
            authorized_callers : 0x1::vector::empty<address>(),
            wal_balance        : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        0x2::transfer::share_object<PlatformReserve>(v0);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_reserve_created(0x2::object::id<PlatformReserve>(&v0), v0.admin);
    }

    public fun deauthorize_caller(arg0: &mut PlatformReserve, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.authorized_callers, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.authorized_callers, v1);
        };
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_reserve_caller_deauthorized(0x2::object::id<PlatformReserve>(arg0), arg0.admin, arg1);
    }

    public(friend) fun deposit_wal(arg0: &mut PlatformReserve, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun fund(arg0: &mut PlatformReserve, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_reserve_funded(0x2::object::id<PlatformReserve>(arg0), 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_and_share_reserve(arg0);
    }

    public(friend) fun pull_wal(arg0: &mut PlatformReserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert_caller_authorized(arg0, arg2);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal_balance) >= arg1, 2);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_balance, arg1), arg2)
    }

    public fun wal_balance(arg0: &PlatformReserve) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal_balance)
    }

    public fun withdraw(arg0: &mut PlatformReserve, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal_balance) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_balance, arg1), arg3), arg2);
        0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::events::emit_reserve_withdrawn(0x2::object::id<PlatformReserve>(arg0), arg0.admin, arg2, arg1);
    }

    // decompiled from Move bytecode v7
}

