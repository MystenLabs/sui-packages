module 0x37e8336952e8ebca42807db81bc39adde8bed76b32b176b8fd5ae1ee91276275::ember_usdc_forwarder {
    struct Position has key {
        id: 0x2::object::UID,
        record: PositionRecord,
        receipt: 0x1::option::Option<0x2::coin::Coin<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>,
    }

    struct PositionRecord has store {
        owner: address,
        payout_destination: address,
        vault_id: 0x2::object::ID,
        principal_micros: u64,
        receipt_amount: u64,
        closed: bool,
    }

    struct Deposited has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        vault_id: 0x2::object::ID,
        principal_micros: u64,
        receipt_amount: u64,
    }

    struct WithdrawalQueued has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        payout_destination: address,
        vault_id: 0x2::object::ID,
        principal_micros: u64,
        shares: u64,
        estimated_return_micros: u64,
        sequence_number: u128,
    }

    struct ReceiptRecovered has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
        vault_id: 0x2::object::ID,
        principal_micros: u64,
        receipt_amount: u64,
    }

    fun assert_deposit_authority(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>) {
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig>(arg0) == @0xdcd2e53c6ebc03cea47bcfc656337f03bf64cf1069bb92419bb67f4969603bba, 1);
        assert!(0x2::object::id_address<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter>(arg1) == @0xa0722a3dd74837d9daa4a82c2ffd7ed4c1b6013d57a362a42cb5a6c9c004db6f, 2);
        assert!(!0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::is_paused(arg1), 3);
        assert!(0x2::object::id_address<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(arg4) == @0x6013f760aa089ef027e9b92f7c09edf5fef73ef6b48fc5ecd8af62a4ef2db3d8, 5);
        assert!(0x2::object::id_address<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig>(arg3) == @0x3a515233ab817af082ef31454cee5eb8122b8b7cd586bf6b26ae9b879ee1e565, 12);
        assert!(0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::canonical_adapter_registry_v2_id(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2>(arg2)), 4);
        0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::assert_active_v2_on_chain(arg2, b"sui-ember-usdc", b"sui");
    }

    fun assert_exit_authority(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>, arg2: &Position, arg3: &0x2::tx_context::TxContext) {
        assert_recorded_owner(arg2, 0x2::tx_context::sender(arg3));
        assert_recorded_vault(&arg2.record, 0x2::object::id<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(arg1));
        assert!(0x2::object::id_address<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(arg1) == @0x6013f760aa089ef027e9b92f7c09edf5fef73ef6b48fc5ecd8af62a4ef2db3d8, 5);
        assert!(0x2::object::id_address<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig>(arg0) == @0x3a515233ab817af082ef31454cee5eb8122b8b7cd586bf6b26ae9b879ee1e565, 12);
        assert!(0x1::option::is_some<0x2::coin::Coin<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(&arg2.receipt), 13);
    }

    fun assert_nonzero_owner(arg0: address) {
        assert!(arg0 != @0x0, 11);
    }

    fun assert_nonzero_principal(arg0: u64) {
        assert!(arg0 > 0, 9);
    }

    fun assert_recorded_owner(arg0: &Position, arg1: address) {
        assert!(arg1 == arg0.record.owner, 6);
        assert!(!arg0.record.closed, 7);
    }

    fun assert_recorded_vault(arg0: &PositionRecord, arg1: 0x2::object::ID) {
        assert!(arg1 == arg0.vault_id, 5);
    }

    fun close_position(arg0: &mut Position) : address {
        arg0.record.closed = true;
        arg0.record.payout_destination
    }

    public fun closed(arg0: &Position) : bool {
        arg0.record.closed
    }

    public fun deposit_usdc(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 15
    }

    public fun deposit_usdc_for_owner(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        abort 15
    }

    public fun deposit_usdc_for_owner_v2(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_deposit_authority(arg0, arg1, arg2, arg3, arg4);
        assert_nonzero_owner(arg6);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5);
        assert_nonzero_principal(v0);
        let v1 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_asset_v2<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>(arg4, arg3, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg5), 0, arg7, arg8);
        let v2 = 0x2::coin::value<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>(&v1);
        assert!(v2 > 0, 13);
        let v3 = 0x2::object::id<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(arg4);
        let v4 = PositionRecord{
            owner              : arg6,
            payout_destination : arg6,
            vault_id           : v3,
            principal_micros   : v0,
            receipt_amount     : v2,
            closed             : false,
        };
        let v5 = Position{
            id      : 0x2::object::new(arg8),
            record  : v4,
            receipt : 0x1::option::some<0x2::coin::Coin<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(v1),
        };
        let v6 = Deposited{
            position_id      : 0x2::object::id<Position>(&v5),
            owner            : arg6,
            vault_id         : v3,
            principal_micros : v0,
            receipt_amount   : v2,
        };
        0x2::event::emit<Deposited>(v6);
        0x2::transfer::transfer<Position>(v5, arg6);
    }

    public fun deposit_usdc_v2(arg0: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::ProtocolConfig, arg1: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::yield_router::YieldRouter, arg2: &0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry::AdapterRegistryV2, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        deposit_usdc_for_owner_v2(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7);
    }

    public fun owner(arg0: &Position) : address {
        arg0.record.owner
    }

    public fun payout_destination(arg0: &Position) : address {
        arg0.record.payout_destination
    }

    public fun principal_micros(arg0: &Position) : u64 {
        arg0.record.principal_micros
    }

    public fun receipt_amount(arg0: &Position) : u64 {
        arg0.record.receipt_amount
    }

    public fun recover_receipt_shares(arg0: &mut Position, arg1: &mut 0x2::tx_context::TxContext) {
        assert_recorded_owner(arg0, 0x2::tx_context::sender(arg1));
        let v0 = arg0.record.owner;
        let v1 = 0x2::object::id<Position>(arg0);
        let v2 = arg0.record.vault_id;
        let v3 = arg0.record.principal_micros;
        let v4 = arg0.record.receipt_amount;
        let v5 = 0x1::option::extract<0x2::coin::Coin<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(&mut arg0.receipt);
        close_position(arg0);
        let v6 = ReceiptRecovered{
            position_id      : v1,
            owner            : v0,
            vault_id         : v2,
            principal_micros : v3,
            receipt_amount   : v4,
        };
        0x2::event::emit<ReceiptRecovered>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(v5, v0);
    }

    public fun vault_id(arg0: &Position) : 0x2::object::ID {
        arg0.record.vault_id
    }

    public fun withdraw_all_usdc(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg1: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>, arg2: &mut Position, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_exit_authority(arg0, arg1, arg2, arg4);
        let v0 = 0x1::option::extract<0x2::coin::Coin<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>>(&mut arg2.receipt);
        assert!(0x2::coin::value<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>(&v0) == arg2.record.receipt_amount, 13);
        let v1 = arg2.record.payout_destination;
        let v2 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>(arg1, arg0, 0x2::coin::into_balance<0x820dd6ead8b56abb89a76cfc8e676703876a906a2e4dddde6c18c8052e5fd194::mrcusd::MRCUSD>(v0), v1, arg3, arg4);
        let (_, v4, v5, v6, _, v8) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::decode_withdrawal_request(&v2);
        assert!(v4 == v1, 14);
        close_position(arg2);
        let v9 = WithdrawalQueued{
            position_id             : 0x2::object::id<Position>(arg2),
            owner                   : arg2.record.owner,
            payout_destination      : v1,
            vault_id                : arg2.record.vault_id,
            principal_micros        : arg2.record.principal_micros,
            shares                  : v5,
            estimated_return_micros : v6,
            sequence_number         : v8,
        };
        0x2::event::emit<WithdrawalQueued>(v9);
    }

    // decompiled from Move bytecode v7
}

