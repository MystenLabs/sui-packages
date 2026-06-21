module 0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::peer_vault {
    struct PeerVaultRegistry has store, key {
        id: 0x2::object::UID,
        peer_vaults: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct PeerVault has store, key {
        id: 0x2::object::UID,
        peer_address: address,
        reserves: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        total_shares: u64,
        commission_bps: u64,
        peer_earnings: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    struct ShareCertificate has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    struct DelegateEvent has copy, drop {
        delegator: address,
        peer: address,
        wal_amount: u64,
        shares: u64,
    }

    struct UndelegateEvent has copy, drop {
        delegator: address,
        peer: address,
        shares: u64,
        wal_amount: u64,
    }

    struct RewardsEvent has copy, drop {
        peer: address,
        amount: u64,
        commission: u64,
    }

    struct EarningsClaimedEvent has copy, drop {
        peer: address,
        amount: u64,
    }

    public fun add_vault(arg0: &mut PeerVaultRegistry, arg1: &0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::staking::AdminCap, arg2: address, arg3: 0x2::object::ID) {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.peer_vaults, arg2)) {
            *0x2::table::borrow_mut<address, 0x2::object::ID>(&mut arg0.peer_vaults, arg2) = arg3;
        } else {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.peer_vaults, arg2, arg3);
        };
    }

    public fun cert_shares(arg0: &ShareCertificate) : u64 {
        arg0.shares
    }

    public fun cert_vault_id(arg0: &ShareCertificate) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun claim_earnings(arg0: &mut PeerVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.peer_address, 105);
        let v0 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.peer_earnings);
        assert!(v0 > 0, 106);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.peer_earnings, v0), arg1), 0x2::tx_context::sender(arg1));
        let v1 = EarningsClaimedEvent{
            peer   : arg0.peer_address,
            amount : v0,
        };
        0x2::event::emit<EarningsClaimedEvent>(v1);
    }

    public(friend) fun collect_rewards(arg0: &mut PeerVault, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1);
        assert!(v0 > 0, 101);
        let v1 = 0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::utils::mul_div(v0, arg0.commission_bps, 10000);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.peer_earnings, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1, v1, arg2)));
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.reserves, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
        let v2 = RewardsEvent{
            peer       : arg0.peer_address,
            amount     : v0,
            commission : v1,
        };
        0x2::event::emit<RewardsEvent>(v2);
    }

    public fun commission_bps(arg0: &PeerVault) : u64 {
        arg0.commission_bps
    }

    public fun create_vault(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 104);
        let v0 = PeerVault{
            id             : 0x2::object::new(arg2),
            peer_address   : arg0,
            reserves       : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            total_shares   : 0,
            commission_bps : arg1,
            peer_earnings  : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        0x2::transfer::public_share_object<PeerVault>(v0);
    }

    public fun delegate(arg0: &mut PeerVault, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1);
        assert!(v0 > 0, 101);
        let v1 = if (arg0.total_shares == 0) {
            v0
        } else {
            0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::utils::mul_div(v0, arg0.total_shares, 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.reserves))
        };
        assert!(v1 > 0, 102);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.reserves, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
        arg0.total_shares = arg0.total_shares + v1;
        let v2 = DelegateEvent{
            delegator  : 0x2::tx_context::sender(arg2),
            peer       : arg0.peer_address,
            wal_amount : v0,
            shares     : v1,
        };
        0x2::event::emit<DelegateEvent>(v2);
        let v3 = ShareCertificate{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<PeerVault>(arg0),
            shares   : v1,
        };
        0x2::transfer::public_transfer<ShareCertificate>(v3, 0x2::tx_context::sender(arg2));
    }

    public fun exchange_rate(arg0: &PeerVault) : u64 {
        if (arg0.total_shares == 0) {
            return 1000000000
        };
        0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::utils::mul_div(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.reserves), 1000000000, arg0.total_shares)
    }

    public fun new_registry(arg0: &0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::staking::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PeerVaultRegistry{
            id          : 0x2::object::new(arg1),
            peer_vaults : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::public_share_object<PeerVaultRegistry>(v0);
    }

    public fun new_vault(arg0: &mut PeerVaultRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PeerVault{
            id             : 0x2::object::new(arg1),
            peer_address   : 0x2::tx_context::sender(arg1),
            reserves       : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            total_shares   : 0,
            commission_bps : 1000,
            peer_earnings  : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.peer_vaults, v0.peer_address, 0x2::object::id<PeerVault>(&v0));
        0x2::transfer::public_share_object<PeerVault>(v0);
    }

    public fun peer_earnings(arg0: &PeerVault) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.peer_earnings)
    }

    public fun total_reserves(arg0: &PeerVault) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.reserves)
    }

    public fun total_shares(arg0: &PeerVault) : u64 {
        arg0.total_shares
    }

    public fun undelegate(arg0: &mut PeerVault, arg1: ShareCertificate, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PeerVault>(arg0) == arg1.vault_id, 103);
        let v0 = arg1.shares;
        assert!(v0 > 0, 101);
        let v1 = 0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::utils::mul_div(v0, 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.reserves), arg0.total_shares);
        arg0.total_shares = arg0.total_shares - v0;
        let ShareCertificate {
            id       : v2,
            vault_id : _,
            shares   : _,
        } = arg1;
        0x2::object::delete(v2);
        let v5 = UndelegateEvent{
            delegator  : 0x2::tx_context::sender(arg2),
            peer       : arg0.peer_address,
            shares     : v0,
            wal_amount : v1,
        };
        0x2::event::emit<UndelegateEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.reserves, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

