module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::group_leaver {
    struct GroupLeaver has key {
        id: 0x2::object::UID,
    }

    public(friend) fun derivation_key() : 0x1::string::String {
        0x1::string::utf8(b"group_leaver")
    }

    public(friend) fun leave<T0: drop>(arg0: &GroupLeaver, arg1: &mut 0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::PermissionedGroup<T0>, arg2: &0x2::tx_context::TxContext) {
        0x541840ae7df705d1c6329c22415ed61f9140a18b79b13c1c9dc7415b115c1ba8::permissioned_group::object_remove_member<T0>(arg1, &arg0.id, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID) : GroupLeaver {
        GroupLeaver{id: 0x2::derived_object::claim<0x1::string::String>(arg0, 0x1::string::utf8(b"group_leaver"))}
    }

    public(friend) fun share(arg0: GroupLeaver) {
        0x2::transfer::share_object<GroupLeaver>(arg0);
    }

    // decompiled from Move bytecode v6
}

