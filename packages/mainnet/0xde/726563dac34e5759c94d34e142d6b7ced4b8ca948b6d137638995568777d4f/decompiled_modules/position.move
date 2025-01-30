module 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        deposit_share: u128,
        debt_share: u128,
        supply_share: u128,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id            : 0x2::object::new(arg4),
            farm_id       : arg0,
            deposit_share : arg1,
            debt_share    : arg2,
            supply_share  : arg3,
            name          : 0x1::string::utf8(b"Jewel Scallop Farm Position"),
            description   : 0x1::string::utf8(b"Jewel Scallop Farm Position"),
            url           : 0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png"),
        }
    }

    public fun debt_share(arg0: &Position) : u128 {
        arg0.debt_share
    }

    public(friend) fun decrease_debt_share(arg0: &mut Position, arg1: u128) {
        arg0.debt_share = arg0.debt_share - arg1;
    }

    public(friend) fun decrease_deposit_share(arg0: &mut Position, arg1: u128) {
        arg0.deposit_share = arg0.deposit_share - arg1;
    }

    public(friend) fun decrease_supply_share(arg0: &mut Position, arg1: u128) {
        arg0.supply_share = arg0.supply_share - arg1;
    }

    public fun deposit_share(arg0: &Position) : u128 {
        arg0.deposit_share
    }

    public fun farm_id(arg0: &Position) : 0x2::object::ID {
        arg0.farm_id
    }

    public(friend) fun increase_debt_share(arg0: &mut Position, arg1: u128) {
        arg0.debt_share = arg0.debt_share + arg1;
    }

    public(friend) fun increase_deposit_share(arg0: &mut Position, arg1: u128) {
        arg0.deposit_share = arg0.deposit_share + arg1;
    }

    public(friend) fun increase_supply_share(arg0: &mut Position, arg1: u128) {
        arg0.supply_share = arg0.supply_share + arg1;
    }

    public fun info(arg0: &Position) : (0x2::object::ID, u128, u128, u128) {
        (arg0.farm_id, arg0.deposit_share, arg0.debt_share, arg0.supply_share)
    }

    public fun merge(arg0: &mut Position, arg1: Position) {
        arg0.deposit_share = arg0.deposit_share + arg1.deposit_share;
        arg0.debt_share = arg0.debt_share + arg1.debt_share;
        arg0.supply_share = arg0.debt_share + arg1.supply_share;
        let Position {
            id            : v0,
            farm_id       : _,
            deposit_share : _,
            debt_share    : _,
            supply_share  : _,
            name          : _,
            description   : _,
            url           : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun supply_share(arg0: &Position) : u128 {
        arg0.supply_share
    }

    // decompiled from Move bytecode v6
}

