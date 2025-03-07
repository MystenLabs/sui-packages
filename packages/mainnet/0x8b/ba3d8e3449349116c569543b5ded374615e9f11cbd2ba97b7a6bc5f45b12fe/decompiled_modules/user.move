module 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::user {
    struct TypusUserRegistry has key {
        id: 0x2::object::UID,
        metadata: 0x2::linked_table::LinkedTable<address, Metadata>,
    }

    struct Metadata has drop, store {
        content: vector<u64>,
    }

    struct AddAccumulatedTgldAmount has copy, drop {
        user: address,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    public fun add_accumulated_tgld_amount(arg0: &0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::ManagerCap, arg1: &0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::Version, arg2: &mut TypusUserRegistry, arg3: &mut 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::tgld::TgldRegistry, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::version_check(arg1);
        if (arg5 == 0) {
            return vector[0]
        };
        if (!0x2::linked_table::contains<address, Metadata>(&arg2.metadata, arg4)) {
            let v0 = Metadata{content: vector[]};
            0x2::linked_table::push_back<address, Metadata>(&mut arg2.metadata, arg4, v0);
        };
        0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::utility::increase_u64_vector_value(&mut 0x2::linked_table::borrow_mut<address, Metadata>(&mut arg2.metadata, arg4).content, 0, arg5);
        0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::tgld::mint(arg0, arg1, arg3, arg4, arg5, arg6);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg5);
        let v2 = AddAccumulatedTgldAmount{
            user        : arg4,
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<AddAccumulatedTgldAmount>(v2);
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, arg5);
        v3
    }

    public fun get_user_metadata(arg0: &0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::Version, arg1: &TypusUserRegistry, arg2: address) : vector<u8> {
        0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::ecosystem::version_check(arg0);
        if (!0x2::linked_table::contains<address, Metadata>(&arg1.metadata, arg2)) {
            let v1 = Metadata{content: vector[]};
            0x1::bcs::to_bytes<Metadata>(&v1)
        } else {
            0x1::bcs::to_bytes<Metadata>(0x2::linked_table::borrow<address, Metadata>(&arg1.metadata, arg2))
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TypusUserRegistry{
            id       : 0x2::object::new(arg0),
            metadata : 0x2::linked_table::new<address, Metadata>(arg0),
        };
        0x2::transfer::share_object<TypusUserRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

