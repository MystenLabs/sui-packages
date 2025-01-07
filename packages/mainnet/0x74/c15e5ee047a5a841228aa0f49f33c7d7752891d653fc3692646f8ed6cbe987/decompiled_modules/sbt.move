module 0x74c15e5ee047a5a841228aa0f49f33c7d7752891d653fc3692646f8ed6cbe987::sbt {
    struct SBT has drop {
        dummy_field: bool,
    }

    struct Own has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, 0x2::table_vec::TableVec<0x2::object::ID>>,
    }

    struct KarmaGalxe has key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        id: 0x2::object::ID,
        sender: address,
    }

    public fun borrow_sbt_set(arg0: &Own, arg1: address) : &0x2::table_vec::TableVec<0x2::object::ID> {
        0x2::table::borrow<address, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.record, arg1)
    }

    public fun get_sbt_num(arg0: &Own, arg1: address) : u64 {
        0x2::table_vec::length<0x2::object::ID>(0x2::table::borrow<address, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.record, arg1))
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"KGMC"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ncve3zlcgkqkq7zx4pkqxozcg7e45gqhr4kwt2pavogmswp64lbq.arweave.net/aKpN5WIyoKh_N-PVC7siN8nOmgePFWnp4KuMyVn-4sM"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Kart Galaxy Membership Card."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://karmapi.ai/"));
        let v5 = 0x2::package::claim<SBT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<KarmaGalxe>(&v5, v1, v3, arg1);
        0x2::display::update_version<KarmaGalxe>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<KarmaGalxe>>(v6, v0);
        let v7 = Own{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, 0x2::table_vec::TableVec<0x2::object::ID>>(arg1),
        };
        0x2::transfer::share_object<Own>(v7);
    }

    public(friend) fun mint(arg0: &mut Own, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = KarmaGalxe{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<KarmaGalxe>(&v0);
        if (0x2::table::contains<address, 0x2::table_vec::TableVec<0x2::object::ID>>(&arg0.record, arg1)) {
            0x2::table_vec::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::table_vec::TableVec<0x2::object::ID>>(&mut arg0.record, arg1), v1);
        } else {
            0x2::table::add<address, 0x2::table_vec::TableVec<0x2::object::ID>>(&mut arg0.record, arg1, 0x2::table_vec::singleton<0x2::object::ID>(v1, arg2));
        };
        let v2 = MintEvent{
            id     : v1,
            sender : arg1,
        };
        0x2::event::emit<MintEvent>(v2);
        0x2::transfer::transfer<KarmaGalxe>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

