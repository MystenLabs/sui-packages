module 0x9bf00314ecf5c82bce70a7afac8905960734d600e76ac31d78588d81ed63d2d6::company {
    struct CompanyCap has key {
        id: 0x2::object::UID,
    }

    struct Company has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        price_per_hundred_grams: u64,
        waiting_for_receipt: 0x2::linked_table::LinkedTable<0x2::object::ID, ItemInfo>,
        can_be_cashed: 0x2::balance::Balance<0x2::sui::SUI>,
        all_profit: u64,
    }

    struct TransportItem has key {
        id: 0x2::object::UID,
        logistics_company: 0x1::string::String,
        company_id: 0x2::object::ID,
        weight: u64,
        price: u64,
    }

    struct ItemInfo has store {
        epoch: u64,
        transport_price: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun cash(arg0: &CompanyCap, arg1: &mut 0x9bf00314ecf5c82bce70a7afac8905960734d600e76ac31d78588d81ed63d2d6::admin::Admin, arg2: &mut Company, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2.can_be_cashed;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(v0);
        assert!(v1 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(0x9bf00314ecf5c82bce70a7afac8905960734d600e76ac31d78588d81ed63d2d6::admin::get_balance_mut(arg1), 0x2::balance::split<0x2::sui::SUI>(v0, v1 / 100));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v0, 0x2::balance::value<0x2::sui::SUI>(v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun confirm_items(arg0: &CompanyCap, arg1: &mut Company, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.waiting_for_receipt;
        loop {
            if (0x2::linked_table::is_empty<0x2::object::ID, ItemInfo>(v0)) {
                break
            };
            if (0x2::linked_table::borrow<0x2::object::ID, ItemInfo>(v0, *0x1::option::borrow<0x2::object::ID>(0x2::linked_table::front<0x2::object::ID, ItemInfo>(v0))).epoch + 15 >= 0x2::tx_context::epoch(arg2)) {
                break
            };
            let (_, v2) = 0x2::linked_table::pop_front<0x2::object::ID, ItemInfo>(v0);
            let ItemInfo {
                epoch           : _,
                transport_price : v4,
            } = v2;
            let v5 = v4;
            arg1.all_profit = arg1.all_profit + 0x2::balance::value<0x2::sui::SUI>(&v5);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.can_be_cashed, v5);
        };
    }

    public entry fun confirm_receipt(arg0: TransportItem, arg1: &mut Company) {
        assert!(arg0.company_id == 0x2::object::id<Company>(arg1), 3);
        let v0 = &mut arg1.waiting_for_receipt;
        let v1 = 0x2::object::id<TransportItem>(&arg0);
        if (0x2::linked_table::contains<0x2::object::ID, ItemInfo>(v0, v1)) {
            let ItemInfo {
                epoch           : _,
                transport_price : v3,
            } = 0x2::linked_table::remove<0x2::object::ID, ItemInfo>(v0, v1);
            let v4 = v3;
            arg1.all_profit = arg1.all_profit + 0x2::balance::value<0x2::sui::SUI>(&v4);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.can_be_cashed, v4);
        };
        destroy_transport_item(arg0);
    }

    public entry fun create_company(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CompanyCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<CompanyCap>(v0, 0x2::tx_context::sender(arg2));
        let v1 = Company{
            id                      : 0x2::object::new(arg2),
            name                    : arg0,
            price_per_hundred_grams : arg1,
            waiting_for_receipt     : 0x2::linked_table::new<0x2::object::ID, ItemInfo>(arg2),
            can_be_cashed           : 0x2::balance::zero<0x2::sui::SUI>(),
            all_profit              : 0,
        };
        0x2::transfer::share_object<Company>(v1);
    }

    public entry fun create_item(arg0: &mut Company, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1 + 99) / 100 * arg0.price_per_hundred_grams;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        };
        let v1 = TransportItem{
            id                : 0x2::object::new(arg3),
            logistics_company : arg0.name,
            company_id        : 0x2::object::id<Company>(arg0),
            weight            : arg1,
            price             : v0,
        };
        let v2 = ItemInfo{
            epoch           : 0x2::tx_context::epoch(arg3),
            transport_price : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3)),
        };
        0x2::transfer::transfer<TransportItem>(v1, 0x2::tx_context::sender(arg3));
        0x2::linked_table::push_back<0x2::object::ID, ItemInfo>(&mut arg0.waiting_for_receipt, 0x2::object::id<TransportItem>(&v1), v2);
    }

    public entry fun destroy_company(arg0: CompanyCap, arg1: Company) {
        let CompanyCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let Company {
            id                      : v1,
            name                    : _,
            price_per_hundred_grams : _,
            waiting_for_receipt     : v4,
            can_be_cashed           : v5,
            all_profit              : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::linked_table::destroy_empty<0x2::object::ID, ItemInfo>(v4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
    }

    fun destroy_transport_item(arg0: TransportItem) {
        let TransportItem {
            id                : v0,
            logistics_company : _,
            company_id        : _,
            weight            : _,
            price             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun refunds(arg0: TransportItem, arg1: &mut Company, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.company_id == 0x2::object::id<Company>(arg1), 3);
        let v0 = &mut arg1.waiting_for_receipt;
        let v1 = 0x2::object::id<TransportItem>(&arg0);
        assert!(0x2::linked_table::contains<0x2::object::ID, ItemInfo>(v0, v1), 4);
        assert!(0x2::linked_table::borrow<0x2::object::ID, ItemInfo>(v0, v1).epoch + 3 >= 0x2::tx_context::epoch(arg2), 5);
        let ItemInfo {
            epoch           : _,
            transport_price : v3,
        } = 0x2::linked_table::remove<0x2::object::ID, ItemInfo>(v0, v1);
        let v4 = v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v4, 0x2::balance::value<0x2::sui::SUI>(&v4), arg2), 0x2::tx_context::sender(arg2));
        0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        destroy_transport_item(arg0);
    }

    // decompiled from Move bytecode v6
}

