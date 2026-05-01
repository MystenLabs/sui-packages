module 0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_share_code {
    struct ShareCodeRegistry has key {
        id: 0x2::object::UID,
        code_to_addr: 0x2::table::Table<vector<u8>, address>,
        addr_to_code: 0x2::table::Table<address, vector<u8>>,
        total_claims: u64,
    }

    struct ShareCodeClaimed has copy, drop {
        owner: address,
        code: vector<u8>,
        timestamp: u64,
        serial: u64,
    }

    public entry fun claim(arg0: &mut ShareCodeRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, vector<u8>>(&arg0.addr_to_code, v0), 303);
        assert!(0x1::vector::length<u8>(&arg1) == 8, 300);
        assert!(is_valid_alphabet(&arg1), 301);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.code_to_addr, arg1), 302);
        do_claim(arg0, v0, arg1, arg2);
    }

    public entry fun claim_or_noop(arg0: &mut ShareCodeRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, vector<u8>>(&arg0.addr_to_code, v0)) {
            return
        };
        if (0x1::vector::length<u8>(&arg1) != 8) {
            return
        };
        if (!is_valid_alphabet(&arg1)) {
            return
        };
        if (0x2::table::contains<vector<u8>, address>(&arg0.code_to_addr, arg1)) {
            return
        };
        do_claim(arg0, v0, arg1, arg2);
    }

    public fun code_exists(arg0: &ShareCodeRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, address>(&arg0.code_to_addr, arg1)
    }

    fun copy_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun do_claim(arg0: &mut ShareCodeRegistry, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        arg0.total_claims = arg0.total_claims + 1;
        0x2::table::add<vector<u8>, address>(&mut arg0.code_to_addr, arg2, arg1);
        0x2::table::add<address, vector<u8>>(&mut arg0.addr_to_code, arg1, copy_bytes(&arg2));
        let v0 = ShareCodeClaimed{
            owner     : arg1,
            code      : copy_bytes(&arg2),
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
            serial    : arg0.total_claims,
        };
        0x2::event::emit<ShareCodeClaimed>(v0);
    }

    public fun get_code(arg0: &ShareCodeRegistry, arg1: address) : vector<u8> {
        copy_bytes(0x2::table::borrow<address, vector<u8>>(&arg0.addr_to_code, arg1))
    }

    public fun has_code(arg0: &ShareCodeRegistry, arg1: address) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.addr_to_code, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareCodeRegistry{
            id           : 0x2::object::new(arg0),
            code_to_addr : 0x2::table::new<vector<u8>, address>(arg0),
            addr_to_code : 0x2::table::new<address, vector<u8>>(arg0),
            total_claims : 0,
        };
        0x2::transfer::share_object<ShareCodeRegistry>(v0);
    }

    public entry fun init_registry(arg0: &0x5b1bde6bfef532d5753cfeabfe71d409aea33701c3ab6408373d7c6803248922::plsa_vault::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 304
    }

    fun is_valid_alphabet(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = if (v1 >= 50 && v1 <= 57) {
                true
            } else if (v1 >= 65 && v1 <= 72) {
                true
            } else if (v1 == 74) {
                true
            } else if (v1 == 75) {
                true
            } else if (v1 == 77) {
                true
            } else if (v1 == 78) {
                true
            } else if (v1 >= 80 && v1 <= 90) {
                true
            } else if (v1 >= 97 && v1 <= 104) {
                true
            } else if (v1 == 106) {
                true
            } else if (v1 == 107) {
                true
            } else if (v1 == 109) {
                true
            } else if (v1 == 110) {
                true
            } else {
                v1 >= 112 && v1 <= 122
            };
            if (!v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun resolve(arg0: &ShareCodeRegistry, arg1: vector<u8>) : address {
        *0x2::table::borrow<vector<u8>, address>(&arg0.code_to_addr, arg1)
    }

    public fun total_claims(arg0: &ShareCodeRegistry) : u64 {
        arg0.total_claims
    }

    // decompiled from Move bytecode v7
}

