module 0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::distribution {
    struct DISTRIBUTION has drop {
        dummy_field: bool,
    }

    struct DistributionPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        hashes: 0x2::vec_set::VecSet<address>,
        recipients: 0x2::linked_table::LinkedTable<address, u64>,
        total_pool_amount: u64,
    }

    public fun new(arg0: &0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::AirdropConfigCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DistributionPool{
            id                : 0x2::object::new(arg2),
            balance           : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            hashes            : 0x2::vec_set::from_keys<address>(arg1),
            recipients        : 0x2::linked_table::new<address, u64>(arg2),
            total_pool_amount : 0,
        };
        0x2::transfer::share_object<DistributionPool>(v0);
    }

    public(friend) fun create_hash(arg0: vector<address>, arg1: vector<u64>) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<address>>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u64>>(&arg1));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun distribute(arg0: &mut DistributionPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 4);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance) > 0, 5);
        assert!(0x2::linked_table::length<address, u64>(&arg0.recipients) > 0, 7);
        let v0 = 0;
        while (v0 < 0x1::u64::min(0x2::linked_table::length<address, u64>(&arg0.recipients), arg1)) {
            let (v1, v2) = 0x2::linked_table::pop_back<address, u64>(&mut arg0.recipients);
            0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::airdrop::transfer(0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::airdrop::new(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, v2), arg2), v1);
            v0 = v0 + 1;
        };
    }

    public fun fund_pool(arg0: &mut DistributionPool, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        assert!(0x2::linked_table::length<address, u64>(&arg0.recipients) > 0, 4);
        assert!(0x2::vec_set::size<address>(&arg0.hashes) == 0, 4);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance) == 0, 6);
        assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1) == arg0.total_pool_amount, 3);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    fun init(arg0: DISTRIBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION>(arg0, arg1);
    }

    public fun prepare_recipients(arg0: &mut DistributionPool, arg1: vector<address>, arg2: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 2);
        let v0 = create_hash(arg1, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.hashes, &v0), 1);
        0x2::vec_set::remove<address>(&mut arg0.hashes, &v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            arg0.total_pool_amount = arg0.total_pool_amount + v2;
            0x2::linked_table::push_back<address, u64>(&mut arg0.recipients, 0x1::vector::pop_back<address>(&mut arg1), v2);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

