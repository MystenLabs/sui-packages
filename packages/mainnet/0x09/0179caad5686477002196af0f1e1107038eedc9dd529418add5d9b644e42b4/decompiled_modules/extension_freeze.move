module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::extension_freeze {
    struct ExtensionFrozenKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExtensionFrozen has copy, drop, store {
        dummy_field: bool,
    }

    struct ExtensionConfigFrozenEvent has copy, drop {
        assembly_id: 0x2::object::ID,
    }

    public(friend) fun freeze_extension_config(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) {
        let v0 = ExtensionFrozenKey{dummy_field: false};
        let v1 = ExtensionFrozen{dummy_field: false};
        0x2::dynamic_field::add<ExtensionFrozenKey, ExtensionFrozen>(arg0, v0, v1);
        let v2 = ExtensionConfigFrozenEvent{assembly_id: arg1};
        0x2::event::emit<ExtensionConfigFrozenEvent>(v2);
    }

    public fun is_extension_frozen(arg0: &0x2::object::UID) : bool {
        let v0 = ExtensionFrozenKey{dummy_field: false};
        0x2::dynamic_field::exists_<ExtensionFrozenKey>(arg0, v0)
    }

    public(friend) fun remove_frozen_marker_if_present(arg0: &mut 0x2::object::UID) {
        let v0 = ExtensionFrozenKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ExtensionFrozenKey>(arg0, v0)) {
            let v1 = ExtensionFrozenKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionFrozenKey, ExtensionFrozen>(arg0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

