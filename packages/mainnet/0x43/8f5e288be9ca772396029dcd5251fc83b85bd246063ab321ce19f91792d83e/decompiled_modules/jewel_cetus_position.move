module 0xe25582daef54ee41052390c4db5e70a82ec1baed97942db0eb6094267624b5d::jewel_cetus_position {
    struct Position has store, key {
        id: 0x2::object::UID,
        farm_pool_id: 0x2::object::ID,
        index: u64,
        liquidity: u128,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public fun new(arg0: u64, arg1: 0x2::object::ID, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : Position {
        abort 900
    }

    public(friend) fun create(arg0: u64, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id           : 0x2::object::new(arg2),
            farm_pool_id : arg1,
            index        : arg0,
            liquidity    : 0,
            name         : 0x1::string::utf8(b"Jewel Cetus Farm Position"),
            description  : 0x1::string::utf8(b"Jewel Cetus Farm Position"),
            url          : 0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/JewelSwapXFinance/jewelswap-token-logos/main/sui/jwl-cetus-position.png"),
        }
    }

    public fun get_farm_pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.farm_pool_id
    }

    public fun get_liquidity(arg0: &Position) : u128 {
        arg0.liquidity
    }

    public fun increase_liquidity(arg0: &mut Position, arg1: u128) {
        abort 900
    }

    public fun merge(arg0: &mut Position, arg1: Position) {
        abort 900
    }

    public(friend) fun set_liquidity(arg0: &mut Position, arg1: u128) {
        arg0.liquidity = arg1;
    }

    // decompiled from Move bytecode v7
}

