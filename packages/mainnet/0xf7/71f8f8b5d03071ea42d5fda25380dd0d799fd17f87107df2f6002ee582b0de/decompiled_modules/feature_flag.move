module 0xf771f8f8b5d03071ea42d5fda25380dd0d799fd17f87107df2f6002ee582b0de::feature_flag {
    struct FeatureFlag has drop, store {
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

    struct FeatureFlagRemoved has copy, drop {
        name: 0x1::string::String,
        removed_by: address,
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

    public fun has_flag(arg0: vector<u8>, arg1: &FeatureFlagTable) : bool {
        0x2::table::contains<0x1::string::String, FeatureFlag>(&arg1.table, 0x1::string::utf8(arg0))
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

    public fun remove_feature_flag(arg0: &AdminCap, arg1: &mut FeatureFlagTable, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        0x2::table::remove<0x1::string::String, FeatureFlag>(&mut arg1.table, v0);
        let v1 = FeatureFlagRemoved{
            name       : v0,
            removed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeatureFlagRemoved>(v1);
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

