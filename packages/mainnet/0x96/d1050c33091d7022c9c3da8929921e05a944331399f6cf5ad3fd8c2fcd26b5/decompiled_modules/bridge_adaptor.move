module 0x96d1050c33091d7022c9c3da8929921e05a944331399f6cf5ad3fd8c2fcd26b5::bridge_adaptor {
    struct BridgeRecipient<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct BridgeAsset has drop {
        dummy_field: bool,
    }

    public fun bridge_asset<T0, T1>(arg0: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T1>, arg1: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::GuardManager<T1>, arg2: u64, arg3: &mut 0xb::bridge::Bridge, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg5));
        let v2 = 0x1::option::some<vector<u8>>(v0);
        let v3 = BridgeAsset{dummy_field: false};
        let v4 = 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::authorize_and_withdraw_if_needed<T0, BridgeAsset, T1>(arg0, arg1, v3, arg2, &v2, arg6);
        0xb::bridge::send_token<T0>(arg3, arg4, arg5, 0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4), arg6);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
    }

    entry fun migrate_recipient<T0>(arg0: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::auth::Auth<T0>, arg1: &mut BridgeRecipient<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::auth::has_cap<T0, 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg1.version = 1;
    }

    public fun new_bridge_recipient<T0>(arg0: &0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::auth::Auth<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::auth::has_cap<T0, 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg1)), 0);
        let v0 = BridgeRecipient<T0>{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        0x2::transfer::share_object<BridgeRecipient<T0>>(v0);
    }

    public fun receive_bridged_asset<T0, T1>(arg0: &mut BridgeRecipient<T1>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::boring_vault::Vault<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        0x766114af1747f9da304efd484fc92459adb0a6085bb8c840992dc8cb61ca1f0::manager::return_asset<T0, T1>(arg2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg3);
    }

    // decompiled from Move bytecode v6
}

