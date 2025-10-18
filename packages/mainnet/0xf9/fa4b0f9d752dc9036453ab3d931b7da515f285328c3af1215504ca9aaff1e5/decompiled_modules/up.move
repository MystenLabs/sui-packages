module 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up {
    struct UpTokenMintedEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct UpTokenBurnedEvent<phantom T0> has copy, drop {
        amount: u64,
    }

    struct UP has drop {
        dummy_field: bool,
    }

    struct UpAdmin has store, key {
        id: 0x2::object::UID,
        tokens_minted: u64,
        tokens_burned: u64,
        managers: 0x2::vec_set::VecSet<address>,
        versions: 0x2::vec_set::VecSet<u64>,
        allowed_packages: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct UPAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_manager(arg0: &UPAdminCap, arg1: &mut UpAdmin, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.managers, arg2);
    }

    public fun add_package<T0: drop>(arg0: &mut UpAdmin, arg1: &0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_packages, 0x1::type_name::get<T0>());
    }

    public fun add_version(arg0: &mut UpAdmin, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg2);
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg1);
    }

    public fun assert_package_is_allowed<T0: drop>(arg0: &UpAdmin, arg1: T0) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_packages, &v0)) {
            err_package_is_not_allowed();
        };
    }

    public fun assert_sender_is_manager(arg0: &UpAdmin, arg1: &0x2::tx_context::TxContext) {
        if (!is_manager(arg0, 0x2::tx_context::sender(arg1))) {
            err_not_manager();
        };
    }

    public fun assert_valid_version(arg0: &UpAdmin) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            err_invalid_version();
        };
    }

    fun borrow_up_treasury_mut(arg0: &mut UpAdmin) : &mut 0x2::coin::TreasuryCap<UP> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<UP>>(&mut arg0.id, 0x1::type_name::get<UP>())
    }

    public fun burn_token(arg0: &mut UpAdmin, arg1: 0x2::coin::Coin<UP>) {
        let v0 = 0x2::coin::value<UP>(&arg1);
        let v1 = borrow_up_treasury_mut(arg0);
        0x2::coin::burn<UP>(v1, arg1);
        arg0.tokens_burned = arg0.tokens_burned + v0;
        let v2 = UpTokenBurnedEvent<UP>{amount: v0};
        0x2::event::emit<UpTokenBurnedEvent<UP>>(v2);
    }

    fun err_invalid_version() {
        abort 2
    }

    fun err_not_manager() {
        abort 0
    }

    fun err_package_is_not_allowed() {
        abort 1
    }

    fun init(arg0: UP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UP>(arg0, 6, b"UP", b"UP", b"UP Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.doubleup.fun/Diamond_Only.png")), arg1);
        let v2 = v0;
        let v3 = 100000000000000;
        let v4 = UpTokenMintedEvent<UP>{amount: v3};
        0x2::event::emit<UpTokenMintedEvent<UP>>(v4);
        let v5 = UpAdmin{
            id               : 0x2::object::new(arg1),
            tokens_minted    : v3,
            tokens_burned    : 0,
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
            versions         : 0x2::vec_set::singleton<u64>(package_version()),
            allowed_packages : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<UP>>(&mut v5.id, 0x1::type_name::get<UP>(), v2);
        let v6 = UPAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::Coin<UP>>(0x2::coin::mint<UP>(&mut v2, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<UpAdmin>(v5);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<UPAdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_manager(arg0: &UpAdmin, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun package_version() : u64 {
        15
    }

    public fun remove_manager(arg0: &UPAdminCap, arg1: &mut UpAdmin, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.managers, &arg2);
    }

    public fun remove_package<T0: drop>(arg0: &mut UpAdmin, arg1: &0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_packages, &v0);
    }

    public fun remove_version(arg0: &mut UpAdmin, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg2);
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg1);
    }

    // decompiled from Move bytecode v6
}

