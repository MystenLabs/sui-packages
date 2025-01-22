module 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::events {
    struct TransactionRegistered has copy, drop {
        channel_id: 0x2::object::ID,
        transaction: 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction,
    }

    struct TransactionRemoved has copy, drop {
        channel_id: 0x2::object::ID,
    }

    public(friend) fun transaction_registered(arg0: 0x2::object::ID, arg1: 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction) {
        let v0 = TransactionRegistered{
            channel_id  : arg0,
            transaction : arg1,
        };
        0x2::event::emit<TransactionRegistered>(v0);
    }

    public(friend) fun transaction_removed(arg0: 0x2::object::ID) {
        let v0 = TransactionRemoved{channel_id: arg0};
        0x2::event::emit<TransactionRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

