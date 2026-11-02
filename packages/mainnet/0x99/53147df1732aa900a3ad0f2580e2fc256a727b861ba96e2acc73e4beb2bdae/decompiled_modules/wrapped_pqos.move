module 0x9953147df1732aa900a3ad0f2580e2fc256a727b861ba96e2acc73e4beb2bdae::wrapped_pqos {
    struct WRAPPED_PQOS has drop {
        dummy_field: bool,
    }

    struct Outpost has key {
        id: 0x2::object::UID,
        chain_tag: vector<u8>,
        route_chain_id: u32,
        supply_cap: u128,
        attestors: vector<vector<u8>>,
        threshold: u64,
        highest_nonce: u64,
        minted_total: u128,
    }

    struct Ticket has drop {
        version: u8,
        direction: u8,
        chain_id: u32,
        nonce: u64,
        amount: u128,
        recipient: vector<u8>,
        expiry: u64,
    }

    public fun burn(arg0: &mut Outpost, arg1: &mut 0x2::coin::TreasuryCap<WRAPPED_PQOS>, arg2: 0x2::coin::Coin<WRAPPED_PQOS>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::coin::value<WRAPPED_PQOS>(&arg2);
        assert!(v0 > 0, 9);
        arg0.minted_total = arg0.minted_total - (v0 as u128);
        arg0.highest_nonce = arg0.highest_nonce + 1;
        0x2::coin::burn<WRAPPED_PQOS>(arg1, arg2);
        let v1 = Ticket{
            version   : 1,
            direction : 1,
            chain_id  : arg0.route_chain_id,
            nonce     : arg0.highest_nonce,
            amount    : (v0 as u128),
            recipient : arg3,
            expiry    : 0,
        };
        encode_ticket(&v1)
    }

    public fun mint(arg0: &mut Outpost, arg1: &mut 0x2::coin::TreasuryCap<WRAPPED_PQOS>, arg2: Ticket, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 0);
        assert!(arg2.direction == 0, 1);
        assert!(arg2.chain_id == arg0.route_chain_id, 2);
        assert!(arg2.amount > 0, 9);
        assert!(arg2.nonce > arg0.highest_nonce, 7);
        assert!(count_valid(arg0, ticket_digest(arg0, arg3), arg4) >= arg0.threshold, 5);
        let v0 = arg2.amount / 1000000000000000;
        assert!(v0 > 0, 9);
        let v1 = arg0.minted_total + v0;
        assert!(v1 <= arg0.supply_cap, 4);
        arg0.highest_nonce = arg2.nonce;
        arg0.minted_total = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<WRAPPED_PQOS>>(0x2::coin::mint<WRAPPED_PQOS>(arg1, (v0 as u64), arg5), 0x2::tx_context::sender(arg5));
    }

    fun count_valid(arg0: &Outpost, arg1: vector<u8>, arg2: vector<vector<u8>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            if (signature_matches(arg0, arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_outpost(arg0: vector<u8>, arg1: u32, arg2: u128, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg3) > 0, 8);
        assert!(arg4 > 0 && arg4 <= 0x1::vector::length<vector<u8>>(&arg3), 8);
        let v0 = Outpost{
            id             : 0x2::object::new(arg5),
            chain_tag      : arg0,
            route_chain_id : arg1,
            supply_cap     : arg2,
            attestors      : arg3,
            threshold      : arg4,
            highest_nonce  : 0,
            minted_total   : 0,
        };
        0x2::transfer::share_object<Outpost>(v0);
    }

    public fun encode_ticket(arg0: &Ticket) : vector<u8> {
        let v0 = b"GRP-TICKET-v1";
        0x1::vector::push_back<u8>(&mut v0, arg0.version);
        0x1::vector::push_back<u8>(&mut v0, arg0.direction);
        let v1 = &mut v0;
        push_u32(v1, arg0.chain_id);
        let v2 = &mut v0;
        push_u64(v2, arg0.nonce);
        let v3 = &mut v0;
        push_u128(v3, arg0.amount);
        0x1::vector::append<u8>(&mut v0, arg0.recipient);
        let v4 = &mut v0;
        push_u64(v4, arg0.expiry);
        0x1::hash::sha2_256(v0)
    }

    fun init(arg0: WRAPPED_PQOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRAPPED_PQOS>(arg0, 9, b"wPQOS", b"Wrapped TIAMAT", b"GRIDCHAIN attested outpost; cap-bounded; not trustless", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRAPPED_PQOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRAPPED_PQOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun push_u128(arg0: &mut vector<u8>, arg1: u128) {
        let v0 = 16;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> (v1 as u8) * 8) as u8));
        };
    }

    fun push_u32(arg0: &mut vector<u8>, arg1: u32) {
        push_u64(arg0, (arg1 as u64));
    }

    fun push_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 8;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            0x1::vector::push_back<u8>(arg0, ((arg1 >> (v1 as u8) * 8) as u8));
        };
    }

    fun signature_matches(arg0: &Outpost, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.attestors)) {
            if (0x2::ed25519::ed25519_verify(&arg2, 0x1::vector::borrow<vector<u8>>(&arg0.attestors, v0), &arg1)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun ticket_digest(arg0: &Outpost, arg1: vector<u8>) : vector<u8> {
        let v0 = b"GRP-SIG-v1";
        0x1::vector::append<u8>(&mut v0, arg0.chain_tag);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::hash::sha2_256(v0)
    }

    // decompiled from Move bytecode v6
}

