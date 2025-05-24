module 0xb760e8b6c4d77d5dc88248ec083567aa8ed7894710aa9876eabc3e7747501d9d::main {
    struct WalletIndexedEvent has copy, drop {
        wallet: address,
        indexer: address,
        timestamp: u64,
        reason: 0x1::string::String,
        version: u64,
    }

    struct IndexerCap has key {
        id: 0x2::object::UID,
        version: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IndexerCap{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::transfer<IndexerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun record_wallet_indexed(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::utf8(arg1) != 0x1::string::utf8(b""), 1);
        let v0 = WalletIndexedEvent{
            wallet    : arg0,
            indexer   : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
            reason    : 0x1::string::utf8(arg1),
            version   : 1,
        };
        0x2::event::emit<WalletIndexedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

