module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::org_transfer {
    struct OrgTransfer has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: &mut 0x2::object::UID, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg0, arg2), 0);
        let v0 = OrgTransfer{dummy_field: false};
        let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::add_type<OrgTransfer>(&v0, arg2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::transfer(arg0, 0x1::option::some<address>(arg1), &v1);
    }

    public fun transfer_to_object<T0: key>(arg0: &mut 0x2::object::UID, arg1: &T0, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        transfer(arg0, 0x2::object::id_address<T0>(arg1), arg2);
    }

    public fun transfer_to_type<T0>(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        transfer(arg0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_into_address<T0>(), arg1);
    }

    // decompiled from Move bytecode v6
}

