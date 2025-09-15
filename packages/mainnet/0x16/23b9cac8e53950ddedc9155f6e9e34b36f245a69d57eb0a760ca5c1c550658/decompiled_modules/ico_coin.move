module 0x1623b9cac8e53950ddedc9155f6e9e34b36f245a69d57eb0a760ca5c1c550658::ico_coin {
    struct ICO has drop {
        dummy_field: bool,
    }

    struct ICO_COIN has drop {
        dummy_field: bool,
    }

    struct TokenCreatedEvent has copy, drop {
        total_supply: u64,
        initial_holders: vector<address>,
        decimals: u8,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        value: u64,
        timestamp: u64,
    }

    struct BurnEvent has copy, drop {
        burner: address,
        amount: u64,
        timestamp: u64,
    }

    struct BatchTransferEvent has copy, drop {
        sender: address,
        recipient_count: u64,
        total_amount: u64,
        timestamp: u64,
    }

    public fun get_decimals(arg0: &0x2::coin::CoinMetadata<ICO>) : u8 {
        0x2::coin::get_decimals<ICO>(arg0)
    }

    public fun get_description(arg0: &0x2::coin::CoinMetadata<ICO>) : 0x1::string::String {
        0x2::coin::get_description<ICO>(arg0)
    }

    public fun get_icon_url(arg0: &0x2::coin::CoinMetadata<ICO>) : 0x1::option::Option<0x2::url::Url> {
        0x2::coin::get_icon_url<ICO>(arg0)
    }

    public fun get_name(arg0: &0x2::coin::CoinMetadata<ICO>) : 0x1::string::String {
        0x2::coin::get_name<ICO>(arg0)
    }

    public fun get_symbol(arg0: &0x2::coin::CoinMetadata<ICO>) : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x2::coin::get_symbol<ICO>(arg0)))
    }

    public fun transfer(arg0: 0x2::coin::Coin<ICO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ICO>>(arg0, arg1);
        let v0 = TransferEvent{
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
            value     : 0x2::coin::value<ICO>(&arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public fun balance_of(arg0: &0x2::coin::Coin<ICO>) : u64 {
        0x2::coin::value<ICO>(arg0)
    }

    public fun batch_burn(arg0: vector<0x2::coin::Coin<ICO>>) {
        let v0 = 0x2::balance::zero<ICO>();
        while (!0x1::vector::is_empty<0x2::coin::Coin<ICO>>(&arg0)) {
            0x2::coin::put<ICO>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<ICO>>(&mut arg0));
        };
        0x2::balance::join<ICO>(&mut v0, 0x2::balance::zero<ICO>());
        0x2::balance::destroy_zero<ICO>(v0);
        0x1::vector::destroy_empty<0x2::coin::Coin<ICO>>(arg0);
    }

    public fun batch_transfer(arg0: &mut 0x2::coin::Coin<ICO>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1005);
        assert!(!0x1::vector::is_empty<address>(&arg1), 1005);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v0);
            assert!(v2 > 0, 1005);
            assert!(v2 <= 0x2::coin::value<ICO>(arg0), 1001);
            0x2::transfer::public_transfer<0x2::coin::Coin<ICO>>(0x2::coin::split<ICO>(arg0, v2, arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v1 = v1 + v2;
            v0 = v0 + 1;
        };
        let v3 = BatchTransferEvent{
            sender          : 0x2::tx_context::sender(arg3),
            recipient_count : 0x1::vector::length<address>(&arg1),
            total_amount    : v1,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BatchTransferEvent>(v3);
    }

    public fun burn_coin(arg0: 0x2::coin::Coin<ICO>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnEvent{
            burner    : 0x2::tx_context::sender(arg1),
            amount    : 0x2::coin::value<ICO>(&arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<BurnEvent>(v0);
        let v1 = 0x2::balance::zero<ICO>();
        0x2::coin::put<ICO>(&mut v1, arg0);
        0x2::balance::join<ICO>(&mut v1, 0x2::balance::zero<ICO>());
        0x2::balance::destroy_zero<ICO>(v1);
    }

    public fun estimate_gas_cost(arg0: u8, arg1: u64) : u64 {
        1000000
    }

    public fun get_coin_info(arg0: &0x2::coin::CoinMetadata<ICO>) : (0x1::string::String, 0x1::string::String, u8, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (get_name(arg0), get_symbol(arg0), get_decimals(arg0), get_description(arg0), get_icon_url(arg0))
    }

    public fun get_error_message(arg0: u64) : 0x1::string::String {
        0x1::string::utf8(b"Unknown error")
    }

    public fun get_lightweight_info() : (0x1::string::String, 0x1::string::String, u8) {
        (0x1::string::utf8(b"RCO"), 0x1::string::utf8(b"Rco Protocol"), 9)
    }

    public fun get_realtime_info() : (u64, u64, u64, u64) {
        (10000000000000000, 10000000000000000, 3, 0)
    }

    public fun get_token_display_info() : (0x1::string::String, 0x1::string::String, u8, 0x1::string::String, 0x1::string::String) {
        (0x1::string::utf8(b"Rco Protocol"), 0x1::string::utf8(b"RCO"), 9, 0x1::string::utf8(b"10000000"), 0x1::string::utf8(b"https://magenta-quickest-fly-406.mypinata.cloud/ipfs/bafkreic32lutm2qbfcvjkfvdbpoveohx2lfanvj3jaynjw3ivlqkzungam"))
    }

    fun init(arg0: ICO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 10000000000000000;
        let v1 = 0x2::tx_context::sender(arg1);
        let (v2, v3) = 0x2::coin::create_currency<ICO_COIN>(arg0, 9, b"RCO", b"Rco Protocol", b"RCO is a utility token built on Sui blockchain with advanced features including batch transfers, burn mechanisms, and Web3 wallet compatibility. RCO serves as the native utility token for the RCO ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-quickest-fly-406.mypinata.cloud/ipfs/bafkreic32lutm2qbfcvjkfvdbpoveohx2lfanvj3jaynjw3ivlqkzungam")), arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<ICO_COIN>>(0x2::coin::mint<ICO_COIN>(&mut v4, v0, arg1), v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICO_COIN>>(v4, @0x0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICO_COIN>>(v3, v1);
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, v1);
        let v6 = TokenCreatedEvent{
            total_supply    : v0,
            initial_holders : v5,
            decimals        : 9,
            symbol          : 0x1::string::utf8(b"RCO"),
            name            : 0x1::string::utf8(b"Rco Protocol"),
        };
        0x2::event::emit<TokenCreatedEvent>(v6);
    }

    public fun merge_coins(arg0: &mut 0x2::coin::Coin<ICO>, arg1: 0x2::coin::Coin<ICO>) {
        0x2::coin::join<ICO>(arg0, arg1);
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<ICO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ICO>>(0x2::coin::split<ICO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun total_supply() : u64 {
        10000000000000000
    }

    public fun transfer_coin(arg0: 0x2::coin::Coin<ICO>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ICO>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

