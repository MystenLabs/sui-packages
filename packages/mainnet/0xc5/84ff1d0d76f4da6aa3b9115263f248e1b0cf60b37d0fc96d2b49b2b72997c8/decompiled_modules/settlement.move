module 0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::settlement {
    struct Settlement has store, key {
        id: 0x2::object::UID,
        read_price_per_mb: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentEvent has copy, drop {
        payer: address,
        payee: address,
        blob_hash: vector<u8>,
        amount: u64,
    }

    struct ReadPriceUpdatedEvent has copy, drop {
        old_price: u64,
        new_price: u64,
    }

    public fun compute_fee(arg0: &Settlement, arg1: u64) : u64 {
        assert!(arg1 > 0, 0);
        arg1 * arg0.read_price_per_mb
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Settlement{
            id                : 0x2::object::new(arg0),
            read_price_per_mb : 1000,
        };
        0x2::transfer::public_share_object<Settlement>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pay(arg0: &Settlement, arg1: &mut 0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::peer_vault::PeerVault, arg2: address, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4);
        assert!(v0 > 0, 0);
        0x9dd1a5dc551e322dd1b0394514ece30eb1e5f54d5de5b1f6fe135ebe24032b9c::peer_vault::collect_rewards(arg1, arg4, arg5);
        let v1 = PaymentEvent{
            payer     : 0x2::tx_context::sender(arg5),
            payee     : arg2,
            blob_hash : arg3,
            amount    : v0,
        };
        0x2::event::emit<PaymentEvent>(v1);
    }

    public fun read_price_per_mb(arg0: &Settlement) : u64 {
        arg0.read_price_per_mb
    }

    public fun set_read_price(arg0: &AdminCap, arg1: &mut Settlement, arg2: u64) {
        assert!(arg2 > 0, 0);
        assert!(arg2 <= 1000000000, 1);
        let v0 = ReadPriceUpdatedEvent{
            old_price : arg1.read_price_per_mb,
            new_price : arg2,
        };
        0x2::event::emit<ReadPriceUpdatedEvent>(v0);
        arg1.read_price_per_mb = arg2;
    }

    // decompiled from Move bytecode v7
}

