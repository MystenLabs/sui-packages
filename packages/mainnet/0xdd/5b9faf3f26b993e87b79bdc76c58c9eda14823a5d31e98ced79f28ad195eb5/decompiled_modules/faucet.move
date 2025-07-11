module 0xdd5b9faf3f26b993e87b79bdc76c58c9eda14823a5d31e98ced79f28ad195eb5::faucet {
    struct AgentFactory has key {
        id: 0x2::object::UID,
        next_agent_str: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AGENT_00000 has drop, store {
        dummy_field: bool,
    }

    public fun create<T0: drop + store>(arg0: &AdminCap, arg1: T0, arg2: &mut AgentFactory, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg1, arg3, arg5, arg4, arg6, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg7)), arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        let v2 = &mut arg2.next_agent_str;
        increment_agent_str(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun create_agent_0000(arg0: &AdminCap, arg1: &mut AgentFactory, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = AGENT_00000{dummy_field: false};
        create<AGENT_00000>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun increment_agent_str(arg0: &mut 0x1::string::String) {
        let v0 = 0x1::u64::to_string(parse_u64_from_bytes(0x1::string::into_bytes(0x1::string::substring(arg0, 6, 0x1::string::length(arg0)))) + 1);
        while (0x1::string::length(&v0) < 4) {
            let v1 = 0x1::string::utf8(b"0");
            0x1::string::append(&mut v1, v0);
            v0 = v1;
        };
        let v2 = 0x1::string::utf8(b"AGENT_");
        0x1::string::append(&mut v2, v0);
        *arg0 = v2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    fun parse_u64_from_bytes(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            assert!(v2 >= 48 && v2 <= 57, 0);
            let v3 = v0 * 10;
            v0 = v3 + ((v2 - 48) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

