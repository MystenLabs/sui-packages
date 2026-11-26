module 0x3778d046c6e4e9e31ed7baed0dc958fa0da2c36fd1dd88ada8e94a677ff6ab10::upgrade {
    struct Upgrader has key {
        id: 0x2::object::UID,
        version: u64,
        open: bool,
        cap: 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::ReissueCap,
    }

    struct Upgraded has copy, drop {
        old: 0x2::object::ID,
        new: 0x2::object::ID,
        key: 0x1::string::String,
        serial: u64,
        sender: address,
    }

    public fun upgrade(arg0: &Upgrader, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::names::Names, arg2: 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::Item, arg3: &mut 0x2::tx_context::TxContext) : 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::Item {
        assert!(arg0.version == 1, 13835058416059482114);
        assert!(arg0.open, 13835621370308132870);
        let v0 = 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::reissue(&arg0.cap, *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::name(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::kind(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::design(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::colourway(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::rarity(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::edition(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::description(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::key(&arg2), 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::serial(&arg2), 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::total(&arg2), 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::wear(&arg2), *0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::name_tag(&arg2), arg3);
        if (0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::names::has(arg1, *0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::key(&v0))) {
            0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::names::rename(arg1, &mut v0);
        };
        let v1 = Upgraded{
            old    : 0x2::object::id<0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::Item>(&arg2),
            new    : 0x2::object::id<0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::Item>(&v0),
            key    : *0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::key(&v0),
            serial : 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::serial(&v0),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Upgraded>(v1);
        0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::burn(arg2);
        v0
    }

    public fun close(arg0: Upgrader, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap) {
        let Upgrader {
            id      : v0,
            version : _,
            open    : _,
            cap     : v3,
        } = arg0;
        0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::destroy_reissue_cap(v3);
        0x2::object::delete(v0);
    }

    public fun is_open(arg0: &Upgrader) : bool {
        arg0.open
    }

    public fun migrate(arg0: &mut Upgrader, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap) {
        assert!(arg0.version < 1, 13835339826611814404);
        arg0.version = 1;
    }

    public fun set_open(arg0: &mut Upgrader, arg1: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg2: bool) {
        assert!(arg0.version == 1, 13835058325865168898);
        arg0.open = arg2;
    }

    public fun setup(arg0: &0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Upgrader{
            id      : 0x2::object::new(arg1),
            version : 1,
            open    : true,
            cap     : 0xd14f072e0cdff42747ca9949f59c49ce901a082c75d2370fd138c1a8c7d03dcb::universe::new_reissue_cap(arg0),
        };
        0x2::transfer::share_object<Upgrader>(v0);
    }

    public fun version(arg0: &Upgrader) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

