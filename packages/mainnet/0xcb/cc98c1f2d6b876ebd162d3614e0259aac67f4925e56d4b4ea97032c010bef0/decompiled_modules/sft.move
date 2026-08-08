module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::sft {
    struct Registry<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        types: 0x2::table::Table<0x2::object::ID, TypeInfo>,
        type_count: u64,
    }

    struct TypeInfo has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        max_supply: 0x1::option::Option<u64>,
        minted: u64,
        burned: u64,
    }

    struct Stack<phantom T0> has store, key {
        id: 0x2::object::UID,
        type_id: 0x2::object::ID,
        amount: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun amount<T0>(arg0: &Stack<T0>) : u64 {
        arg0.amount
    }

    fun assert_version<T0>(arg0: &Registry<T0>) {
        assert!(arg0.version == 1, 13906834535121289227);
    }

    public fun burn<T0>(arg0: &mut Registry<T0>, arg1: Stack<T0>) {
        assert_version<T0>(arg0);
        let Stack {
            id        : v0,
            type_id   : v1,
            amount    : v2,
            name      : _,
            image_url : _,
        } = arg1;
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, TypeInfo>(&mut arg0.types, v1);
        v5.burned = v5.burned + v2;
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::sft_burned<T0>(v1, v2);
        0x2::object::delete(v0);
    }

    public fun circulating<T0>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, TypeInfo>(&arg0.types, arg1);
        v0.minted - v0.burned
    }

    public fun create_and_share_registry<T0>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry<T0>{
            id         : 0x2::object::new(arg1),
            version    : 1,
            types      : 0x2::table::new<0x2::object::ID, TypeInfo>(arg1),
            type_count : 0,
        };
        0x2::transfer::share_object<Registry<T0>>(v0);
    }

    public fun create_type<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut Registry<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_version<T0>(arg1);
        let v0 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg7));
        let v1 = TypeInfo{
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            attributes  : arg5,
            max_supply  : arg6,
            minted      : 0,
            burned      : 0,
        };
        0x2::table::add<0x2::object::ID, TypeInfo>(&mut arg1.types, v0, v1);
        arg1.type_count = arg1.type_count + 1;
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::type_created<T0>(v0, arg2, arg6);
        v0
    }

    public fun has_type<T0>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, TypeInfo>(&arg0.types, arg1)
    }

    public fun merge<T0>(arg0: &mut Stack<T0>, arg1: Stack<T0>) {
        let Stack {
            id        : v0,
            type_id   : v1,
            amount    : v2,
            name      : _,
            image_url : _,
        } = arg1;
        assert!(arg0.type_id == v1, 13906834891603443721);
        arg0.amount = arg0.amount + v2;
        0x2::object::delete(v0);
    }

    public fun migrate<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut Registry<T0>) {
        assert!(arg1.version < 1, 13906834560891224077);
        arg1.version = 1;
    }

    public fun mint<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<T0>, arg1: &mut Registry<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        assert!(arg3 > 0, 13906834736984358917);
        assert!(0x2::table::contains<0x2::object::ID, TypeInfo>(&arg1.types, arg2), 13906834741279064065);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, TypeInfo>(&mut arg1.types, arg2);
        if (0x1::option::is_some<u64>(&v0.max_supply)) {
            assert!(v0.minted + arg3 <= *0x1::option::borrow<u64>(&v0.max_supply), 13906834758459064323);
        };
        v0.minted = v0.minted + arg3;
        let v1 = Stack<T0>{
            id        : 0x2::object::new(arg5),
            type_id   : arg2,
            amount    : arg3,
            name      : v0.name,
            image_url : v0.image_url,
        };
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::sft_minted<T0>(arg2, arg4, arg3);
        0x2::transfer::public_transfer<Stack<T0>>(v1, arg4);
    }

    public fun safe_transfer<T0>(arg0: Stack<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::sft_transferred<T0>(arg0.type_id, 0x2::tx_context::sender(arg2), arg1, arg0.amount);
        0x2::transfer::public_transfer<Stack<T0>>(arg0, arg1);
    }

    public fun split<T0>(arg0: &mut Stack<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Stack<T0> {
        assert!(arg1 > 0, 13906834827178672133);
        assert!(arg1 < arg0.amount, 13906834831473770503);
        arg0.amount = arg0.amount - arg1;
        Stack<T0>{
            id        : 0x2::object::new(arg2),
            type_id   : arg0.type_id,
            amount    : arg1,
            name      : arg0.name,
            image_url : arg0.image_url,
        }
    }

    public fun type_burned<T0>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, TypeInfo>(&arg0.types, arg1).burned
    }

    public fun type_count<T0>(arg0: &Registry<T0>) : u64 {
        arg0.type_count
    }

    public fun type_id<T0>(arg0: &Stack<T0>) : 0x2::object::ID {
        arg0.type_id
    }

    public fun type_minted<T0>(arg0: &Registry<T0>, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, TypeInfo>(&arg0.types, arg1).minted
    }

    public fun version<T0>(arg0: &Registry<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

