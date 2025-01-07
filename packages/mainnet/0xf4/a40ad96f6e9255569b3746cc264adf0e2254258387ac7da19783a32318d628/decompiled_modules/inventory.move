module 0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::inventory {
    struct InventoryConfig has key {
        id: 0x2::object::UID,
        blacklist_types: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct BorrowReceipt<phantom T0> {
        item_id: 0x2::object::ID,
        citizen_id: 0x2::object::ID,
    }

    public fun borrow<T0: store + key>(arg0: &mut 0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::DoubleUpCitizen, arg1: 0x2::transfer::Receiving<T0>) : (T0, BorrowReceipt<T0>) {
        let v0 = 0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::receive<T0>(arg0, arg1);
        let v1 = BorrowReceipt<T0>{
            item_id    : 0x2::object::id<T0>(&v0),
            citizen_id : 0x2::object::id<0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::DoubleUpCitizen>(arg0),
        };
        (v0, v1)
    }

    public fun receive<T0: store + key>(arg0: &mut 0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::DoubleUpCitizen, arg1: 0x2::transfer::Receiving<T0>, arg2: &InventoryConfig) : T0 {
        assert!(is_valid_version(arg2), 1);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg2.blacklist_types, 0x1::type_name::get<T0>()), 0);
        0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::receive<T0>(arg0, arg1)
    }

    public fun add_blacklist_type<T0>(arg0: &mut InventoryConfig, arg1: &0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::admin::CitizenCap) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.blacklist_types, v0), 2);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.blacklist_types, v0, true);
    }

    public fun add_version(arg0: &mut InventoryConfig, arg1: u64, arg2: &0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::admin::CitizenCap) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InventoryConfig{
            id              : 0x2::object::new(arg0),
            blacklist_types : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            version_set     : 0x2::vec_set::singleton<u64>(0),
        };
        0x2::transfer::share_object<InventoryConfig>(v0);
    }

    fun is_valid_version(arg0: &InventoryConfig) : bool {
        let v0 = 0;
        0x2::vec_set::contains<u64>(&arg0.version_set, &v0)
    }

    public fun remove_blacklist_type<T0>(arg0: &mut InventoryConfig, arg1: &0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::admin::CitizenCap) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.blacklist_types, v0), 3);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.blacklist_types, v0);
    }

    public fun remove_version(arg0: &mut InventoryConfig, arg1: u64, arg2: &0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::admin::CitizenCap) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
    }

    public fun return_borrowed<T0: store + key>(arg0: &mut 0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::DoubleUpCitizen, arg1: T0, arg2: BorrowReceipt<T0>) {
        let BorrowReceipt {
            item_id    : v0,
            citizen_id : v1,
        } = arg2;
        let v2 = v1;
        assert!(v0 == 0x2::object::id<T0>(&arg1), 4);
        assert!(v2 == 0x2::object::id<0xf4a40ad96f6e9255569b3746cc264adf0e2254258387ac7da19783a32318d628::doubleup_citizens::DoubleUpCitizen>(arg0), 5);
        0x2::transfer::public_transfer<T0>(arg1, 0x2::object::id_to_address(&v2));
    }

    // decompiled from Move bytecode v6
}

