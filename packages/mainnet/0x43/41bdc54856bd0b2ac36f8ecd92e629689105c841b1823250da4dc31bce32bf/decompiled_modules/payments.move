module 0x4341bdc54856bd0b2ac36f8ecd92e629689105c841b1823250da4dc31bce32bf::payments {
    struct PaidEvent has copy, drop {
        item: 0x1::string::String,
        quantity: u64,
        price: u64,
        sender: address,
    }

    struct PaymentBank has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct PaymentConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        item_to_price: 0x2::table::Table<0x1::string::String, u64>,
        item_counter: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct PaymentAdminCap has store, key {
        id: 0x2::object::UID,
        original_id: 0x2::object::ID,
    }

    public fun add_payment_config<T0>(arg0: &mut PaymentBank, arg1: &PaymentAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentConfig<T0>{
            id            : 0x2::object::new(arg2),
            balance       : 0x2::balance::zero<T0>(),
            item_to_price : 0x2::table::new<0x1::string::String, u64>(arg2),
            item_counter  : 0x2::table::new<0x1::string::String, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, PaymentConfig<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v0);
    }

    public fun add_version(arg0: &PaymentAdminCap, arg1: &mut PaymentBank, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_valid_version(arg0: &PaymentBank) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 3);
    }

    public fun config_exists<T0>(arg0: &PaymentBank) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun get_item_count<T0>(arg0: &mut PaymentBank, arg1: 0x1::string::String) : u64 {
        item_price_exists<T0>(arg0, arg1);
        *0x2::table::borrow<0x1::string::String, u64>(&0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, PaymentConfig<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).item_counter, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = PaymentAdminCap{
            id          : v0,
            original_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<PaymentAdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = PaymentBank{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<PaymentBank>(v2);
    }

    public fun item_price_exists<T0>(arg0: &PaymentBank, arg1: 0x1::string::String) {
        assert!(config_exists<T0>(arg0), 0);
        assert!(0x2::table::contains<0x1::string::String, u64>(&0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, PaymentConfig<T0>>(&arg0.id, 0x1::type_name::get<T0>()).item_to_price, arg1), 1);
    }

    public fun mint_admin_cap(arg0: &PaymentAdminCap, arg1: &mut 0x2::tx_context::TxContext) : PaymentAdminCap {
        PaymentAdminCap{
            id          : 0x2::object::new(arg1),
            original_id : arg0.original_id,
        }
    }

    public fun package_version() : u64 {
        1
    }

    public fun purchase<T0>(arg0: &mut PaymentBank, arg1: u64, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        item_price_exists<T0>(arg0, arg2);
        assert_valid_version(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, PaymentConfig<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        let v1 = *0x2::table::borrow<0x1::string::String, u64>(&v0.item_to_price, arg2);
        let v2 = 0x2::coin::into_balance<T0>(arg3);
        assert!(0x2::balance::value<T0>(&v2) * arg1 == v1, 2);
        0x2::balance::join<T0>(&mut v0.balance, v2);
        if (0x2::table::contains<0x1::string::String, u64>(&v0.item_counter, arg2)) {
            0x2::table::add<0x1::string::String, u64>(&mut v0.item_counter, arg2, 0x2::table::remove<0x1::string::String, u64>(&mut v0.item_counter, arg2) + 1);
        };
        let v3 = PaidEvent{
            item     : arg2,
            quantity : arg1,
            price    : v1,
            sender   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PaidEvent>(v3);
    }

    public fun remove_version(arg0: &PaymentAdminCap, arg1: &mut PaymentBank, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun set_item_price<T0>(arg0: &mut PaymentBank, arg1: 0x1::string::String, arg2: u64, arg3: &PaymentAdminCap) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, PaymentConfig<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        if (0x2::table::contains<0x1::string::String, u64>(&v0.item_to_price, arg1)) {
            0x2::table::remove<0x1::string::String, u64>(&mut v0.item_to_price, arg1);
        };
        0x2::table::add<0x1::string::String, u64>(&mut v0.item_to_price, arg1, arg2);
        if (!0x2::table::contains<0x1::string::String, u64>(&v0.item_counter, arg1)) {
            0x2::table::add<0x1::string::String, u64>(&mut v0.item_counter, arg1, 0);
        };
    }

    public fun withdraw_all<T0>(arg0: &mut PaymentBank, arg1: &PaymentAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, PaymentConfig<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, 0x2::balance::value<T0>(&v0.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

