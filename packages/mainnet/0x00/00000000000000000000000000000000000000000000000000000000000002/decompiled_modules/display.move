module 0x2::display {
    struct Display<phantom T0: key> has store, key {
        id: 0x2::object::UID,
        fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        version: u16,
    }

    struct DisplayCreated<phantom T0: key> has copy, drop {
        id: 0x2::object::ID,
    }

    struct VersionUpdated<phantom T0: key> has copy, drop {
        id: 0x2::object::ID,
        version: u16,
        fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public entry fun add<T0: key>(arg0: &mut Display<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        add_internal<T0>(arg0, arg1, arg2);
    }

    fun add_internal<T0: key>(arg0: &mut Display<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.fields, arg1, arg2);
    }

    public entry fun add_multiple<T0: key>(arg0: &mut Display<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 1);
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 13906834754163965951);
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            add_internal<T0>(arg0, 0x1::vector::pop_back<0x1::string::String>(&mut arg1), 0x1::vector::pop_back<0x1::string::String>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        0x1::vector::destroy_empty<0x1::string::String>(arg2);
    }

    public entry fun create_and_keep<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0, arg1);
        0x2::transfer::public_transfer<Display<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun create_internal<T0: key>(arg0: &mut 0x2::tx_context::TxContext) : Display<T0> {
        let v0 = 0x2::object::new(arg0);
        let v1 = DisplayCreated<T0>{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<DisplayCreated<T0>>(v1);
        Display<T0>{
            id      : v0,
            fields  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            version : 0,
        }
    }

    public entry fun edit<T0: key>(arg0: &mut Display<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.fields, &arg1);
        add_internal<T0>(arg0, arg1, arg2);
    }

    public fun fields<T0: key>(arg0: &Display<T0>) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.fields
    }

    public fun is_authorized<T0: key>(arg0: &0x2::package::Publisher) : bool {
        0x2::package::from_package<T0>(arg0)
    }

    public fun new<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : Display<T0> {
        assert!(is_authorized<T0>(arg0), 0);
        create_internal<T0>(arg1)
    }

    public fun new_with_fields<T0: key>(arg0: &0x2::package::Publisher, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : Display<T0> {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 1);
        let v0 = new<T0>(arg0, arg3);
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 13906834582365274111);
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = &mut v0;
            add_internal<T0>(v2, 0x1::vector::pop_back<0x1::string::String>(&mut arg1), 0x1::vector::pop_back<0x1::string::String>(&mut arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
        0x1::vector::destroy_empty<0x1::string::String>(arg2);
        v0
    }

    public entry fun remove<T0: key>(arg0: &mut Display<T0>, arg1: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.fields, &arg1);
    }

    public entry fun update_version<T0: key>(arg0: &mut Display<T0>) {
        arg0.version = arg0.version + 1;
        let v0 = VersionUpdated<T0>{
            id      : 0x2::object::uid_to_inner(&arg0.id),
            version : arg0.version,
            fields  : arg0.fields,
        };
        0x2::event::emit<VersionUpdated<T0>>(v0);
    }

    public fun version<T0: key>(arg0: &Display<T0>) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

