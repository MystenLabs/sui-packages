module 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::profile {
    struct PROFILE has drop {
        dummy_field: bool,
    }

    struct AdmincCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        registry: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        owner: address,
        created_at: u64,
        avatar_url: 0x1::ascii::String,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        metadata: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public fun new_point_dashboard<T0: drop>(arg0: &AdmincCap, arg1: &mut ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        if (!module_exist<T0>(arg1)) {
            register_point_module<T0>(arg0, arg1, arg2);
        };
        0x2::transfer::public_share_object<0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointDashBoard<T0>>(0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::new_point_dashboard<T0>(arg2));
    }

    public fun add_df_state<T0, T1: store>(arg0: &mut Profile, arg1: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>, arg2: T1) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 102);
        0x2::dynamic_field::add<0x1::type_name::TypeName, T1>(&mut arg0.id, v0, arg2);
    }

    public fun add_dof_state<T0, T1: store + key>(arg0: &mut Profile, arg1: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>, arg2: T1) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 102);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, T1>(&mut arg0.id, v0, arg2);
    }

    public fun add_point_by_admin<T0: drop>(arg0: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointDashBoard<T0>, arg1: &AdmincCap, arg2: 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::AddPointRequest<T0>) {
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::add_point<T0>(arg0, arg2);
    }

    public fun avatar_url(arg0: &Profile) : 0x1::ascii::String {
        arg0.avatar_url
    }

    public fun borrow_df_state<T0, T1: store>(arg0: &Profile, arg1: &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : &T1 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 102);
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, T1>(&arg0.id, v0)
    }

    public fun borrow_df_state_mut<T0, T1: store>(arg0: &mut Profile, arg1: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : &mut T1 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 102);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, T1>(&mut arg0.id, v0)
    }

    public fun borrow_dof_state<T0, T1: store + key>(arg0: &Profile, arg1: &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : &T1 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 102);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, T1>(&arg0.id, v0)
    }

    public fun borrow_dof_state_mut<T0, T1: store + key>(arg0: &mut Profile, arg1: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : &mut T1 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 102);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, T1>(&mut arg0.id, v0)
    }

    public fun description(arg0: &Profile) : 0x1::ascii::String {
        arg0.description
    }

    public fun df_state_exists<T0, T1: store>(arg0: &Profile, arg1: &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun df_state_exists_with_type<T0, T1: store>(arg0: &Profile, arg1: &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, T1>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun dof_state_exists<T0, T1: store + key>(arg0: &Profile, arg1: &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun dof_state_exists_with_type<T0, T1: store + key>(arg0: &Profile, arg1: &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, T1>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun drop(arg0: Profile, arg1: &mut ProfileRegistry) {
        let Profile {
            id          : v0,
            owner       : v1,
            created_at  : _,
            avatar_url  : _,
            name        : _,
            description : _,
            metadata    : _,
        } = arg0;
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::event::profile_destroyed(v1, 0x2::table::remove<address, 0x2::object::ID>(&mut arg1.registry, v1));
        0x2::object::delete(v0);
    }

    fun init(arg0: PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ProfileRegistry{
            id       : 0x2::object::new(arg1),
            version  : 1,
            registry : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<ProfileRegistry>(v1);
        let v2 = AdmincCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdmincCap>(v2, v0);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://liquidlink.io/api/profile/{id}/image"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}'s profile at LiquidLink. Check it out at https://liquidlink.io/{id}. Create your own at https://liquidlink.io"));
        let v7 = 0x2::package::claim<PROFILE>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<Profile>(&v7, v3, v5, arg1);
        0x2::display::update_version<Profile>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Profile>>(v8, v0);
    }

    public fun metadata(arg0: &Profile) : 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        arg0.metadata
    }

    public fun module_exist<T0: drop>(arg0: &ProfileRegistry) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun name(arg0: &Profile) : 0x1::ascii::String {
        arg0.name
    }

    public fun owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun point_key<T0: drop>(arg0: &ProfileRegistry) : &0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0> {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun point_key_mut<T0: drop>(arg0: &mut ProfileRegistry, arg1: T0) : &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0> {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public fun profile_contains(arg0: &ProfileRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.registry, arg1)
    }

    public fun profile_of(arg0: &ProfileRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.registry, arg1)
    }

    public fun register(arg0: &mut ProfileRegistry, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::transfer<Profile>(register_(arg0, v0, 0x2::clock::timestamp_ms(arg4), arg1, arg2, arg3, arg5), v0);
    }

    fun register_(arg0: &mut ProfileRegistry, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) : Profile {
        let v0 = Profile{
            id          : 0x2::object::new(arg6),
            owner       : arg1,
            created_at  : arg2,
            avatar_url  : arg3,
            name        : arg4,
            description : arg5,
            metadata    : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        let v1 = 0x2::object::id<Profile>(&v0);
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::event::profile_created(arg1, v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.registry, arg1, v1);
        v0
    }

    public fun register_for(arg0: &mut ProfileRegistry, arg1: address, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Profile>(register_(arg0, arg1, 0x2::clock::timestamp_ms(arg5), arg2, arg3, arg4, arg6), arg1);
    }

    public fun register_point_module<T0: drop>(arg0: &AdmincCap, arg1: &mut ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 101);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>>(&mut arg1.id, v0, 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::new_point_key<T0>());
    }

    public fun remove_df_state<T0, T1: store>(arg0: &mut Profile, arg1: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : T1 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 103);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, T1>(&mut arg0.id, v0)
    }

    public fun remove_dof_state<T0, T1: store + key>(arg0: &mut Profile, arg1: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>) : T1 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 103);
        0x2::dynamic_object_field::remove<0x1::type_name::TypeName, T1>(&mut arg0.id, v0)
    }

    public fun remove_metadata(arg0: &mut Profile, arg1: 0x1::ascii::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.metadata, &arg1);
    }

    public fun remove_point_module<T0: drop>(arg0: &AdmincCap, arg1: &mut ProfileRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 104);
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::drop_point_key<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointKey<T0>>(&mut arg1.id, v0));
    }

    public fun stake_point_by_admin<T0: drop, T1>(arg0: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointDashBoard<T0>, arg1: &AdmincCap, arg2: 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::StakePointRequest<T0, T1>) {
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::stake_point<T0, T1>(arg0, arg2);
    }

    public fun sub_point_by_admin<T0>(arg0: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointDashBoard<T0>, arg1: &AdmincCap, arg2: 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::SubPointRequest<T0>) {
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::sub_point<T0>(arg0, arg2);
    }

    public fun unstake_point_by_admin<T0: drop, T1>(arg0: &mut 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::PointDashBoard<T0>, arg1: &AdmincCap, arg2: 0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::UnstakePointRequest<T0, T1>) {
        0x3dcd3cbc5ee046e3392b38f8c28da662a5ca4ea807b8a297d891fca8e4bf1f23::point::unstake_point<T0, T1>(arg0, arg2);
    }

    public fun update_avatar_url(arg0: &mut Profile, arg1: 0x1::ascii::String) {
        arg0.avatar_url = arg1;
    }

    public fun update_description(arg0: &mut Profile, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
    }

    public fun update_metadata(arg0: &mut Profile, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        if (0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(&arg0.metadata, &arg1)) {
            *0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.metadata, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.metadata, arg1, arg2);
        };
    }

    public fun update_name(arg0: &mut Profile, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

