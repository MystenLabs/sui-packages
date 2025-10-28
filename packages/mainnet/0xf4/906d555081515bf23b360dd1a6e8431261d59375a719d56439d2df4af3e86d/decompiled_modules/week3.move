module 0xf4906d555081515bf23b360dd1a6e8431261d59375a719d56439d2df4af3e86d::week3 {
    struct WEEK3 has drop {
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

    fun init(arg0: WEEK3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<WEEK3>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_member(arg0: 0x1::ascii::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Rookie{
            id      : 0x2::object::new(arg1),
            creator : 0x2::tx_context::sender(arg1),
            name    : arg0,
            img_url : 0x1::ascii::string(b""),
            signer  : 0x1::option::none<address>(),
        };
        0x2::transfer::public_transfer<Rookie>(v0, 0x2::tx_context::sender(arg1));
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

    // decompiled from Move bytecode v6
}

