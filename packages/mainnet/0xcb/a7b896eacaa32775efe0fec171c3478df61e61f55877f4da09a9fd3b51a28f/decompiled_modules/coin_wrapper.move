module 0xcba7b896eacaa32775efe0fec171c3478df61e61f55877f4da09a9fd3b51a28f::coin_wrapper {
    struct WrappedSui has store, key {
        id: 0x2::object::UID,
        inner: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public fun unwrap(arg0: WrappedSui, arg1: &mut 0x2::tx_context::TxContext) {
        let WrappedSui {
            id    : v0,
            inner : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun wrap_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedSui{
            id    : 0x2::object::new(arg2),
            inner : arg0,
        };
        0x2::transfer::public_transfer<WrappedSui>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

