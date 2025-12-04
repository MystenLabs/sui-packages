module 0x2e1868608dfb69f01e1b3322a3f192e4c1e00b58b74ec8e3dea0e8362b99f86c::vault_operation {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultOperationConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        access_cap: 0x1::option::Option<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>,
        enable: bool,
    }

    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Resume has copy, drop {
        dummy_field: bool,
    }

    struct Fund has copy, drop {
        receiver: address,
        amount: u64,
        token: 0x1::ascii::String,
    }

    entry fun add_access_cap(arg0: &AdminCap, arg1: &mut VaultOperationConfig, arg2: 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap) {
        0x1::option::fill<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultOperationConfig{
            id         : 0x2::object::new(arg0),
            version    : 1,
            access_cap : 0x1::option::none<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(),
            enable     : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultOperationConfig>(v1);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut VaultOperationConfig) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    entry fun pause(arg0: &AdminCap, arg1: &mut VaultOperationConfig) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        arg1.enable = false;
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun resume(arg0: &AdminCap, arg1: &mut VaultOperationConfig) {
        assert!(arg1.version == 1, 2);
        assert!(!arg1.enable, 4);
        arg1.enable = true;
        let v0 = Resume{dummy_field: false};
        0x2::event::emit<Resume>(v0);
    }

    entry fun withdraw<T0, T1>(arg0: &AdminCap, arg1: &VaultOperationConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        assert!(arg5 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_vault_funds<T0, T1>(arg2, arg3, arg5, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg1.access_cap), arg6), arg4);
        let v0 = Fund{
            receiver : arg4,
            amount   : arg5,
            token    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<Fund>(v0);
    }

    entry fun withdraw_token<T0, T1, T2>(arg0: &AdminCap, arg1: &VaultOperationConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg3: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        assert!(arg5 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::spend_harvest_asset<T0, T1, T2>(arg2, arg3, arg5, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg1.access_cap), arg6), arg4);
        let v0 = Fund{
            receiver : arg4,
            amount   : arg5,
            token    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
        };
        0x2::event::emit<Fund>(v0);
    }

    // decompiled from Move bytecode v6
}

