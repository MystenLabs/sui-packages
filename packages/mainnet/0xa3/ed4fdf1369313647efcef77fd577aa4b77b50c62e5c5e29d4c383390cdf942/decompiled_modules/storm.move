module 0xa3ed4fdf1369313647efcef77fd577aa4b77b50c62e5c5e29d4c383390cdf942::storm {
    struct Signaled has copy, drop {
        storm_id: vector<u8>,
        timestamp_ms: u64,
    }

    struct Questfi has copy, drop {
        storm_id: vector<u8>,
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
    }

    struct Storm has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Signal has copy, drop, store {
        payload: vector<u8>,
        aes_key: vector<u8>,
        aes_nonce: vector<u8>,
        timestamp_ms: u64,
    }

    struct Thunderstorm has store {
        signals: vector<Signal>,
        last_activity_ms: u64,
    }

    public fun count(arg0: &Storm, arg1: vector<u8>) : u64 {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            return 0
        };
        0x1::vector::length<Signal>(&0x2::dynamic_field::borrow<vector<u8>, Thunderstorm>(&arg0.id, arg1).signals)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storm{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Storm>(v0);
    }

    entry fun quest(arg0: &Storm, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, Thunderstorm>(&arg0.id, arg1);
        assert!(!0x1::vector::is_empty<Signal>(&v0.signals), 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Signal>(&v0.signals)) {
            let v2 = 0x1::vector::borrow<Signal>(&v0.signals, v1);
            let v3 = Questfi{
                storm_id  : arg1,
                payload   : v2.payload,
                aes_key   : v2.aes_key,
                aes_nonce : v2.aes_nonce,
            };
            0x2::event::emit<Questfi>(v3);
            v1 = v1 + 1;
        };
    }

    entry fun signal(arg0: &mut Storm, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Signal{
            payload      : arg2,
            aes_key      : arg3,
            aes_nonce    : arg4,
            timestamp_ms : v0,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
            0x1::vector::push_back<Signal>(&mut v2.signals, v1);
            v2.last_activity_ms = v0;
        } else {
            let v3 = 0x1::vector::empty<Signal>();
            0x1::vector::push_back<Signal>(&mut v3, v1);
            let v4 = Thunderstorm{
                signals          : v3,
                last_activity_ms : v0,
            };
            0x2::dynamic_field::add<vector<u8>, Thunderstorm>(&mut arg0.id, arg1, v4);
        };
        let v5 = Signaled{
            storm_id     : arg1,
            timestamp_ms : v0,
        };
        0x2::event::emit<Signaled>(v5);
    }

    entry fun strike(arg0: &mut Storm, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
        assert!(!0x1::vector::is_empty<Signal>(&v0.signals), 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Signal>(&v0.signals)) {
            let v2 = 0x1::vector::borrow<Signal>(&v0.signals, v1);
            let v3 = Questfi{
                storm_id  : arg1,
                payload   : v2.payload,
                aes_key   : v2.aes_key,
                aes_nonce : v2.aes_nonce,
            };
            0x2::event::emit<Questfi>(v3);
            v1 = v1 + 1;
        };
        v0.signals = 0x1::vector::empty<Signal>();
        v0.last_activity_ms = 0x2::clock::timestamp_ms(arg2);
    }

    entry fun sweep(arg0: &mut Storm, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::dynamic_field::borrow<vector<u8>, Thunderstorm>(&arg0.id, arg1);
        assert!(0x1::vector::is_empty<Signal>(&v0.signals), 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.last_activity_ms + 604800000, 1);
        let Thunderstorm {
            signals          : _,
            last_activity_ms : _,
        } = 0x2::dynamic_field::remove<vector<u8>, Thunderstorm>(&mut arg0.id, arg1);
    }

    // decompiled from Move bytecode v6
}

