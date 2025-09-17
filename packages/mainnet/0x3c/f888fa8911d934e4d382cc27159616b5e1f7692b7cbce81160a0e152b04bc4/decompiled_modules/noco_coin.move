module 0x3cf888fa8911d934e4d382cc27159616b5e1f7692b7cbce81160a0e152b04bc4::noco_coin {
    struct NOCO has drop {
        dummy_field: bool,
    }

    struct NOCO_COIN has drop {
        dummy_field: bool,
    }

    struct TokenCreatedEvent has copy, drop {
        total_supply: u64,
        initial_holders: vector<address>,
        decimals: u8,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        creation_time: u64,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        value: u64,
        timestamp: u64,
    }

    struct BatchTransferEvent has copy, drop {
        sender: address,
        recipient_count: u64,
        total_amount: u64,
        timestamp: u64,
    }

    public fun get_decimals(arg0: &0x2::coin::CoinMetadata<NOCO>) : u8 {
        0x2::coin::get_decimals<NOCO>(arg0)
    }

    public fun get_description(arg0: &0x2::coin::CoinMetadata<NOCO>) : 0x1::string::String {
        0x2::coin::get_description<NOCO>(arg0)
    }

    public fun get_icon_url(arg0: &0x2::coin::CoinMetadata<NOCO>) : 0x1::option::Option<0x2::url::Url> {
        0x2::coin::get_icon_url<NOCO>(arg0)
    }

    public fun get_name(arg0: &0x2::coin::CoinMetadata<NOCO>) : 0x1::string::String {
        0x2::coin::get_name<NOCO>(arg0)
    }

    public fun get_symbol(arg0: &0x2::coin::CoinMetadata<NOCO>) : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x2::coin::get_symbol<NOCO>(arg0)))
    }

    public fun transfer(arg0: 0x2::coin::Coin<NOCO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NOCO>>(arg0, arg1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 > 0, 1006);
        let v1 = TransferEvent{
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
            value     : 0x2::coin::value<NOCO>(&arg0),
            timestamp : v0,
        };
        0x2::event::emit<TransferEvent>(v1);
    }

    public fun balance_of(arg0: &0x2::coin::Coin<NOCO>) : u64 {
        0x2::coin::value<NOCO>(arg0)
    }

    public fun batch_transfer(arg0: &mut 0x2::coin::Coin<NOCO>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1005);
        assert!(!0x1::vector::is_empty<address>(&arg1), 1005);
        assert!(0x1::vector::length<address>(&arg1) <= 50, 1005);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v0);
            assert!(v2 > 0, 1005);
            assert!(v2 <= 0x2::coin::value<NOCO>(arg0), 1001);
            assert!(v2 >= 1000, 1005);
            0x2::transfer::public_transfer<0x2::coin::Coin<NOCO>>(0x2::coin::split<NOCO>(arg0, v2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v1 = v1 + v2;
            v0 = v0 + 1;
        };
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        assert!(v3 > 0, 1006);
        let v4 = BatchTransferEvent{
            sender          : 0x2::tx_context::sender(arg3),
            recipient_count : 0x1::vector::length<address>(&arg1),
            total_amount    : v1,
            timestamp       : v3,
        };
        0x2::event::emit<BatchTransferEvent>(v4);
    }

    public fun estimate_gas_cost(arg0: u8, arg1: u64) : u64 {
        1000000
    }

    public fun get_allocation_info() : (u64, u64, u64) {
        (200000000000000, 300000000000000, 500000000000000)
    }

    public fun get_coin_info(arg0: &0x2::coin::CoinMetadata<NOCO>) : (0x1::string::String, 0x1::string::String, u8, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (get_name(arg0), get_symbol(arg0), get_decimals(arg0), get_description(arg0), get_icon_url(arg0))
    }

    public fun get_contract_info() : (address, address, address) {
        (@0x5b4fd361831af129f56fd80439d432cbbc04a3e49d1600df27a252dfbde85858, @0xfd0075affe368dd8397c7a62e32940f52ba28d953444e294380f07a9536425a2, @0x8655a8334dd8e91d7e201a7b8d72eda89b1ddf5af451ff13dae9abc3f1d68d4b)
    }

    public fun get_creation_time(arg0: &0x2::tx_context::TxContext) : u64 {
        0x2::tx_context::epoch_timestamp_ms(arg0)
    }

    public fun get_error_message(arg0: u64) : 0x1::string::String {
        0x1::string::utf8(b"Unknown error")
    }

    public fun get_lightweight_info() : (0x1::string::String, 0x1::string::String, u8) {
        (0x1::string::utf8(b"NOCO"), 0x1::string::utf8(b"NOCO Protocol"), 9)
    }

    public fun get_token_display_info() : (0x1::string::String, 0x1::string::String, u8, 0x1::string::String, 0x1::string::String) {
        (0x1::string::utf8(b"NOCO Protocol"), 0x1::string::utf8(b"NOCO"), 9, 0x1::string::utf8(b"1000000"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreibiiffprjvznukjsut6jqz6dik7zghlv6ycvpdocgx4dgzi4jxsc4"))
    }

    fun init(arg0: NOCO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOCO_COIN>(arg0, 9, b"NOCO", b"NOCO Protocol", b"NOCO is a utility token built on Sui blockchain with advanced features including batch transfers, burn mechanisms, and Web3 wallet compatibility. NOCO serves as the native utility token for the NOCO ecosystem. Logo: https://gateway.pinata.cloud/ipfs/bafkreibiiffprjvznukjsut6jqz6dik7zghlv6ycvpdocgx4dgzi4jxsc4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreibiiffprjvznukjsut6jqz6dik7zghlv6ycvpdocgx4dgzi4jxsc4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOCO_COIN>>(0x2::coin::mint<NOCO_COIN>(&mut v2, 200000000000000, arg1), @0x5b4fd361831af129f56fd80439d432cbbc04a3e49d1600df27a252dfbde85858);
        0x2::transfer::public_transfer<0x2::coin::Coin<NOCO_COIN>>(0x2::coin::mint<NOCO_COIN>(&mut v2, 300000000000000, arg1), @0xfd0075affe368dd8397c7a62e32940f52ba28d953444e294380f07a9536425a2);
        0x2::transfer::public_transfer<0x2::coin::Coin<NOCO_COIN>>(0x2::coin::mint<NOCO_COIN>(&mut v2, 500000000000000, arg1), @0x8655a8334dd8e91d7e201a7b8d72eda89b1ddf5af451ff13dae9abc3f1d68d4b);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOCO_COIN>>(v2, @0x0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOCO_COIN>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, @0x5b4fd361831af129f56fd80439d432cbbc04a3e49d1600df27a252dfbde85858);
        0x1::vector::push_back<address>(&mut v3, @0xfd0075affe368dd8397c7a62e32940f52ba28d953444e294380f07a9536425a2);
        0x1::vector::push_back<address>(&mut v3, @0x8655a8334dd8e91d7e201a7b8d72eda89b1ddf5af451ff13dae9abc3f1d68d4b);
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(v4 > 0, 1006);
        let v5 = TokenCreatedEvent{
            total_supply    : 1000000000000000,
            initial_holders : v3,
            decimals        : 9,
            symbol          : 0x1::string::utf8(b"NOCO"),
            name            : 0x1::string::utf8(b"NOCO Protocol"),
            creation_time   : v4,
        };
        0x2::event::emit<TokenCreatedEvent>(v5);
    }

    public fun merge_coins(arg0: &mut 0x2::coin::Coin<NOCO>, arg1: 0x2::coin::Coin<NOCO>) {
        0x2::coin::join<NOCO>(arg0, arg1);
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<NOCO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NOCO>>(0x2::coin::split<NOCO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun total_supply() : u64 {
        1000000000000000
    }

    public fun transfer_coin(arg0: 0x2::coin::Coin<NOCO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NOCO>>(arg0, arg1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 > 0, 1006);
        let v1 = TransferEvent{
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
            value     : 0x2::coin::value<NOCO>(&arg0),
            timestamp : v0,
        };
        0x2::event::emit<TransferEvent>(v1);
    }

    public fun validate_timestamp(arg0: u64) : bool {
        arg0 > 0
    }

    // decompiled from Move bytecode v6
}

