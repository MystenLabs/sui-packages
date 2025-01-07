module 0x25f00efbaa1162a54e431509c499cb83cabad15a7e616364ff6b8a4ed45f1bf7::PFPData {
    struct Global has key {
        id: 0x2::object::UID,
    }

    struct PFP has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
    }

    struct PFPSetEvent has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct PFPUnsetEvent has copy, drop {
        object_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Global>(v0);
    }

    public entry fun set_pfp<T0: store + key>(arg0: &mut Global, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = PFP{
            id     : 0x2::object::new(arg2),
            nft_id : arg1,
        };
        let v2 = PFPSetEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            nft_id    : arg1,
        };
        0x2::event::emit<PFPSetEvent>(v2);
        if (0x2::dynamic_object_field::exists_<address>(&arg0.id, v0)) {
            unset_pfp(arg0, arg2);
        };
        0x2::dynamic_object_field::add<address, PFP>(&mut arg0.id, v0, v1);
    }

    public entry fun unset_pfp(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 1);
        let PFP {
            id     : v1,
            nft_id : v2,
        } = 0x2::dynamic_object_field::remove<address, PFP>(&mut arg0.id, v0);
        let v3 = v1;
        let v4 = PFPUnsetEvent{
            object_id : 0x2::object::uid_to_inner(&v3),
            nft_id    : v2,
        };
        0x2::event::emit<PFPUnsetEvent>(v4);
        0x2::object::delete(v3);
    }

    // decompiled from Move bytecode v6
}

