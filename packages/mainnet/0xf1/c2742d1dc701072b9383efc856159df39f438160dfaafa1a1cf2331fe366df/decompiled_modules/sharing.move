module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::sharing {
    struct ShareLink has store, key {
        id: 0x2::object::UID,
        file_id: address,
        policy_id: address,
        shared_by: address,
        shared_with: vector<address>,
        permission: u8,
        label: vector<u8>,
        revoked: bool,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct ShareCreatedEvent has copy, drop {
        share_id: address,
        file_id: address,
        policy_id: address,
        shared_by: address,
        shared_with: vector<address>,
        permission: u8,
        expires_at_ms: u64,
    }

    struct ShareRevokedEvent has copy, drop {
        share_id: address,
        file_id: address,
        policy_id: address,
    }

    public fun create_public_share(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg2: address, arg3: address, arg4: u8, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : ShareLink {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::assert_can_share(arg1, arg7);
        assert!(arg4 == 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::permission_share() || arg4 == 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::permission_edit(), 502);
        let v0 = ShareLink{
            id            : 0x2::object::new(arg8),
            file_id       : arg2,
            policy_id     : arg3,
            shared_by     : 0x2::tx_context::sender(arg8),
            shared_with   : 0x1::vector::empty<address>(),
            permission    : arg4,
            label         : arg6,
            revoked       : false,
            expires_at_ms : arg5,
            created_at_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::record_share(arg1);
        let v1 = ShareCreatedEvent{
            share_id      : 0x2::object::id_address<ShareLink>(&v0),
            file_id       : arg2,
            policy_id     : arg3,
            shared_by     : 0x2::tx_context::sender(arg8),
            shared_with   : 0x1::vector::empty<address>(),
            permission    : arg4,
            expires_at_ms : arg5,
        };
        0x2::event::emit<ShareCreatedEvent>(v1);
        v0
    }

    public fun create_share(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg2: address, arg3: address, arg4: vector<address>, arg5: u8, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : ShareLink {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::assert_can_share(arg1, arg8);
        assert!(arg5 == 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::permission_share() || arg5 == 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::permission_edit(), 502);
        let v0 = ShareLink{
            id            : 0x2::object::new(arg9),
            file_id       : arg2,
            policy_id     : arg3,
            shared_by     : 0x2::tx_context::sender(arg9),
            shared_with   : arg4,
            permission    : arg5,
            label         : arg7,
            revoked       : false,
            expires_at_ms : arg6,
            created_at_ms : 0x2::clock::timestamp_ms(arg8),
        };
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::record_share(arg1);
        let v1 = ShareCreatedEvent{
            share_id      : 0x2::object::id_address<ShareLink>(&v0),
            file_id       : arg2,
            policy_id     : arg3,
            shared_by     : 0x2::tx_context::sender(arg9),
            shared_with   : v0.shared_with,
            permission    : arg5,
            expires_at_ms : arg6,
        };
        0x2::event::emit<ShareCreatedEvent>(v1);
        v0
    }

    public fun delete_share(arg0: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg1: ShareLink, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.shared_by == 0x2::tx_context::sender(arg2), 500);
        if (!arg1.revoked) {
            0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::record_unshare(arg0);
        };
        let ShareLink {
            id            : v0,
            file_id       : _,
            policy_id     : _,
            shared_by     : _,
            shared_with   : _,
            permission    : _,
            label         : _,
            revoked       : _,
            expires_at_ms : _,
            created_at_ms : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun expires_at(arg0: &ShareLink) : u64 {
        arg0.expires_at_ms
    }

    public fun file_id(arg0: &ShareLink) : address {
        arg0.file_id
    }

    public fun is_edit(arg0: &ShareLink) : bool {
        arg0.permission == 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::permission_edit()
    }

    public fun is_revoked(arg0: &ShareLink) : bool {
        arg0.revoked
    }

    public fun permission(arg0: &ShareLink) : u8 {
        arg0.permission
    }

    public fun policy_id(arg0: &ShareLink) : address {
        arg0.policy_id
    }

    public fun revoke_share(arg0: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::UserSubscription, arg1: &mut ShareLink, arg2: &mut 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::AccessPolicy, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.shared_by == 0x2::tx_context::sender(arg3), 500);
        assert!(!arg1.revoked, 501);
        arg1.revoked = true;
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::access_control::revoke_policy(arg2, arg3);
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription::record_unshare(arg0);
        let v0 = ShareRevokedEvent{
            share_id  : 0x2::object::id_address<ShareLink>(arg1),
            file_id   : arg1.file_id,
            policy_id : arg1.policy_id,
        };
        0x2::event::emit<ShareRevokedEvent>(v0);
    }

    public fun shared_by(arg0: &ShareLink) : address {
        arg0.shared_by
    }

    public fun shared_with(arg0: &ShareLink) : &vector<address> {
        &arg0.shared_with
    }

    public fun update_label(arg0: &mut ShareLink, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.shared_by == 0x2::tx_context::sender(arg2), 500);
        arg0.label = arg1;
    }

    // decompiled from Move bytecode v7
}

