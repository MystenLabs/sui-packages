module 0x89139211aac66986da056559dcc3010703b22847e1559e8479eba716227db400::sponsor {
    struct Treasury has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        signer_pubkey: vector<u8>,
        paused: bool,
        max_per_loan: u64,
        day_cap: u64,
        day_start_ms: u64,
        day_spent: u64,
        price_base: u64,
        price_per_mib: u64,
        min_epochs: u32,
        total_lent: u64,
        total_returned: u64,
        loans: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::object::ID,
    }

    struct Loan {
        treasury: 0x2::object::ID,
        blob_id: u256,
        size: u64,
        epoch: u32,
        amount: u64,
    }

    struct NonceKey has copy, drop, store {
        nonce: u64,
    }

    struct BlobKey has copy, drop, store {
        blob: 0x2::object::ID,
    }

    struct TreasuryCreated has copy, drop {
        treasury: 0x2::object::ID,
        admin: address,
    }

    struct Lent has copy, drop {
        treasury: 0x2::object::ID,
        user: address,
        blob_id: u256,
        size: u64,
        amount: u64,
        nonce: u64,
    }

    struct Settled has copy, drop {
        treasury: 0x2::object::ID,
        user: address,
        blob: 0x2::object::ID,
        blob_id: u256,
        size: u64,
        spent: u64,
        returned: u64,
    }

    struct Deposited has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        treasury: 0x2::object::ID,
        amount: u64,
    }

    struct ConfigChanged has copy, drop {
        treasury: 0x2::object::ID,
        paused: bool,
        max_per_loan: u64,
        day_cap: u64,
    }

    struct PricingChanged has copy, drop {
        treasury: 0x2::object::ID,
        price_base: u64,
        price_per_mib: u64,
        min_epochs: u32,
    }

    struct SignerRotated has copy, drop {
        treasury: 0x2::object::ID,
    }

    public fun borrow(arg0: &mut Treasury, arg1: u256, arg2: u64, arg3: u32, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, Loan) {
        let v0 = voucher_message(0x2::object::id<Treasury>(arg0), 0x2::tx_context::sender(arg9), arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.signer_pubkey, &v0), 2);
        borrow_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg8), arg9)
    }

    public fun balance_of(arg0: &Treasury) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance)
    }

    public fun blob_used(arg0: &Treasury, arg1: 0x2::object::ID) : bool {
        let v0 = BlobKey{blob: arg1};
        0x2::dynamic_field::exists<BlobKey>(&arg0.id, v0)
    }

    fun borrow_impl(arg0: &mut Treasury, arg1: u256, arg2: u64, arg3: u32, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, Loan) {
        assert!(arg0.version == 1, 16);
        assert!(!arg0.paused, 0);
        assert!(arg7 <= arg6, 1);
        assert!(arg4 > 0, 7);
        assert!(arg4 <= arg0.max_per_loan, 4);
        assert!(arg4 <= price_ceiling(arg0, arg2), 17);
        let v0 = NonceKey{nonce: arg5};
        assert!(!0x2::dynamic_field::exists<NonceKey>(&arg0.id, v0), 3);
        if (arg7 >= arg0.day_start_ms + 86400000) {
            arg0.day_start_ms = arg7;
            arg0.day_spent = 0;
        };
        assert!(arg0.day_spent + arg4 <= arg0.day_cap, 5);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance) >= arg4, 6);
        let v1 = NonceKey{nonce: arg5};
        0x2::dynamic_field::add<NonceKey, u64>(&mut arg0.id, v1, arg6);
        arg0.day_spent = arg0.day_spent + arg4;
        arg0.total_lent = arg0.total_lent + arg4;
        arg0.loans = arg0.loans + 1;
        let v2 = 0x2::object::id<Treasury>(arg0);
        let v3 = Lent{
            treasury : v2,
            user     : 0x2::tx_context::sender(arg8),
            blob_id  : arg1,
            size     : arg2,
            amount   : arg4,
            nonce    : arg5,
        };
        0x2::event::emit<Lent>(v3);
        let v4 = Loan{
            treasury : v2,
            blob_id  : arg1,
            size     : arg2,
            epoch    : arg3,
            amount   : arg4,
        };
        (0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, arg4), arg8), v4)
    }

    public fun create(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 15);
        assert!(arg3 > 0 && arg5 > 0, 20);
        let v0 = Treasury{
            id             : 0x2::object::new(arg6),
            version        : 1,
            balance        : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            signer_pubkey  : arg0,
            paused         : false,
            max_per_loan   : arg1,
            day_cap        : arg2,
            day_start_ms   : 0,
            day_spent      : 0,
            price_base     : arg3,
            price_per_mib  : arg4,
            min_epochs     : arg5,
            total_lent     : 0,
            total_returned : 0,
            loans          : 0,
        };
        let v1 = 0x2::object::id<Treasury>(&v0);
        let v2 = TreasuryCreated{
            treasury : v1,
            admin    : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<TreasuryCreated>(v2);
        0x2::transfer::share_object<Treasury>(v0);
        AdminCap{
            id       : 0x2::object::new(arg6),
            treasury : v1,
        }
    }

    public fun deposit(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
        let v0 = Deposited{
            treasury : 0x2::object::id<Treasury>(arg0),
            amount   : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1),
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun is_paused(arg0: &Treasury) : bool {
        arg0.paused
    }

    public fun limits(arg0: &Treasury) : (u64, u64, u64, u64) {
        (arg0.max_per_loan, arg0.day_cap, arg0.day_start_ms, arg0.day_spent)
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Treasury) {
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg1), 14);
        assert!(arg1.version < 1, 16);
        arg1.version = 1;
    }

    public fun nonce_used(arg0: &Treasury, arg1: u64) : bool {
        let v0 = NonceKey{nonce: arg1};
        0x2::dynamic_field::exists<NonceKey>(&arg0.id, v0)
    }

    public fun price_ceiling(arg0: &Treasury, arg1: u64) : u64 {
        arg0.price_base + arg0.price_per_mib * (arg1 + 1048576 - 1) / 1048576
    }

    public fun pricing(arg0: &Treasury) : (u64, u64, u32) {
        (arg0.price_base, arg0.price_per_mib, arg0.min_epochs)
    }

    fun prune_impl(arg0: &mut Treasury, arg1: vector<u64>, arg2: u64) {
        0x1::vector::reverse<u64>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = NonceKey{nonce: 0x1::vector::pop_back<u64>(&mut arg1)};
            if (0x2::dynamic_field::exists<NonceKey>(&arg0.id, v1)) {
                assert!(arg2 > *0x2::dynamic_field::borrow<NonceKey, u64>(&arg0.id, v1), 21);
                0x2::dynamic_field::remove<NonceKey, u64>(&mut arg0.id, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg1);
    }

    public fun prune_nonces(arg0: &mut Treasury, arg1: vector<u64>, arg2: &0x2::clock::Clock) {
        prune_impl(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun rotate_signer(arg0: &AdminCap, arg1: &mut Treasury, arg2: vector<u8>) {
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg1), 14);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 15);
        arg1.signer_pubkey = arg2;
        let v0 = SignerRotated{treasury: 0x2::object::id<Treasury>(arg1)};
        0x2::event::emit<SignerRotated>(v0);
    }

    public fun set_config(arg0: &AdminCap, arg1: &mut Treasury, arg2: bool, arg3: u64, arg4: u64) {
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg1), 14);
        arg1.paused = arg2;
        arg1.max_per_loan = arg3;
        arg1.day_cap = arg4;
        let v0 = ConfigChanged{
            treasury     : 0x2::object::id<Treasury>(arg1),
            paused       : arg2,
            max_per_loan : arg3,
            day_cap      : arg4,
        };
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_pricing(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: u64, arg4: u32) {
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg1), 14);
        assert!(arg2 > 0 && arg4 > 0, 20);
        arg1.price_base = arg2;
        arg1.price_per_mib = arg3;
        arg1.min_epochs = arg4;
        let v0 = PricingChanged{
            treasury      : 0x2::object::id<Treasury>(arg1),
            price_base    : arg2,
            price_per_mib : arg3,
            min_epochs    : arg4,
        };
        0x2::event::emit<PricingChanged>(v0);
    }

    public fun settle(arg0: &mut Treasury, arg1: Loan, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x2::tx_context::TxContext) {
        settle_impl(arg0, arg1, 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg2), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(&arg2), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(&arg2), 0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(&arg2)), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::registered_epoch(&arg2), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg2), arg3, arg4);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg2, 0x2::tx_context::sender(arg4));
    }

    fun settle_impl(arg0: &mut Treasury, arg1: Loan, arg2: 0x2::object::ID, arg3: u256, arg4: u64, arg5: bool, arg6: bool, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg10: &0x2::tx_context::TxContext) {
        let Loan {
            treasury : v0,
            blob_id  : v1,
            size     : v2,
            epoch    : v3,
            amount   : v4,
        } = arg1;
        assert!(arg0.version == 1, 16);
        assert!(v0 == 0x2::object::id<Treasury>(arg0), 8);
        assert!(arg3 == v1, 9);
        assert!(arg4 == v2, 10);
        assert!(!arg5, 11);
        assert!(!arg6, 18);
        assert!(arg7 >= v3, 19);
        assert!((arg8 as u64) >= (arg7 as u64) + (arg0.min_epochs as u64), 12);
        let v5 = BlobKey{blob: arg2};
        assert!(!0x2::dynamic_field::exists<BlobKey>(&arg0.id, v5), 13);
        let v6 = BlobKey{blob: arg2};
        0x2::dynamic_field::add<BlobKey, bool>(&mut arg0.id, v6, true);
        let v7 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg9);
        arg0.total_returned = arg0.total_returned + v7;
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg9));
        let v8 = if (v7 >= v4) {
            0
        } else {
            v4 - v7
        };
        let v9 = Settled{
            treasury : v0,
            user     : 0x2::tx_context::sender(arg10),
            blob     : arg2,
            blob_id  : arg3,
            size     : arg4,
            spent    : v8,
            returned : v7,
        };
        0x2::event::emit<Settled>(v9);
    }

    public fun totals(arg0: &Treasury) : (u64, u64, u64) {
        (arg0.total_lent, arg0.total_returned, arg0.loans)
    }

    public fun voucher_message(arg0: 0x2::object::ID, arg1: address, arg2: u256, arg3: u64, arg4: u32, arg5: u64, arg6: u64, arg7: u64) : vector<u8> {
        let v0 = b"epoch-walrus-sponsor/voucher/v2";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        v0
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg1), 14);
        let v0 = Withdrawn{
            treasury : 0x2::object::id<Treasury>(arg1),
            amount   : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

