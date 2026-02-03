module 0xaf5fe7efcf6da874a1bf6f5ecda478736de214ba23cbf486cd5d3d65b2f52047::vault_operation {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultOperationConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        access_cap: 0x1::option::Option<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::AccessCap>,
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

    entry fun add_access_cap(arg0: &AdminCap, arg1: &mut VaultOperationConfig, arg2: 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::AccessCap) {
        0x1::option::fill<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultOperationConfig{
            id         : 0x2::object::new(arg0),
            version    : 1,
            access_cap : 0x1::option::none<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::AccessCap>(),
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

    entry fun withdraw<T0, T1>(arg0: &AdminCap, arg1: &VaultOperationConfig, arg2: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg3: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T0, T1>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        assert!(arg5 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::spend_vault_funds<T0, T1>(arg2, arg3, arg5, 0x1::option::borrow<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::AccessCap>(&arg1.access_cap), arg6), arg4);
        let v0 = Fund{
            receiver : arg4,
            amount   : arg5,
            token    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<Fund>(v0);
    }

    entry fun withdraw_token<T0, T1, T2>(arg0: &AdminCap, arg1: &VaultOperationConfig, arg2: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::VaultConfig, arg3: &mut 0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::Vault<T0, T1>, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 3);
        assert!(arg5 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::spend_harvest_asset<T0, T1, T2>(arg2, arg3, arg5, 0x1::option::borrow<0x45355b07146d699e6a8c405bcc2f60ef5d062a15183c6012ac55d5734d8add21::vault::AccessCap>(&arg1.access_cap), arg6), arg4);
        let v0 = Fund{
            receiver : arg4,
            amount   : arg5,
            token    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
        };
        0x2::event::emit<Fund>(v0);
    }

    // decompiled from Move bytecode v6
}

