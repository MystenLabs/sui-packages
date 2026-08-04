module 0x30fe78d4af14119bd98e77d28dbf5ff61461b9db2a588731e00d00ce5fd26bf::recording_language {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LanguagesSetEvent has copy, drop {
        recording_id: 0x2::object::ID,
        languages: vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>,
    }

    struct LanguagesUnsetEvent has copy, drop {
        recording_id: 0x2::object::ID,
    }

    public fun has_languages<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v0)
    }

    public fun is_instrumental<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>) : bool {
        if (has_languages<T0, T1>(arg0)) {
            let v1 = ExtensionKey{dummy_field: false};
            0x1::vector::is_empty<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>(0x2::dynamic_field::borrow<ExtensionKey, vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v1))
        } else {
            false
        }
    }

    public fun languages<T0, T1>(arg0: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>) : vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode> {
        assert!(has_languages<T0, T1>(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ExtensionKey, vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v0)
    }

    public fun set_instrumental<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>) {
        set_languages<T0, T1>(arg0, arg1, 0x1::vector::empty<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>());
    }

    public fun set_languages<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>, arg2: vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>) {
        validate(&arg2);
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>>(v0, v2) = arg2;
        } else {
            let v3 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>>(v0, v3, arg2);
        };
        let v4 = ExtensionKey{dummy_field: false};
        let v5 = LanguagesSetEvent{
            recording_id : 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::id<T0, T1>(arg0),
            languages    : *0x2::dynamic_field::borrow<ExtensionKey, vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>>(0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid<T0, T1>(arg0), v4),
        };
        0x2::event::emit<LanguagesSetEvent>(v5);
    }

    public fun unset_languages<T0, T1>(arg0: &mut 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::Recording<T0, T1>, arg1: &0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::RecordingAdminCap<T0>) {
        let v0 = 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>>(v0, v2);
            let v3 = LanguagesUnsetEvent{recording_id: 0xe737857ae5d0fc1e5bf7837b665d740b531dd331d1882eef4aa0e6dc3cba1f28::recording::id<T0, T1>(arg0)};
            0x2::event::emit<LanguagesUnsetEvent>(v3);
        };
    }

    fun validate(arg0: &vector<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>) {
        assert!(0x1::vector::length<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>(arg0) <= 10, 2);
        let v0 = 0x2::vec_set::empty<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>(arg0)) {
            let v2 = 0x1::vector::borrow<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>(arg0, v1);
            assert!(!0x2::vec_set::contains<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>(&v0, v2), 3);
            0x2::vec_set::insert<0x416a57aeaf005563dbe29eb913683154058e84648a78e9bd55543fc5990ea9a9::language_code::LanguageCode>(&mut v0, *v2);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

