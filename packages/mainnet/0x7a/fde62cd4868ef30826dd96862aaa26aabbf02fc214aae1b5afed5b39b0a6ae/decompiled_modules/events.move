module 0x7afde62cd4868ef30826dd96862aaa26aabbf02fc214aae1b5afed5b39b0a6ae::events {
    struct SimpleEvent has copy, drop {
        sender: address,
        timestamp: u64,
    }

    struct MintEvent has copy, drop {
        token_id: u64,
        recipient: address,
        minter: address,
    }

    struct BatchEvent has copy, drop {
        count: u64,
        minter: address,
        recipients: vector<address>,
    }

    struct FakeMintCounter has key {
        id: 0x2::object::UID,
        total_minted: u64,
    }

    struct BulkMintEvent has copy, drop {
        batch_size: u64,
        start_token_id: u64,
        minter: address,
        timestamp: u64,
    }

    public entry fun fake_bulk_mint(arg0: &mut FakeMintCounter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 1000, 0);
        assert!(arg1 > 0, 1);
        arg0.total_minted = arg0.total_minted + arg1;
        let v0 = BatchEvent{
            count      : arg1,
            minter     : 0x2::tx_context::sender(arg2),
            recipients : 0x1::vector::empty<address>(),
        };
        0x2::event::emit<BatchEvent>(v0);
    }

    public entry fun fake_mint_multiple(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = MintEvent{
            token_id  : arg3,
            recipient : arg0,
            minter    : v0,
        };
        0x2::event::emit<MintEvent>(v1);
        let v2 = MintEvent{
            token_id  : arg3 + 1,
            recipient : arg1,
            minter    : v0,
        };
        0x2::event::emit<MintEvent>(v2);
        let v3 = MintEvent{
            token_id  : arg3 + 2,
            recipient : arg2,
            minter    : v0,
        };
        0x2::event::emit<MintEvent>(v3);
    }

    public entry fun fake_mint_single(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintEvent{
            token_id  : arg1,
            recipient : arg0,
            minter    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun fake_mint_tiny_batch(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 <= 5, 0);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = MintEvent{
                token_id  : arg1 + v2,
                recipient : *0x1::vector::borrow<address>(&arg0, v2),
                minter    : v1,
            };
            0x2::event::emit<MintEvent>(v3);
            v2 = v2 + 1;
        };
        let v4 = BatchEvent{
            count      : v0,
            minter     : v1,
            recipients : arg0,
        };
        0x2::event::emit<BatchEvent>(v4);
    }

    public fun get_total_minted(arg0: &FakeMintCounter) : u64 {
        arg0.total_minted
    }

    public entry fun init_counter(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FakeMintCounter{
            id           : 0x2::object::new(arg0),
            total_minted : 0,
        };
        0x2::transfer::share_object<FakeMintCounter>(v0);
    }

    public entry fun simple_test(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SimpleEvent{
            sender    : 0x2::tx_context::sender(arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<SimpleEvent>(v0);
    }

    public entry fun test_address(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintEvent{
            token_id  : 1,
            recipient : arg0,
            minter    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun test_number(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintEvent{
            token_id  : arg0,
            recipient : 0x2::tx_context::sender(arg1),
            minter    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun test_small_vector(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 <= 10, 0);
        assert!(v0 > 0, 1);
        let v1 = BatchEvent{
            count      : v0,
            minter     : 0x2::tx_context::sender(arg1),
            recipients : arg0,
        };
        0x2::event::emit<BatchEvent>(v1);
    }

    public entry fun ultra_simple_bulk_mint(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 10000, 0);
        assert!(arg0 > 0, 1);
        let v0 = BulkMintEvent{
            batch_size     : arg0,
            start_token_id : arg1,
            minter         : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<BulkMintEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

