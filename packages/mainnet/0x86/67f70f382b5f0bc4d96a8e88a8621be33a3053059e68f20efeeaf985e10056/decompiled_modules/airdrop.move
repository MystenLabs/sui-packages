module 0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::airdrop {
    struct Locked has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        nft: 0x2::object::ID,
    }

    struct WALAirdrop has key {
        id: 0x2::object::UID,
        initial_allocation: u64,
        allocation_withdrawn: bool,
        locked_id: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg1: &mut 0x2::tx_context::TxContext) : WALAirdrop {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = Locked{
            id      : v0,
            balance : arg0,
            nft     : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::share_object<Locked>(v2);
        WALAirdrop{
            id                   : v1,
            initial_allocation   : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0),
            allocation_withdrawn : false,
            locked_id            : 0x2::object::uid_to_inner(&v0),
        }
    }

    public(friend) fun transfer(arg0: WALAirdrop, arg1: address) {
        0x2::transfer::transfer<WALAirdrop>(arg0, arg1);
    }

    public fun allocation_withdrawn(arg0: &WALAirdrop) : bool {
        arg0.allocation_withdrawn
    }

    public fun available_balance(arg0: &Locked) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance)
    }

    public fun initial_allocation(arg0: &WALAirdrop) : u64 {
        arg0.initial_allocation
    }

    public(friend) fun is_valid_for(arg0: &WALAirdrop, arg1: &Locked) : bool {
        arg1.nft == 0x2::object::uid_to_inner(&arg0.id)
    }

    public fun locked_id(arg0: &WALAirdrop) : 0x2::object::ID {
        arg0.locked_id
    }

    public fun recover(arg0: Locked, arg1: &mut 0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::AirdropConfig, arg2: &0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::AirdropRecoveryCap, arg3: &0x2::clock::Clock) {
        0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::assert_can_withdraw_funds(arg1, arg3);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::recovery_timestamp_ms(arg1), 1);
        let Locked {
            id      : v0,
            balance : v1,
            nft     : _,
        } = arg0;
        0x2::object::delete(v0);
        0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::merge_balance(arg1, v1);
    }

    public fun withdraw(arg0: &mut WALAirdrop, arg1: Locked, arg2: &0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::AirdropConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_for(arg0, &arg1), 2);
        0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::config::assert_can_withdraw_funds(arg2, arg3);
        let Locked {
            id      : v0,
            balance : v1,
            nft     : _,
        } = arg1;
        let v3 = v1;
        0x2::object::delete(v0);
        arg0.allocation_withdrawn = true;
        0x98af8b8fde88f3c4bdf0fcedcf9afee7d10f66d480b74fb5a3a2e23dc7f5a564::events::emit_nft_withdrawal(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v3), 0x2::object::uid_to_inner(&arg0.id));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

