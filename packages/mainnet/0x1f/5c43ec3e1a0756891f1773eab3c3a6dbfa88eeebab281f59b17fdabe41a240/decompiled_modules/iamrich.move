module 0x1f5c43ec3e1a0756891f1773eab3c3a6dbfa88eeebab281f59b17fdabe41a240::iamrich {
    struct RichCrown has key {
        id: 0x2::object::UID,
        owner: address,
        username: 0x1::string::String,
        bid_amount: u64,
        timestamp: u64,
    }

    struct CrownClaimed has copy, drop {
        previous_owner: address,
        new_owner: address,
        username: 0x1::string::String,
        bid_amount: u64,
        timestamp: u64,
    }

    struct CrownLost has copy, drop {
        username: 0x1::string::String,
        bid_amount: u64,
        start_timestamp: u64,
        end_timestamp: u64,
        duration: u64,
    }

    public entry fun dethrone(arg0: &mut RichCrown, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = arg0.bid_amount;
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0x1::string::length(&arg2);
        assert!(v3 >= 0 && v3 <= 15, 0);
        assert!(v0 >= v1 + 1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad);
        if (v1 > 0) {
            let v4 = CrownLost{
                username        : arg0.username,
                bid_amount      : v1,
                start_timestamp : arg0.timestamp,
                end_timestamp   : v2,
                duration        : (v2 - arg0.timestamp) / 1000,
            };
            0x2::event::emit<CrownLost>(v4);
        };
        arg0.owner = 0x2::tx_context::sender(arg4);
        let v5 = if (0x1::string::length(&arg2) == 0) {
            0x1::string::utf8(b"Anonymous")
        } else {
            arg2
        };
        arg0.username = v5;
        arg0.bid_amount = v0;
        arg0.timestamp = v2;
        let v6 = CrownClaimed{
            previous_owner : arg0.owner,
            new_owner      : 0x2::tx_context::sender(arg4),
            username       : arg0.username,
            bid_amount     : v0,
            timestamp      : v2,
        };
        0x2::event::emit<CrownClaimed>(v6);
    }

    public fun get_crown_state(arg0: &RichCrown, arg1: &0x2::clock::Clock) : (address, 0x1::string::String, u64, u64, u64) {
        (arg0.owner, arg0.username, arg0.bid_amount, arg0.timestamp, (0x2::clock::timestamp_ms(arg1) - arg0.timestamp) / 1000)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RichCrown{
            id         : 0x2::object::new(arg0),
            owner      : 0x2::tx_context::sender(arg0),
            username   : 0x1::string::utf8(b"Anonymous"),
            bid_amount : 0,
            timestamp  : 1744857335741,
        };
        0x2::transfer::share_object<RichCrown>(v0);
    }

    // decompiled from Move bytecode v6
}

