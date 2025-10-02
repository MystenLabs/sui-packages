module 0x89649ef0dfb61ca70ae7df23392a7ad162d87ec15843d1f82c343c46c9f233f4::honeypot_token {
    struct HoneypotToken has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
        is_armed: bool,
        trigger_count: u64,
        creator: address,
        recovery_address: address,
    }

    struct TokenCreated has copy, drop {
        token_id: address,
        name: 0x1::string::String,
        creator: address,
        timestamp: u64,
    }

    struct AttackerInfected has copy, drop {
        attacker_wallet: address,
        token_amount: u64,
        timestamp: u64,
        payload_status: u8,
    }

    public fun create_honeypot_token(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = HoneypotToken{
            id               : 0x2::object::new(arg5),
            name             : 0x1::string::utf8(arg0),
            symbol           : 0x1::string::utf8(arg1),
            decimals         : arg2,
            total_supply     : arg3,
            is_armed         : true,
            trigger_count    : 0,
            creator          : 0x2::tx_context::sender(arg5),
            recovery_address : arg4,
        };
        let v1 = 0x2::object::id<HoneypotToken>(&v0);
        let v2 = TokenCreated{
            token_id  : 0x2::object::id_to_address(&v1),
            name      : v0.name,
            creator   : v0.creator,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<TokenCreated>(v2);
        0x2::transfer::public_transfer<HoneypotToken>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun get_token_info(arg0: &HoneypotToken) : (0x1::string::String, 0x1::string::String, u8, u64, bool, u64) {
        (arg0.name, arg0.symbol, arg0.decimals, arg0.total_supply, arg0.is_armed, arg0.trigger_count)
    }

    fun is_known_attacker(arg0: address) : bool {
        let v0 = vector[@0x5c79fa907c321fff2f4dc9847b4cc06ed3c8ba784abccdca6b90d383032ddbd8, @0xe64368d74ac79f4828712494f9fc20e9c3eb13d4066f1fd34774a7b21d499107];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            if (arg0 == *0x1::vector::borrow<address>(&v0, v1)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun trigger_payload(arg0: &mut HoneypotToken, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.is_armed, 401);
        assert!(v0 != arg0.creator, 402);
        arg0.trigger_count = arg0.trigger_count + 1;
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = AttackerInfected{
            attacker_wallet : v0,
            token_amount    : v1,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg2),
            payload_status  : 2,
        };
        0x2::event::emit<AttackerInfected>(v2);
        if (is_known_attacker(v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.recovery_address);
        };
        let v3 = AttackerInfected{
            attacker_wallet : v0,
            token_amount    : v1,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg2),
            payload_status  : 3,
        };
        0x2::event::emit<AttackerInfected>(v3);
    }

    // decompiled from Move bytecode v6
}

