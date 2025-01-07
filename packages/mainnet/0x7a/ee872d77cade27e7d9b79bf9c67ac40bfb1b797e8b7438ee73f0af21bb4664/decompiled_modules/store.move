module 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::store {
    struct AccessoriesStore has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AccsStoreOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ListedAccessory has store {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: 0x1::string::String,
        price: u64,
        quantity: 0x1::option::Option<u64>,
    }

    struct AccessoryPurchased has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        type: 0x1::string::String,
    }

    public fun add_listing(arg0: &AccsStoreOwnerCap, arg1: &mut AccessoriesStore, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ListedAccessory{
            id       : 0x2::object::new(arg6),
            name     : arg2,
            type     : arg3,
            price    : arg4,
            quantity : arg5,
        };
        0x2::dynamic_field::add<0x1::string::String, ListedAccessory>(&mut arg1.id, arg2, v0);
    }

    public fun authorize(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut AccessoriesStore) {
        0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::authorize_app(arg0, &mut arg1.id);
    }

    public fun buy(arg0: &mut AccessoriesStore, arg1: 0x1::string::String, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::Accessory {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, ListedAccessory>(&mut arg0.id, arg1);
        assert!(v0.price <= 0x2::coin::value<0x2::sui::SUI>(arg2), 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg2, v0.price, arg3));
        if (0x1::option::is_some<u64>(&v0.quantity)) {
            let v1 = 0x1::option::borrow<u64>(&v0.quantity);
            assert!(*v1 > 0, 2);
            0x1::option::swap<u64>(&mut v0.quantity, *v1 - 1);
        };
        let v2 = v0.name;
        let v3 = v0.type;
        let v4 = 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::mint(&mut arg0.id, v2, v3, arg3);
        let v5 = AccessoryPurchased{
            id   : 0x2::object::id<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::Accessory>(&v4),
            name : v2,
            type : v3,
        };
        0x2::event::emit<AccessoryPurchased>(v5);
        v4
    }

    public fun collect_profits(arg0: &AccsStoreOwnerCap, arg1: &mut AccessoriesStore, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2)
    }

    public fun deauthorize(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut AccessoriesStore) {
        0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::deauthorize_app(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessoriesStore{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<AccessoriesStore>(v0);
        let v1 = AccsStoreOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AccsStoreOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun price(arg0: &AccessoriesStore, arg1: 0x1::string::String) : u64 {
        0x2::dynamic_field::borrow<0x1::string::String, ListedAccessory>(&arg0.id, arg1).price
    }

    public fun remove_listing(arg0: &AccsStoreOwnerCap, arg1: &mut AccessoriesStore, arg2: 0x1::string::String) : ListedAccessory {
        0x2::dynamic_field::remove<0x1::string::String, ListedAccessory>(&mut arg1.id, arg2)
    }

    public fun set_quantity(arg0: &AccsStoreOwnerCap, arg1: &mut AccessoriesStore, arg2: 0x1::string::String, arg3: u64) {
        0x1::option::swap<u64>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, ListedAccessory>(&mut arg1.id, arg2).quantity, arg3);
    }

    public fun update_price(arg0: &AccsStoreOwnerCap, arg1: &mut AccessoriesStore, arg2: 0x1::string::String, arg3: u64) {
        0x2::dynamic_field::borrow_mut<0x1::string::String, ListedAccessory>(&mut arg1.id, arg2).price = arg3;
    }

    // decompiled from Move bytecode v6
}

