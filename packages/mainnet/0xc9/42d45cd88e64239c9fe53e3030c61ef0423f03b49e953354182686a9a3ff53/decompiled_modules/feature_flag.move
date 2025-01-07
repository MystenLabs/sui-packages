module 0xc942d45cd88e64239c9fe53e3030c61ef0423f03b49e953354182686a9a3ff53::feature_flag {
    struct FeatureFlag has store {
        name: 0x1::string::String,
        value: bool,
    }

    struct FeatureFlagTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, FeatureFlag>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeatureFlagAdded has copy, drop {
        name: 0x1::string::String,
        value: bool,
        created_by: address,
    }

    struct FeatureFlagUpdated has copy, drop {
        name: 0x1::string::String,
        previous_value: bool,
        new_value: bool,
        updated_by: address,
    }

    public fun create_feature_flag(arg0: &AdminCap, arg1: &mut FeatureFlagTable, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        let v1 = FeatureFlag{
            name  : v0,
            value : arg3,
        };
        0x2::table::add<0x1::string::String, FeatureFlag>(&mut arg1.table, v0, v1);
        let v2 = FeatureFlagAdded{
            name       : v0,
            value      : arg3,
            created_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeatureFlagAdded>(v2);
    }

    public fun get_feature_flag_value(arg0: vector<u8>, arg1: &FeatureFlagTable) : bool {
        0x2::table::borrow<0x1::string::String, FeatureFlag>(&arg1.table, 0x1::string::utf8(arg0)).value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeatureFlagTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::string::String, FeatureFlag>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FeatureFlagTable>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun update_feature_flag(arg0: &AdminCap, arg1: &mut FeatureFlagTable, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, FeatureFlag>(&mut arg1.table, v0);
        if (v1.value != arg3) {
            let v2 = FeatureFlagUpdated{
                name           : v0,
                previous_value : v1.value,
                new_value      : arg3,
                updated_by     : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<FeatureFlagUpdated>(v2);
            v1.value = arg3;
        };
    }

    // decompiled from Move bytecode v6
}

