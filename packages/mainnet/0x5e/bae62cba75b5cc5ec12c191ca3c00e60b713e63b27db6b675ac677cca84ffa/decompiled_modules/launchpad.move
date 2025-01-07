module 0x5ebae62cba75b5cc5ec12c191ca3c00e60b713e63b27db6b675ac677cca84ffa::launchpad {
    struct Launchpad has store, key {
        id: 0x2::object::UID,
        buckets: 0x2::object::UID,
        publishers: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        access: 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::Access,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct LAUNCHPAD has drop {
        dummy_field: bool,
    }

    struct CreatLaunchpadEvent has copy, drop {
        launchpad: 0x2::object::ID,
        version: u64,
        name: 0x1::string::String,
    }

    public fun borrow<T0: store + key>(arg0: &Launchpad, arg1: 0x2::object::ID) : &T0 {
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::borrow_object<T0>(&arg0.buckets, arg1)
    }

    public fun borrow_mut<T0: drop, T1: store + key>(arg0: &T0, arg1: &mut Launchpad, arg2: 0x2::object::ID) : &mut T1 {
        assert_version(arg1);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"borrow_role"));
        assert_anyone_match_for_witness(arg1, 0x1::type_name::get<T0>(), v0);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::borrow_mut_object<T1>(&mut arg1.buckets, arg2)
    }

    public fun exists_object<T0: store + key>(arg0: &Launchpad, arg1: 0x2::object::ID) : bool {
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::exists_object<T0>(&arg0.buckets, arg1)
    }

    public fun get_object_id<T0: store + key>(arg0: &mut Launchpad, arg1: u64) : 0x2::object::ID {
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<T0>(&arg0.buckets, arg1)
    }

    public entry fun put<T0: store + key>(arg0: &mut Launchpad, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"put_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::put<T0>(&mut arg0.buckets, arg1, arg2);
    }

    public fun take<T0: store + key>(arg0: &mut Launchpad, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"take_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::take<T0>(&mut arg0.buckets, arg1, arg2)
    }

    fun assert_anyone_match_for_sender(arg0: &Launchpad, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::assert_anyone_match_for_sender(&arg0.access, 0x2::tx_context::sender(arg2), arg1);
    }

    fun assert_anyone_match_for_witness(arg0: &Launchpad, arg1: 0x1::type_name::TypeName, arg2: vector<0x2::object::ID>) {
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::assert_anyone_match_for_witness(&arg0.access, arg1, arg2);
    }

    public entry fun grant_roles_for_witness<T0>(arg0: &mut Launchpad, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"grant_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::grant_roles_for_witness<T0>(&mut arg0.access, arg1, arg2);
    }

    public fun has_role_for_witness(arg0: &Launchpad, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::has_role_for_witness(&arg0.access, arg1, arg2)
    }

    public entry fun revoke_roles_for_witness<T0>(arg0: &mut Launchpad, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"revoke_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::revoke_roles_for_witness<T0>(&mut arg0.access, arg1);
    }

    fun assert_owner(arg0: &mut 0x2::package::Publisher) {
        assert!(0x2::package::from_package<Launchpad>(arg0), 10003);
    }

    fun assert_version(arg0: &Launchpad) {
        assert!(arg0.version == 1, 10001);
    }

    public entry fun bind<T0: store + key>(arg0: &mut Launchpad, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"bind_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        if (0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::exists_bucket<T0>(&arg0.id)) {
            0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::assert_empty_bucket<T0>(&arg0.id);
        };
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::put<T0>(&mut arg0.id, arg1, arg2);
    }

    public fun borrow_access(arg0: &Launchpad) : &0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::Access {
        &arg0.access
    }

    public fun borrow_bind<T0: store + key>(arg0: &Launchpad) : &T0 {
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::assert_not_empty_bucket<T0>(&arg0.id);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::borrow_object<T0>(&arg0.id, 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<T0>(&arg0.id, 0))
    }

    public fun borrow_mut_access<T0>(arg0: &T0, arg1: &mut Launchpad) : &mut 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::Access {
        assert_version(arg1);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"borrow_access_role"));
        assert_anyone_match_for_witness(arg1, 0x1::type_name::get<T0>(), v0);
        &mut arg1.access
    }

    public fun borrow_mut_bind<T0, T1: store + key>(arg0: &T0, arg1: &mut Launchpad) : &mut T1 {
        assert_version(arg1);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"borrow_role"));
        assert_anyone_match_for_witness(arg1, 0x1::type_name::get<T0>(), v0);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::assert_not_empty_bucket<T1>(&arg1.id);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::borrow_mut_object<T1>(&mut arg1.id, 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<T1>(&arg1.id, 0))
    }

    public fun borrow_mut_publisher<T0, T1>(arg0: &T0, arg1: &mut Launchpad) : &mut 0x2::package::Publisher {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"borrow_role"));
        assert_anyone_match_for_witness(arg1, 0x1::type_name::get<T0>(), v0);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::package::Publisher>(&mut arg1.publishers, 0x1::type_name::get<T1>())
    }

    public fun borrow_version(arg0: &Launchpad) : &u64 {
        &arg0.version
    }

    public fun bucket_size<T0: store + key>(arg0: &Launchpad) : u64 {
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::size<T0>(&arg0.buckets)
    }

    public entry fun create_launchpad(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0x2::transfer::public_share_object<Launchpad>(init_launchpad<Witness>(arg0, v0, arg1));
    }

    public entry fun grant_roles(arg0: &mut Launchpad, arg1: address, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"grant_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::grant_roles_for_sender(&mut arg0.access, arg1, arg2, arg3);
    }

    public fun has_role(arg0: &Launchpad, arg1: address, arg2: 0x2::object::ID) : bool {
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::has_role_for_sender(&arg0.access, arg1, arg2)
    }

    fun init(arg0: LAUNCHPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LAUNCHPAD>(arg0, arg1);
        let v1 = 0x2::display::new<Launchpad>(&v0, arg1);
        0x2::display::add<Launchpad>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Launchpad>(&mut v1, 0x1::string::utf8(b"version"), 0x1::string::utf8(b"{version}"));
        0x2::display::update_version<Launchpad>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Launchpad>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_launchpad<T0: drop>(arg0: &mut 0x2::package::Publisher, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : Launchpad {
        assert_owner(arg0);
        let v0 = 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::init_access(arg2);
        *0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::borrow_mut_name(&mut v0) = 0x1::string::utf8(b"Access for launchpad");
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::grant_roles_for_witness<T0>(&mut v0, v1, arg2);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::grant_roles_for_sender(&mut v0, 0x2::tx_context::sender(arg2), v2, arg2);
        let v3 = Launchpad{
            id         : 0x2::object::new(arg2),
            buckets    : 0x2::object::new(arg2),
            publishers : 0x2::object::new(arg2),
            version    : 1,
            name       : 0x1::string::utf8(b"launchpad"),
            access     : v0,
        };
        let v4 = CreatLaunchpadEvent{
            launchpad : 0x2::object::id<Launchpad>(&v3),
            version   : v3.version,
            name      : v3.name,
        };
        0x2::event::emit<CreatLaunchpadEvent>(v4);
        v3
    }

    public entry fun migrate(arg0: &mut Launchpad, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        assert_anyone_match_for_sender(arg0, v0, arg1);
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public fun put_publisher<T0>(arg0: &mut Launchpad, arg1: 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::package::Publisher>(&mut arg0.publishers, 0x1::type_name::get<T0>(), arg1);
    }

    public entry fun revoke_roles(arg0: &mut Launchpad, arg1: address, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"revoke_role"));
        assert_anyone_match_for_sender(arg0, v0, arg3);
        0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::revoke_roles_for_sender(&mut arg0.access, arg1, arg2);
    }

    public entry fun set_name(arg0: &mut Launchpad, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        assert_anyone_match_for_sender(arg0, v0, arg2);
        arg0.name = 0x1::string::utf8(arg1);
    }

    public fun take_publisher<T0>(arg0: &mut Launchpad, arg1: &mut 0x2::tx_context::TxContext) : 0x2::package::Publisher {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        assert_anyone_match_for_sender(arg0, v0, arg1);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::package::Publisher>(&mut arg0.publishers, 0x1::type_name::get<T0>())
    }

    public fun take_publisher_to_sender<T0>(arg0: &mut Launchpad, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = take_publisher<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun take_to_sender<T0: store + key>(arg0: &mut Launchpad, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = take<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun unbind<T0: store + key>(arg0: &mut Launchpad, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version(arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"admin_role"));
        0x1::vector::push_back<0x2::object::ID>(v1, 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access::to_role(b"unbind_role"));
        assert_anyone_match_for_sender(arg0, v0, arg1);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::assert_not_empty_bucket<T0>(&arg0.id);
        0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::take<T0>(&mut arg0.id, 0xdd09401d8178ebc3404a308d3e3454f2b7d1998a537bd08259dcf5bbf007205::bucket::get_object_id<T0>(&arg0.id, 0), arg1)
    }

    public entry fun unbind_to_sender<T0: store + key>(arg0: &mut Launchpad, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = unbind<T0>(arg0, arg1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

