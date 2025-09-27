module 0xbca59ac1a990488c4b1226c8710c3f6dd98a18848abe711cfb579f34ac87f9a1::htlc {
    struct HTLC has store, key {
        id: 0x2::object::UID,
        htlc_id: vector<u8>,
        hashlock: vector<u8>,
        timelock: u64,
        sender: address,
        receiver: address,
        amount: u64,
        secret: vector<u8>,
        withdrawn: bool,
        refunded: bool,
        created_at: u64,
        coin: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    struct HTLCCreatedEvent has copy, drop {
        htlc_id: vector<u8>,
        sender: address,
        receiver: address,
        amount: u64,
        hashlock: vector<u8>,
        timelock: u64,
    }

    struct HTLCClaimedEvent has copy, drop {
        htlc_id: vector<u8>,
        receiver: address,
        secret: vector<u8>,
        amount: u64,
    }

    struct HTLCRefundedEvent has copy, drop {
        htlc_id: vector<u8>,
        sender: address,
        amount: u64,
    }

    public entry fun claim_with_secret(arg0: &0x2::clock::Clock, arg1: &mut HTLC, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.receiver == v0, 7);
        assert!(!arg1.withdrawn, 3);
        assert!(!arg1.refunded, 4);
        assert!(0x2::clock::timestamp_ms(arg0) / 1000 < arg1.timelock, 6);
        assert!(0x1::hash::sha2_256(arg2) == arg1.hashlock, 2);
        arg1.secret = arg2;
        arg1.withdrawn = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.coin), v0);
        let v1 = HTLCClaimedEvent{
            htlc_id  : arg1.htlc_id,
            receiver : v0,
            secret   : arg2,
            amount   : arg1.amount,
        };
        0x2::event::emit<HTLCClaimedEvent>(v1);
    }

    public entry fun create_htlc(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v1 = HTLC{
            id         : 0x2::object::new(arg6),
            htlc_id    : arg1,
            hashlock   : arg3,
            timelock   : arg4,
            sender     : 0x2::tx_context::sender(arg6),
            receiver   : arg2,
            amount     : v0,
            secret     : 0x1::vector::empty<u8>(),
            withdrawn  : false,
            refunded   : false,
            created_at : 0x2::clock::timestamp_ms(arg0) / 1000,
            coin       : 0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(arg5),
        };
        let v2 = HTLCCreatedEvent{
            htlc_id  : arg1,
            sender   : 0x2::tx_context::sender(arg6),
            receiver : arg2,
            amount   : v0,
            hashlock : arg3,
            timelock : arg4,
        };
        0x2::event::emit<HTLCCreatedEvent>(v2);
        0x2::transfer::public_share_object<HTLC>(v1);
    }

    public fun get_htlc_info(arg0: &HTLC) : (vector<u8>, vector<u8>, u64, address, address, u64, vector<u8>, bool, bool, u64) {
        (arg0.htlc_id, arg0.hashlock, arg0.timelock, arg0.sender, arg0.receiver, arg0.amount, arg0.secret, arg0.withdrawn, arg0.refunded, arg0.created_at)
    }

    public fun get_revealed_secret(arg0: &HTLC) : vector<u8> {
        arg0.secret
    }

    public entry fun refund_htlc(arg0: &0x2::clock::Clock, arg1: &mut HTLC, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.sender == v0, 7);
        assert!(!arg1.withdrawn, 3);
        assert!(!arg1.refunded, 4);
        assert!(0x2::clock::timestamp_ms(arg0) / 1000 >= arg1.timelock, 5);
        arg1.refunded = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.coin), v0);
        let v1 = HTLCRefundedEvent{
            htlc_id : arg1.htlc_id,
            sender  : v0,
            amount  : arg1.amount,
        };
        0x2::event::emit<HTLCRefundedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

