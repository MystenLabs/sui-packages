module 0xf9d58122a5e6643ef0519701d7ff754492c40295a34460dfd0dae9da07d07f71::drop_escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EscrowRegistry has key {
        id: 0x2::object::UID,
        escrows: 0x2::table::Table<vector<u8>, EscrowRecord>,
        treasury_address: address,
        next_escrow_id: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct EscrowRecord has store {
        id: vector<u8>,
        payer: address,
        creator: address,
        slug: vector<u8>,
        amount: u64,
        status: u8,
        created_at: u64,
        expires_at: u64,
        processed_at: 0x1::option::Option<u64>,
    }

    struct EscrowCreatedEvent has copy, drop, store {
        escrow_id: vector<u8>,
        payer: address,
        creator: address,
        slug: vector<u8>,
        amount: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct EscrowProcessedEvent has copy, drop, store {
        escrow_id: vector<u8>,
        payer: address,
        creator: address,
        amount: u64,
        approved: bool,
        creator_amount: 0x1::option::Option<u64>,
        treasury_amount: 0x1::option::Option<u64>,
        timestamp: u64,
    }

    struct EscrowRefundedEvent has copy, drop, store {
        escrow_id: vector<u8>,
        payer: address,
        amount: u64,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct TreasuryUpdatedEvent has copy, drop, store {
        old_treasury: address,
        new_treasury: address,
        updated_by: address,
    }

    public entry fun claim_expired_escrow(arg0: &mut EscrowRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, EscrowRecord>(&arg0.escrows, arg1), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, EscrowRecord>(&mut arg0.escrows, arg1);
        assert!(v0.status == 0, 3);
        assert!(v0.payer == 0x2::tx_context::sender(arg3), 5);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 > v0.expires_at, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v0.amount, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0.amount), arg3), v0.payer);
        v0.status = 3;
        v0.processed_at = 0x1::option::some<u64>(v1);
        let v2 = EscrowRefundedEvent{
            escrow_id : arg1,
            payer     : v0.payer,
            amount    : v0.amount,
            reason    : b"Escrow expired",
            timestamp : v1,
        };
        0x2::event::emit<EscrowRefundedEvent>(v2);
    }

    public entry fun create_escrow_payment(arg0: address, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut EscrowRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = v1 + 900000;
        let v3 = generate_escrow_id(arg3, arg5);
        let v4 = EscrowRecord{
            id           : v3,
            payer        : 0x2::tx_context::sender(arg5),
            creator      : arg0,
            slug         : arg1,
            amount       : v0,
            status       : 0,
            created_at   : v1,
            expires_at   : v2,
            processed_at : 0x1::option::none<u64>(),
        };
        0x2::table::add<vector<u8>, EscrowRecord>(&mut arg3.escrows, v3, v4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v5 = EscrowCreatedEvent{
            escrow_id  : v3,
            payer      : 0x2::tx_context::sender(arg5),
            creator    : arg0,
            slug       : arg1,
            amount     : v0,
            expires_at : v2,
            timestamp  : v1,
        };
        0x2::event::emit<EscrowCreatedEvent>(v5);
    }

    fun generate_escrow_id(arg0: &mut EscrowRegistry, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = arg0.next_escrow_id;
        arg0.next_escrow_id = v0 + 1;
        let v1 = u64_to_string(v0);
        *0x1::string::as_bytes(&v1)
    }

    public fun get_escrow_details(arg0: &EscrowRegistry, arg1: vector<u8>) : (address, address, vector<u8>, u64, u8, u64, u64) {
        assert!(0x2::table::contains<vector<u8>, EscrowRecord>(&arg0.escrows, arg1), 2);
        let v0 = 0x2::table::borrow<vector<u8>, EscrowRecord>(&arg0.escrows, arg1);
        (v0.payer, v0.creator, v0.slug, v0.amount, v0.status, v0.created_at, v0.expires_at)
    }

    public fun get_total_escrow_balance(arg0: &EscrowRegistry) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_treasury_address(arg0: &EscrowRegistry) : address {
        arg0.treasury_address
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xa3e0e39b604e588c90d17bf29768340a279151eb5ec0d578e3ed2fc09edf31b5);
        let v1 = EscrowRegistry{
            id               : 0x2::object::new(arg0),
            escrows          : 0x2::table::new<vector<u8>, EscrowRecord>(arg0),
            treasury_address : @0xa3e0e39b604e588c90d17bf29768340a279151eb5ec0d578e3ed2fc09edf31b5,
            next_escrow_id   : 1,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<EscrowRegistry>(v1);
    }

    public entry fun process_escrow_approval(arg0: &AdminCap, arg1: &mut EscrowRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, EscrowRecord>(&arg1.escrows, arg2), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, EscrowRecord>(&mut arg1.escrows, arg2);
        assert!(v0.status == 0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 <= v0.expires_at, 6);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= v0.amount, 4);
        let v2 = v0.amount;
        let v3 = v2 / 10;
        let v4 = v2 - v3;
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v4), arg4), v0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4), arg1.treasury_address);
        v0.status = 1;
        v0.processed_at = 0x1::option::some<u64>(v1);
        let v6 = EscrowProcessedEvent{
            escrow_id       : arg2,
            payer           : v0.payer,
            creator         : v0.creator,
            amount          : v2,
            approved        : true,
            creator_amount  : 0x1::option::some<u64>(v4),
            treasury_amount : 0x1::option::some<u64>(v3),
            timestamp       : v1,
        };
        0x2::event::emit<EscrowProcessedEvent>(v6);
    }

    public entry fun process_escrow_refund(arg0: &AdminCap, arg1: &mut EscrowRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, EscrowRecord>(&arg1.escrows, arg2), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, EscrowRecord>(&mut arg1.escrows, arg2);
        assert!(v0.status == 0, 3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= v0.amount, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0.amount), arg5), v0.payer);
        v0.status = 2;
        v0.processed_at = 0x1::option::some<u64>(v1);
        let v2 = EscrowRefundedEvent{
            escrow_id : arg2,
            payer     : v0.payer,
            amount    : v0.amount,
            reason    : arg3,
            timestamp : v1,
        };
        0x2::event::emit<EscrowRefundedEvent>(v2);
        let v3 = EscrowProcessedEvent{
            escrow_id       : arg2,
            payer           : v0.payer,
            creator         : v0.creator,
            amount          : v0.amount,
            approved        : false,
            creator_amount  : 0x1::option::none<u64>(),
            treasury_amount : 0x1::option::none<u64>(),
            timestamp       : v1,
        };
        0x2::event::emit<EscrowProcessedEvent>(v3);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun update_treasury_address(arg0: &AdminCap, arg1: &mut EscrowRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury_address = arg2;
        let v0 = TreasuryUpdatedEvent{
            old_treasury : arg1.treasury_address,
            new_treasury : arg2,
            updated_by   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasuryUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

