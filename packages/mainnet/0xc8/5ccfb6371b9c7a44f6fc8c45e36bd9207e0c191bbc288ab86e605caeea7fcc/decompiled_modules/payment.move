module 0xc85ccfb6371b9c7a44f6fc8c45e36bd9207e0c191bbc288ab86e605caeea7fcc::payment {
    struct AuditRequested has copy, drop {
        user: address,
        repo_url: vector<u8>,
        repo_id: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    public fun get_audit_price() : u64 {
        500000000
    }

    public fun get_treasury() : address {
        @0x29153a2ce03cb6d986e1fb23cd46c24693afd70ab1208e05469fde30379addb2
    }

    public entry fun request_audit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 500000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0x29153a2ce03cb6d986e1fb23cd46c24693afd70ab1208e05469fde30379addb2);
        let v1 = AuditRequested{
            user      : 0x2::tx_context::sender(arg4),
            repo_url  : arg1,
            repo_id   : arg2,
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AuditRequested>(v1);
    }

    public entry fun request_audit_exact(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 500000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, 500000000, arg4), @0x29153a2ce03cb6d986e1fb23cd46c24693afd70ab1208e05469fde30379addb2);
        let v0 = AuditRequested{
            user      : 0x2::tx_context::sender(arg4),
            repo_url  : arg1,
            repo_id   : arg2,
            amount    : 500000000,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AuditRequested>(v0);
    }

    // decompiled from Move bytecode v6
}

