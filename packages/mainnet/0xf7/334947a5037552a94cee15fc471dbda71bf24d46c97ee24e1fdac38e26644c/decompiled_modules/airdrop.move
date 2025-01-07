module 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop {
    struct Airdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        root: vector<u8>,
        start: u64,
        map: 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::Bitmap,
    }

    public fun balance<T0>(arg0: &Airdrop<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Airdrop<T0>) {
        let Airdrop {
            id      : v0,
            balance : v1,
            root    : _,
            start   : _,
            map     : v4,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::destroy(v4);
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Airdrop<T0> {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg3), 2);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 1);
        Airdrop<T0>{
            id      : 0x2::object::new(arg4),
            balance : 0x2::coin::into_balance<T0>(arg0),
            root    : arg1,
            start   : arg2,
            map     : 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::new(arg4),
        }
    }

    public fun borrow_map<T0>(arg0: &Airdrop<T0>) : &0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::Bitmap {
        &arg0.map
    }

    public fun get_airdrop<T0>(arg0: &mut Airdrop<T0>, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start, 3);
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg1), 4);
        let v0 = 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop_utils::verify(arg0.root, arg1, arg3, 0x2::tx_context::sender(arg4));
        assert!(!0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::get(&arg0.map, v0), 0);
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::set(&mut arg0.map, v0);
        0x2::coin::take<T0>(&mut arg0.balance, 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::math64::min(arg3, 0x2::balance::value<T0>(&arg0.balance)), arg4)
    }

    public fun has_account_claimed<T0>(arg0: &Airdrop<T0>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : bool {
        0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::bitmap::get(&arg0.map, 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::airdrop_utils::verify(arg0.root, arg1, arg2, arg3))
    }

    public fun root<T0>(arg0: &Airdrop<T0>) : vector<u8> {
        arg0.root
    }

    public fun start<T0>(arg0: &Airdrop<T0>) : u64 {
        arg0.start
    }

    // decompiled from Move bytecode v6
}

