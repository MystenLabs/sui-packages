module 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::ido {
    struct IDO has key {
        id: 0x2::object::UID,
        total_amount: u64,
        participants: 0x2::table_vec::TableVec<address>,
        subscribe_record: 0x2::table::Table<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>,
        total_offer: u64,
        offer: vector<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>,
        closed: bool,
    }

    struct SettleCap has store, key {
        id: 0x2::object::UID,
    }

    struct OrderEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct DeliverEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct ReturnEvent has copy, drop {
        user: address,
        amount: u64,
    }

    public fun amount(arg0: &IDO, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.subscribe_record, v0)) {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(0x2::table::borrow<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.subscribe_record, v0))
        } else {
            0
        }
    }

    public entry fun cancel(arg0: &SettleCap, arg1: &mut IDO, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_amount < 100000000, 6);
        arg1.closed = true;
        let v0 = 0x2::table_vec::length<address>(&arg1.participants);
        while (v0 > 0 && arg2 > 0) {
            let v1 = 0x2::table_vec::pop_back<address>(&mut arg1.participants);
            let v2 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.subscribe_record, v1);
            let v3 = ReturnEvent{
                user   : v1,
                amount : 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v2),
            };
            0x2::event::emit<ReturnEvent>(v3);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v2, v1);
            v0 = v0 - 1;
            arg2 = arg2 - 1;
        };
        if (0x2::table_vec::length<address>(&arg1.participants) == 0 && !0x1::vector::is_empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg1.offer)) {
            0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(0x1::vector::pop_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.offer), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun complete(arg0: &SettleCap, arg1: &mut IDO, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.total_amount > 100000000, 5);
        arg1.closed = true;
        let v1 = 0x2::table_vec::length<address>(&arg1.participants);
        while (v1 > 0 && arg2 > 0) {
            let v2 = 0x2::table_vec::pop_back<address>(&mut arg1.participants);
            let v3 = 0x2::table::remove<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg1.subscribe_record, v2);
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v3, v0);
            let v4 = (((0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&v3) as u128) * (arg1.total_offer as u128) / (arg1.total_amount as u128)) as u64);
            if (v4 == 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(0x1::vector::borrow<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg1.offer, 0))) {
                0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(0x1::vector::pop_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.offer), v2);
            } else {
                0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::do_split(0x1::vector::borrow_mut<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.offer, 0), v4, arg3), v2);
            };
            let v5 = DeliverEvent{
                user   : v2,
                amount : v4,
            };
            0x2::event::emit<DeliverEvent>(v5);
            v1 = v1 - 1;
            arg2 = arg2 - 1;
        };
        if (0x2::table_vec::length<address>(&arg1.participants) == 0 && 0x1::vector::length<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg1.offer) > 0) {
            0x2::transfer::public_transfer<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(0x1::vector::pop_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.offer), v0);
        };
    }

    public fun do_inject_ks(arg0: &SettleCap, arg1: &mut IDO, arg2: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription) {
        assert!(arg1.closed, 2);
        let v0 = 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::kart_value(&arg2);
        assert!(v0 == 10000000000000000, 4);
        assert!(0x1::vector::is_empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&arg1.offer), 7);
        0x1::vector::push_back<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(&mut arg1.offer, arg2);
        arg1.total_offer = v0;
        arg1.closed = false;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IDO{
            id               : 0x2::object::new(arg0),
            total_amount     : 0,
            participants     : 0x2::table_vec::empty<address>(arg0),
            subscribe_record : 0x2::table::new<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg0),
            total_offer      : 0,
            offer            : 0x1::vector::empty<0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription>(),
            closed           : true,
        };
        0x2::transfer::share_object<IDO>(v0);
        let v1 = SettleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SettleCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun inject_ks(arg0: &SettleCap, arg1: &mut IDO, arg2: 0x32e26b26aec256b3fac5f8823d0d98955f9d4eda378a17994d88067299e9b473::kartscription::KartScription) {
        do_inject_ks(arg0, arg1, arg2);
    }

    public entry fun order(arg0: &mut IDO, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.closed, 1);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::check_tick(&arg1, b"MOVE"), 3);
        let v1 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        assert!(v1 >= 100000, 5);
        if (v1 + arg0.total_amount > 300000000) {
            let v2 = v1 + arg0.total_amount - 300000000;
            0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_split(&mut arg1, v2, arg2), v0);
            arg0.total_amount = arg0.total_amount + v1 - v2;
            let v3 = OrderEvent{
                user   : v0,
                amount : v1 - v2,
            };
            0x2::event::emit<OrderEvent>(v3);
        } else {
            arg0.total_amount = arg0.total_amount + v1;
            let v4 = OrderEvent{
                user   : v0,
                amount : v1,
            };
            0x2::event::emit<OrderEvent>(v4);
        };
        if (!0x2::table::contains<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&arg0.subscribe_record, v0)) {
            0x2::table::add<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.subscribe_record, v0, arg1);
            0x2::table_vec::push_back<address>(&mut arg0.participants, v0);
        } else {
            0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::do_merge(0x2::table::borrow_mut<address, 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(&mut arg0.subscribe_record, v0), arg1);
        };
    }

    public fun total_amount(arg0: &IDO) : u64 {
        arg0.total_amount
    }

    public fun total_offer(arg0: &IDO) : u64 {
        arg0.total_offer
    }

    // decompiled from Move bytecode v6
}

