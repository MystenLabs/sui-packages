module 0x66dd6f65ebad8911bd196749098bfe6ef826049cef4086c5929863a5a30c93ef::kns {
    struct KNS has drop {
        dummy_field: bool,
    }

    struct Kns has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ApprovalEvent has copy, drop {
        object_id: 0x2::object::ID,
        ref: 0x1::string::String,
    }

    struct MintedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct BurnedEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    struct SetupDisplayEvent has copy, drop {
        display_type: 0x1::ascii::String,
    }

    public fun airdrop(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Kns{id: 0x2::object::new(arg2)};
        let v1 = MintedEvent{object_id: 0x2::object::id<Kns>(&v0)};
        0x2::event::emit<MintedEvent>(v1);
        0x2::transfer::public_transfer<Kns>(v0, arg1);
    }

    public fun airdrop_multi(arg0: &AdminCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            airdrop(arg0, 0x1::vector::pop_back<address>(&mut arg1), arg2);
            v0 = v0 + 1;
        };
    }

    public entry fun approve(arg0: &Kns, arg1: 0x1::string::String) {
        let v0 = ApprovalEvent{
            object_id : 0x2::object::id<Kns>(arg0),
            ref       : arg1,
        };
        0x2::event::emit<ApprovalEvent>(v0);
    }

    public fun burn(arg0: Kns) {
        let v0 = BurnedEvent{object_id: 0x2::object::id<Kns>(&arg0)};
        0x2::event::emit<BurnedEvent>(v0);
        let Kns { id: v1 } = arg0;
        0x2::object::delete(v1);
    }

    fun init(arg0: KNS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KNS>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun setup_display<T0: key>(arg0: &0x2::package::Publisher, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<T0> {
        assert!(0x2::package::from_package<T0>(arg0), 0);
        let v0 = 0x2::display::new_with_fields<T0>(arg0, arg1, arg2, arg3);
        0x2::display::update_version<T0>(&mut v0);
        let v1 = SetupDisplayEvent{display_type: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<SetupDisplayEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

