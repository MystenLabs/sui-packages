module 0x66a44a869fe8ea7354620f7c356514efc30490679aa5cb24b453480e97790677::ignite {
    struct IgniteRequested has copy, drop {
        request_id: address,
        sender: address,
        chain: vector<u8>,
        encrypted_recipient: vector<u8>,
        iusd_burned: u64,
        timestamp_ms: u64,
    }

    struct IgniteFulfilled has copy, drop {
        request_id: address,
        executor: address,
        chain: vector<u8>,
        target_tx_hash: vector<u8>,
        quilt_blob_id: vector<u8>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        ultron: address,
    }

    struct IgniteRequest has key {
        id: 0x2::object::UID,
        sender: address,
        chain: vector<u8>,
        encrypted_recipient: vector<u8>,
        iusd_burned: u64,
        created_ms: u64,
        fulfilled: bool,
    }

    entry fun ignite_req(arg0: &Config, arg1: &mut 0x2::coin::TreasuryCap<0x2c5653668edefe2a782bf755e02bda56149e7b65b56f6245fb75b718941d2ec9::iusd::IUSD>, arg2: 0x2::coin::Coin<0x2c5653668edefe2a782bf755e02bda56149e7b65b56f6245fb75b718941d2ec9::iusd::IUSD>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2c5653668edefe2a782bf755e02bda56149e7b65b56f6245fb75b718941d2ec9::iusd::IUSD>(&arg2);
        assert!(v0 >= 100000000, 0);
        0x2::coin::burn<0x2c5653668edefe2a782bf755e02bda56149e7b65b56f6245fb75b718941d2ec9::iusd::IUSD>(arg1, arg2);
        let v1 = IgniteRequest{
            id                  : 0x2::object::new(arg6),
            sender              : 0x2::tx_context::sender(arg6),
            chain               : arg3,
            encrypted_recipient : arg4,
            iusd_burned         : v0,
            created_ms          : 0x2::clock::timestamp_ms(arg5),
            fulfilled           : false,
        };
        let v2 = 0x2::object::id<IgniteRequest>(&v1);
        let v3 = IgniteRequested{
            request_id          : 0x2::object::id_to_address(&v2),
            sender              : 0x2::tx_context::sender(arg6),
            chain               : v1.chain,
            encrypted_recipient : v1.encrypted_recipient,
            iusd_burned         : v0,
            timestamp_ms        : v1.created_ms,
        };
        0x2::event::emit<IgniteRequested>(v3);
        0x2::transfer::transfer<IgniteRequest>(v1, arg0.ultron);
    }

    entry fun ignite_resp(arg0: &Config, arg1: IgniteRequest, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.ultron, 1);
        assert!(!arg1.fulfilled, 2);
        let v0 = 0x2::object::id<IgniteRequest>(&arg1);
        let v1 = IgniteFulfilled{
            request_id     : 0x2::object::id_to_address(&v0),
            executor       : 0x2::tx_context::sender(arg4),
            chain          : arg1.chain,
            target_tx_hash : arg2,
            quilt_blob_id  : arg3,
        };
        0x2::event::emit<IgniteFulfilled>(v1);
        let IgniteRequest {
            id                  : v2,
            sender              : _,
            chain               : _,
            encrypted_recipient : _,
            iusd_burned         : _,
            created_ms          : _,
            fulfilled           : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id     : 0x2::object::new(arg0),
            ultron : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    entry fun set_ultron(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.ultron, 1);
        arg0.ultron = arg1;
    }

    // decompiled from Move bytecode v6
}

