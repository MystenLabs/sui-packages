module 0x58a2962fd3c85f9826cb6a6a4c275a31fc626f387e10a5770b708c6a336e03a1::recording_master_reference {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MasterReferenceSetEvent has copy, drop {
        recording_id: 0x2::object::ID,
    }

    struct MasterReferenceUnsetEvent has copy, drop {
        recording_id: 0x2::object::ID,
    }

    public fun has_master_reference<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    public fun master_reference<T0, T1>(arg0: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>) : &0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData {
        assert!(has_master_reference<T0, T1>(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid<T0, T1>(arg0), v0)
    }

    public fun set_master_reference<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>, arg2: 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData) {
        0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::assert_is_blob(&arg2);
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(v0, v2) = arg2;
        } else {
            let v3 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(v0, v3, arg2);
        };
        let v4 = MasterReferenceSetEvent{recording_id: 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::id<T0, T1>(arg0)};
        0x2::event::emit<MasterReferenceSetEvent>(v4);
    }

    public fun unset_master_reference<T0, T1>(arg0: &mut 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::Recording<T0, T1>, arg1: &0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::RecordingAdminCap<T0>) {
        let v0 = 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(v0, v2);
            let v3 = MasterReferenceUnsetEvent{recording_id: 0xe8e53f3f794b048172080f2a655b24b7ee5abfeeadcfe1c1de856a9a98282847::recording::id<T0, T1>(arg0)};
            0x2::event::emit<MasterReferenceUnsetEvent>(v3);
        };
    }

    // decompiled from Move bytecode v7
}

