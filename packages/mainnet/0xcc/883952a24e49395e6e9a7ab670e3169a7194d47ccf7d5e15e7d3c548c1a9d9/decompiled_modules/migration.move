module 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::migration {
    struct MigrationAdmin has store, key {
        id: 0x2::object::UID,
    }

    public fun link_attention_boards<T0>(arg0: &MigrationAdmin, arg1: &mut 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::AttentionBoard<T0>, arg2: 0x2::object::ID) {
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::link_attention_boards<T0>(arg1, arg2);
    }

    public fun emit_bump_message_bid<T0>(arg0: &MigrationAdmin, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64) {
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::events::emit_bump_message_bid<T0>(arg1, arg2, arg3, arg4);
    }

    public fun emit_message_cancelled<T0>(arg0: &MigrationAdmin, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::events::emit_message_cancelled<T0>(arg1, arg2);
    }

    public fun emit_message_submitted<T0>(arg0: &MigrationAdmin, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::events::emit_message_submitted<T0>(arg1, arg2);
    }

    public fun emit_new_message_bid<T0>(arg0: &MigrationAdmin, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64) {
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::events::emit_new_message_bid<T0>(arg1, arg2, arg3, arg4);
    }

    public fun clone_attention_board<T0>(arg0: &MigrationAdmin, arg1: &0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::AttentionBoard<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::AttentionBoard<T0>>(0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::create_attention_board<T0>(0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_minimum_bid<T0>(arg1), 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_kol<T0>(arg1), 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_kol<T0>(arg1), 0x1::option::none<address>(), 0x1::option::none<address>(), arg2, arg3, arg4));
    }

    public fun clone_config(arg0: &MigrationAdmin, arg1: &mut 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::GlobalConfig, arg2: u16, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::set_global_config_v2_created(arg1);
        0x2::transfer::public_share_object<0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::GlobalConfig>(0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::new_config(0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_receiver(arg1), 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_refund_fee_bps(arg1), 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_protocol_share_of_refund_fee(arg1), 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_protocol_share_of_success_fee(arg1), arg2, arg3, 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::get_admin_cap(arg1), arg4));
    }

    public fun initialize(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : MigrationAdmin {
        assert!(0x2::object::id<0x2::package::UpgradeCap>(arg0) == 0x2::object::id_from_address(@0x55d5952be3e17f0b83e46c45134d7b2164bc5dd258cfb39848efa3ef116852a6), 0);
        MigrationAdmin{id: 0x2::object::new(arg1)}
    }

    public fun migrate_attention_board<T0>(arg0: &MigrationAdmin, arg1: 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::AttentionBoard<T0>, arg2: &mut 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::AttentionBoard<T0>, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::destruct<T0>(arg1);
        let v4 = v1;
        assert!(v0 == 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::get_kol<T0>(arg2), 0);
        assert!(v2 == 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::get_minimum_bid<T0>(arg2), 0);
        0x1::vector::reverse<0x2::object::ID>(&mut arg3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v6 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg3);
            0x2::object_table::add<0x2::object::ID, 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::Message<T0>>(0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::messages_mut<T0>(arg2), v6, 0x2::object_table::remove<0x2::object::ID, 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::Message<T0>>(&mut v4, v6));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg3);
        0x2::object_table::destroy_empty<0x2::object::ID, 0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::attention_board::Message<T0>>(v4);
        0x4bee87542eccc5cd4808afa585ef55834023e33728cf4874c318b0cf13040e70::board::join_bid<T0>(arg2, v3);
    }

    // decompiled from Move bytecode v6
}

