module 0x2d2945282b150cf9c0b431ac1b725067a1c1d0955a6d0b58d0bbb439a6ccf163::brave_sbt {
    struct SbtAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BraveSbt has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        link: 0x1::string::String,
        description: 0x1::string::String,
        is_locked: bool,
    }

    struct SbtCreated has copy, drop {
        object_id: 0x2::object::ID,
        minted_by: address,
        recipiment: address,
    }

    struct BRAVE_SBT has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: BraveSbt, arg1: address) {
        assert!(!arg0.is_locked, 13906834672559587329);
        0x2::transfer::transfer<BraveSbt>(arg0, arg1);
    }

    public fun bulk_mint(arg0: &SbtAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<address>(arg5);
        while (!0x1::vector::is_empty<address>(arg5)) {
            mint(arg0, arg1, arg2, arg3, arg4, 0x1::vector::pop_back<address>(arg5), arg6);
        };
    }

    public fun burn(arg0: &SbtAdminCap, arg1: BraveSbt) {
        let BraveSbt {
            id          : v0,
            name        : _,
            image_url   : _,
            link        : _,
            description : _,
            is_locked   : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    fun init(arg0: BRAVE_SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BRAVE_SBT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        let v5 = 0x2::display::new_with_fields<BraveSbt>(&v0, v1, v3, arg1);
        0x2::display::update_version<BraveSbt>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<BraveSbt>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = SbtAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SbtAdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun lock(arg0: &SbtAdminCap, arg1: &mut BraveSbt) {
        arg1.is_locked = true;
    }

    public fun mint(arg0: &SbtAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BraveSbt{
            id          : 0x2::object::new(arg6),
            name        : arg1,
            image_url   : arg2,
            link        : arg3,
            description : arg4,
            is_locked   : true,
        };
        let v1 = SbtCreated{
            object_id  : 0x2::object::id<BraveSbt>(&v0),
            minted_by  : 0x2::tx_context::sender(arg6),
            recipiment : arg5,
        };
        0x2::event::emit<SbtCreated>(v1);
        0x2::transfer::transfer<BraveSbt>(v0, arg5);
    }

    public fun unlock(arg0: &SbtAdminCap, arg1: &mut BraveSbt) {
        arg1.is_locked = false;
    }

    // decompiled from Move bytecode v6
}

