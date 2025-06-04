module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::collector {
    struct Collector has store {
        vault_id: 0x2::object::ID,
        assets: vector<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>,
        operations: vector<0x1::type_name::TypeName>,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
    }

    struct AssetKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Empty has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x2::object::ID) : Collector {
        Collector{
            vault_id   : arg0,
            assets     : 0x1::vector::empty<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(),
            operations : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun assets(arg0: &Collector) : &vector<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>> {
        &arg0.assets
    }

    public fun assets_mut(arg0: &mut Collector) : &mut vector<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>> {
        &mut arg0.assets
    }

    public(friend) fun collect_asset<T0: store, T1>(arg0: &mut Collector, arg1: &T1, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: 0x2::object::new(arg3)};
        let v1 = AssetKey{dummy_field: false};
        0x2::dynamic_field::add<AssetKey, T0>(&mut v0.id, v1, arg2);
        let v2 = 0x2::vec_map::empty<0x1::type_name::TypeName, Item>();
        0x2::vec_map::insert<0x1::type_name::TypeName, Item>(&mut v2, 0x1::type_name::get<T0>(), v0);
        0x1::vector::push_back<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(&mut arg0.assets, v2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.operations, 0x1::type_name::get<T1>());
    }

    public(friend) fun collect_empty<T0>(arg0: &mut Collector, arg1: &T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: 0x2::object::new(arg2)};
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, Item>();
        0x2::vec_map::insert<0x1::type_name::TypeName, Item>(&mut v1, 0x1::type_name::get<Empty>(), v0);
        0x1::vector::push_back<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(&mut arg0.assets, v1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.operations, 0x1::type_name::get<T0>());
    }

    public fun drop(arg0: Collector) {
        let Collector {
            vault_id   : _,
            assets     : v1,
            operations : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        if (!0x1::vector::is_empty<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(&v4)) {
            err_still_existed_asset();
        };
        if (!(0x1::vector::length<0x1::type_name::TypeName>(&v3) == 0)) {
            err_still_existed_operation();
        };
        0x1::vector::destroy_empty<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(v4);
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v3);
    }

    public(friend) fun drop_empty_item(arg0: Item) {
        if (is_existed_asset_key(&arg0)) {
            err_item_included_asset();
        };
        if (!is_existed_empty(&arg0)) {
            err_no_empty_key();
        };
        let Item { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun err_item_included_asset() {
        abort 105
    }

    fun err_no_asset() {
        abort 103
    }

    fun err_no_empty_key() {
        abort 106
    }

    fun err_operation_not_existed() {
        abort 100
    }

    fun err_still_existed_asset() {
        abort 101
    }

    fun err_still_existed_operation() {
        abort 102
    }

    fun err_vault_should_be_same() {
        abort 104
    }

    public(friend) fun extract_asset_map_mut<T0>(arg0: &mut Collector, arg1: &T0) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, Item> {
        let (v0, v1) = fetch_matched_operation<T0>(arg0);
        if (!v0) {
            err_operation_not_existed();
        };
        let v2 = operations_mut(arg0);
        0x1::vector::remove<0x1::type_name::TypeName>(v2, v1);
        0x1::vector::borrow_mut<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(&mut arg0.assets, v1)
    }

    public(friend) fun extract_inner_asset<T0: store>(arg0: Item) : T0 {
        if (!is_existed_asset_key(&arg0)) {
            err_no_asset();
        };
        let v0 = AssetKey{dummy_field: false};
        let Item { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::dynamic_field::remove<AssetKey, T0>(&mut arg0.id, v0)
    }

    public(friend) fun fetch_matched_operation<T0>(arg0: &Collector) : (bool, u64) {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(operations(arg0))) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(operations(arg0), v0) == 0x1::type_name::get<T0>()) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        (v1, v0)
    }

    public(friend) fun is_existed_asset<T0>(arg0: &0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>) : bool {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, Item>(arg0);
        let v1 = false;
        while (0x1::vector::length<0x1::type_name::TypeName>(&v0) > 0) {
            if (0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0) == 0x1::type_name::get<T0>()) {
                v1 = true;
                break
            };
        };
        v1
    }

    public(friend) fun is_existed_asset_key(arg0: &Item) : bool {
        let v0 = AssetKey{dummy_field: false};
        0x2::dynamic_field::exists_<AssetKey>(&arg0.id, v0)
    }

    public(friend) fun is_existed_empty(arg0: &Item) : bool {
        let v0 = Empty{dummy_field: false};
        0x2::dynamic_field::exists_<Empty>(&arg0.id, v0)
    }

    public fun is_same_vault_id(arg0: &Collector, arg1: &Collector) : bool {
        arg0.vault_id == arg1.vault_id
    }

    public fun merge(arg0: &mut Collector, arg1: Collector) {
        if (!is_same_vault_id(arg0, &arg1)) {
            err_vault_should_be_same();
        };
        while (0x1::vector::length<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(assets(&arg1)) > 0) {
            0x1::vector::push_back<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(&mut arg0.assets, 0x1::vector::pop_back<0x2::vec_map::VecMap<0x1::type_name::TypeName, Item>>(&mut arg1.assets));
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.operations, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1.operations));
        };
        drop(arg1);
    }

    public fun operations(arg0: &Collector) : &vector<0x1::type_name::TypeName> {
        &arg0.operations
    }

    public fun operations_mut(arg0: &mut Collector) : &mut vector<0x1::type_name::TypeName> {
        &mut arg0.operations
    }

    public fun vault_id(arg0: &Collector) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

