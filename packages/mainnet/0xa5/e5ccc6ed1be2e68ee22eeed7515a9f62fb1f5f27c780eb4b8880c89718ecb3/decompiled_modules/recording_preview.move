module 0xa5e5ccc6ed1be2e68ee22eeed7515a9f62fb1f5f27c780eb4b8880c89718ecb3::recording_preview {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun has_preview<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v0)
    }

    public fun preview<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>) : &0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData {
        assert!(has_preview<T0, T1>(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v0)
    }

    public fun set_preview<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>, arg2: 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData) {
        0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::assert_is_blob(&arg2);
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(v0, v2) = arg2;
        } else {
            let v3 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(v0, v3, arg2);
        };
    }

    public fun unset_preview<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>) {
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(v0, v2);
        };
    }

    // decompiled from Move bytecode v7
}

