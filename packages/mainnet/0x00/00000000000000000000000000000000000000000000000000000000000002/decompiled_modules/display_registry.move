module 0x2::display_registry {
    struct DisplayRegistry has key {
        id: 0x2::object::UID,
    }

    struct SystemMigrationCap has key {
        id: 0x2::object::UID,
    }

    struct Display<phantom T0> has key {
        id: 0x2::object::UID,
        fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct DisplayCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct DisplayKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun claim<T0: key>(arg0: &mut Display<T0>, arg1: 0x2::display::Display<T0>, arg2: &mut 0x2::tx_context::TxContext) : DisplayCap<T0> {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.cap_id), 13835621451912511494);
        let v0 = DisplayCap<T0>{id: 0x2::object::new(arg2)};
        0x1::option::fill<0x2::object::ID>(&mut arg0.cap_id, 0x2::object::uid_to_inner(&v0.id));
        0x2::display::destroy<T0>(arg1);
        v0
    }

    public fun fields<T0>(arg0: &Display<T0>) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.fields
    }

    public fun cap_id<T0>(arg0: &Display<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.cap_id
    }

    public fun claim_with_publisher<T0: key>(arg0: &mut Display<T0>, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : DisplayCap<T0> {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.cap_id), 13835621507747086342);
        assert!(0x2::package::from_package<T0>(arg1), 13835902987018895368);
        let v0 = DisplayCap<T0>{id: 0x2::object::new(arg2)};
        0x1::option::fill<0x2::object::ID>(&mut arg0.cap_id, 0x2::object::uid_to_inner(&v0.id));
        v0
    }

    public fun clear<T0>(arg0: &mut Display<T0>, arg1: &DisplayCap<T0>) {
        arg0.fields = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 13835058952930394114);
        let v0 = DisplayRegistry{id: 0x2::object::sui_display_registry_object_id()};
        0x2::transfer::share_object<DisplayRegistry>(v0);
        let v1 = SystemMigrationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SystemMigrationCap>(v1, @0x80e8249451c1a94b0d4ec317d9dd040f11344dcce6f917218086caf2bb1d7bdd);
    }

    public fun delete_legacy<T0: key>(arg0: &Display<T0>, arg1: 0x2::display::Display<T0>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.cap_id), 13836466173195780108);
        0x2::display::destroy<T0>(arg1);
    }

    entry fun destroy_system_migration_cap(arg0: SystemMigrationCap) {
        let SystemMigrationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun migrate_v1_to_v2<T0: key>(arg0: &mut DisplayRegistry, arg1: 0x2::display::Display<T0>, arg2: &mut 0x2::tx_context::TxContext) : (Display<T0>, DisplayCap<T0>) {
        let (v0, v1) = new_display<T0>(arg0, arg2);
        let v2 = v0;
        v2.fields = *0x2::display::fields<T0>(&arg1);
        0x2::display::destroy<T0>(arg1);
        (v2, v1)
    }

    public(friend) fun migration_cap_receiver() : address {
        @0x80e8249451c1a94b0d4ec317d9dd040f11344dcce6f917218086caf2bb1d7bdd
    }

    public fun new<T0>(arg0: &mut DisplayRegistry, arg1: 0x1::internal::Permit<T0>, arg2: &mut 0x2::tx_context::TxContext) : (Display<T0>, DisplayCap<T0>) {
        new_display<T0>(arg0, arg2)
    }

    fun new_display<T0>(arg0: &mut DisplayRegistry, arg1: &mut 0x2::tx_context::TxContext) : (Display<T0>, DisplayCap<T0>) {
        let v0 = DisplayKey<T0>{dummy_field: false};
        assert!(!0x2::derived_object::exists<DisplayKey<T0>>(&arg0.id, v0), 13835340372072660996);
        let v1 = DisplayCap<T0>{id: 0x2::object::new(arg1)};
        let v2 = Display<T0>{
            id     : 0x2::derived_object::claim<DisplayKey<T0>>(&mut arg0.id, v0),
            fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            cap_id : 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v1.id)),
        };
        (v2, v1)
    }

    public fun new_with_publisher<T0>(arg0: &mut DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : (Display<T0>, DisplayCap<T0>) {
        assert!(0x2::package::from_package<T0>(arg1), 13835902776565497864);
        new_display<T0>(arg0, arg2)
    }

    public fun set<T0>(arg0: &mut Display<T0>, arg1: &DisplayCap<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.fields, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.fields, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.fields, arg2, arg3);
    }

    public fun share<T0>(arg0: Display<T0>) {
        0x2::transfer::share_object<Display<T0>>(arg0);
    }

    public fun system_migration<T0: key>(arg0: &mut DisplayRegistry, arg1: &SystemMigrationCap, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DisplayKey<T0>{dummy_field: false};
        if (0x2::derived_object::exists<DisplayKey<T0>>(&arg0.id, v0)) {
            return
        };
        let v1 = Display<T0>{
            id     : 0x2::derived_object::claim<DisplayKey<T0>>(&mut arg0.id, v0),
            fields : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3),
            cap_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Display<T0>>(v1);
    }

    entry fun transfer_migration_cap(arg0: SystemMigrationCap, arg1: address) {
        0x2::transfer::transfer<SystemMigrationCap>(arg0, arg1);
    }

    public fun unset<T0>(arg0: &mut Display<T0>, arg1: &DisplayCap<T0>, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.fields, &arg2), 13836184281607110666);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.fields, &arg2);
    }

    // decompiled from Move bytecode v7
}

