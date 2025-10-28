module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::week4 {
    struct Version has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct WEEK4 has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Member has key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        img_url: 0x1::ascii::String,
    }

    struct Rookie has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::ascii::String,
        img_url: 0x1::ascii::String,
        signer: 0x1::option::Option<address>,
    }

    struct MemberRegisterEvent has copy, drop {
        member_id: 0x2::object::ID,
        name: 0x1::ascii::String,
        img_url: 0x1::ascii::String,
        timestamp: u64,
    }

    struct MarktetPlace has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct Listing<T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        price: u64,
        item: T0,
    }

    public fun add_whitelist(arg0: &AdminCap, arg1: &mut MarktetPlace, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.whitelist, arg2);
    }

    public fun buy(arg0: &mut MarktetPlace, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Rookie {
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let Listing {
                id    : v0,
                owner : v1,
                price : v2,
                item  : v3,
            } = 0x2::dynamic_field::remove<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), v1);
            0x2::object::delete(v0);
            return v3
        };
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 404);
        let Listing {
            id    : v4,
            owner : v5,
            price : v6,
            item  : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v6, arg3), v5);
        0x2::object::delete(v4);
        v7
    }

    public fun create_market(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarktetPlace{
            id        : 0x2::object::new(arg1),
            whitelist : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<MarktetPlace>(v0);
    }

    public fun delist_rookie_with_df(arg0: &mut MarktetPlace, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : Rookie {
        let Listing {
            id    : v0,
            owner : v1,
            price : _,
            item  : v3,
        } = 0x2::dynamic_field::remove<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, arg1);
        assert!(v1 == 0x2::tx_context::sender(arg2), 13906835157890891775);
        0x2::object::delete(v0);
        v3
    }

    public fun delist_rookie_with_dof(arg0: &mut MarktetPlace, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : Rookie {
        let Listing {
            id    : v0,
            owner : v1,
            price : _,
            item  : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, arg1);
        assert!(v1 == 0x2::tx_context::sender(arg2), 13906835226610368511);
        0x2::object::delete(v0);
        v3
    }

    fun init(arg0: WEEK4, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WEEK4>(arg0, arg1);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 2,
        };
        0x2::transfer::share_object<Version>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun list_rookie_with_df(arg0: &mut MarktetPlace, arg1: Rookie, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing<Rookie>{
            id    : 0x2::object::new(arg3),
            owner : 0x2::tx_context::sender(arg3),
            price : arg2,
            item  : arg1,
        };
        0x2::dynamic_field::add<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, 0x2::object::id<Rookie>(&arg1), v0);
    }

    public fun list_rookie_with_dof(arg0: &mut MarktetPlace, arg1: Rookie, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing<Rookie>{
            id    : 0x2::object::new(arg3),
            owner : 0x2::tx_context::sender(arg3),
            price : arg2,
            item  : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, 0x2::object::id<Rookie>(&arg1), v0);
    }

    public fun new_member(arg0: &Version, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        if (!(2 == arg0.version)) {
            abort 0
        };
        let v0 = Rookie{
            id      : 0x2::object::new(arg2),
            creator : 0x2::tx_context::sender(arg2),
            name    : arg1,
            img_url : 0x1::ascii::string(b""),
            signer  : 0x1::option::none<address>(),
        };
        0x2::transfer::public_transfer<Rookie>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun new_rookie(arg0: 0x1::ascii::String, arg1: &mut 0x2::tx_context::TxContext) : Rookie {
        Rookie{
            id      : 0x2::object::new(arg1),
            creator : 0x2::tx_context::sender(arg1),
            name    : arg0,
            img_url : 0x1::ascii::string(b""),
            signer  : 0x1::option::none<address>(),
        }
    }

    public fun remove_whitelist(arg0: &AdminCap, arg1: &mut MarktetPlace, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.whitelist, &arg2);
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut Version) {
        arg1.version = 2;
    }

    public fun update_img_url(arg0: &mut Rookie, arg1: 0x1::ascii::String) {
        arg0.img_url = arg1;
    }

    public fun update_name(arg0: &mut Rookie, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    public fun update_with_different_signer(arg0: &mut Rookie, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator != 0x2::tx_context::sender(arg1), 100);
        arg0.signer = 0x1::option::some<address>(0x2::tx_context::sender(arg1));
    }

    public fun upgrade(arg0: Rookie, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let Rookie {
            id      : v0,
            creator : v1,
            name    : v2,
            img_url : v3,
            signer  : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        0x2::object::delete(v0);
        let v8 = if (0x1::option::is_some<address>(&v5)) {
            if (0x2::tx_context::sender(arg2) == v1) {
                if (!0x1::ascii::is_empty(&v6)) {
                    !0x1::ascii::is_empty(&v7)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 101);
        let v9 = 0x2::object::new(arg2);
        let v10 = MemberRegisterEvent{
            member_id : 0x2::object::uid_to_inner(&v9),
            name      : v7,
            img_url   : v6,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<MemberRegisterEvent>(v10);
        let v11 = Member{
            id      : v9,
            name    : v7,
            img_url : v6,
        };
        0x2::transfer::transfer<Member>(v11, 0x2::tx_context::sender(arg2));
    }

    public fun whitelist_buy(arg0: &mut MarktetPlace, arg1: &Member, arg2: 0x2::object::ID) : Rookie {
        let v0 = 0x2::object::id<Member>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.whitelist, &v0), 13906835432768798719);
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg2)) {
            let Listing {
                id    : v1,
                owner : _,
                price : _,
                item  : v4,
            } = 0x2::dynamic_field::remove<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, arg2);
            0x2::object::delete(v1);
            return v4
        };
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 404);
        let Listing {
            id    : v5,
            owner : _,
            price : _,
            item  : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<Rookie>>(&mut arg0.id, arg2);
        0x2::object::delete(v5);
        v8
    }

    // decompiled from Move bytecode v6
}

