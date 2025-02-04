module 0x7c360c8ac51c4b567380fb48bd5e5b4576ec936a630c95aa92782240748b6283::coin_factory {
    struct CoinType has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        symbol: vector<u8>,
        name: vector<u8>,
        description: vector<u8>,
    }

    struct Coin has store, key {
        id: 0x2::object::UID,
        value: u64,
        coin_type_id: u64,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        next_id: u64,
        coin_types: vector<CoinType>,
    }

    public entry fun burn_coin(arg0: Coin, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Coin>(arg0, @0x1);
    }

    public entry fun create_coin(arg0: &mut Factory, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        let v1 = CoinType{
            id          : 0x2::object::new(arg6),
            decimals    : arg1,
            symbol      : arg2,
            name        : arg3,
            description : arg4,
        };
        0x1::vector::push_back<CoinType>(&mut arg0.coin_types, v1);
        let v2 = Coin{
            id           : 0x2::object::new(arg6),
            value        : arg5,
            coin_type_id : v0,
        };
        0x2::transfer::public_transfer<Coin>(v2, 0x2::tx_context::sender(arg6));
    }

    public entry fun initialize_factory(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id         : 0x2::object::new(arg0),
            next_id    : 1,
            coin_types : 0x1::vector::empty<CoinType>(),
        };
        0x2::transfer::public_transfer<Factory>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

