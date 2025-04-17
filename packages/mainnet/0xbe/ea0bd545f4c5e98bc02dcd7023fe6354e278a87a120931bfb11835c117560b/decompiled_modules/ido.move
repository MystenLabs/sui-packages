module 0xbeea0bd545f4c5e98bc02dcd7023fe6354e278a87a120931bfb11835c117560b::ido {
    struct ManageCapAbility<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_id: 0x2::object::ID,
    }

    struct PreSale<phantom T0> has store, key {
        id: 0x2::object::UID,
        status: u8,
        raise: u64,
        start_time: u64,
        end_time: u64,
        claim_time: u64,
        min_amount: u64,
        balance: 0x2::coin::Coin<T0>,
        members: 0x2::vec_map::VecMap<address, u64>,
    }

    public entry fun claim_tokens<T0>(arg0: &mut PreSale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.claim_time, 1001);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.members, &v0), 0);
    }

    public entry fun create_presale<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PreSale<T0>{
            id         : 0x2::object::new(arg1),
            status     : 0,
            raise      : arg0,
            start_time : 1744059600000,
            end_time   : 1746738000000,
            claim_time : 1755541200000,
            min_amount : 1000000000,
            balance    : 0x2::coin::zero<T0>(arg1),
            members    : 0x2::vec_map::empty<address, u64>(),
        };
        let v1 = ManageCapAbility<T0>{
            id      : 0x2::object::new(arg1),
            sale_id : 0x2::object::id<PreSale<T0>>(&v0),
        };
        0x2::transfer::public_transfer<ManageCapAbility<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<PreSale<T0>>(v0);
    }

    public entry fun fund<T0>(arg0: &mut PreSale<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1001);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= arg0.min_amount, 1005);
        0x2::coin::join<T0>(&mut arg0.balance, arg1);
        if (0x2::vec_map::contains<address, u64>(&mut arg0.members, &v0)) {
            let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.members, &v0);
            *v3 = *v3 + v2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.members, v0, v2);
        };
    }

    public entry fun withdraw_funds<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

