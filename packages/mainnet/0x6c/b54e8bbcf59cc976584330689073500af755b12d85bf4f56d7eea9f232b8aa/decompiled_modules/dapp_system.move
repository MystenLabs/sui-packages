module 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_system {
    public fun delete_global_field<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<vector<u8>>, arg3: vector<u8>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::delete_global_field<T0>(arg1, arg2, arg3);
    }

    public fun delete_global_record<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::delete_global_record<T0>(arg1, arg2, arg3);
    }

    public fun destroy_scene_permit<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(&arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::participants_still_present(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_participant_count(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(&arg1)) == 0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_permit_expire(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_type<T1>(&arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T1>(&arg1)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_scene_permit<T1>(arg1);
    }

    public fun ensure_has_global_record<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg1: vector<vector<u8>>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ensure_has_global_record<T0>(arg0, arg1);
    }

    public fun ensure_has_not_global_record<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg1: vector<vector<u8>>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ensure_has_not_global_record<T0>(arg0, arg1);
    }

    public fun framework_version() : u64 {
        1
    }

    public fun get_global_field<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg1: vector<vector<u8>>, arg2: vector<u8>) : vector<u8> {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_global_field<T0>(arg0, arg1, arg2)
    }

    public fun get_object_field<T0, T1: copy + drop + store>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ObjectStorage<T0>, arg1: vector<u8>) : T1 {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_object_field<T0, T1>(arg0, arg1)
    }

    public fun get_scene_field<T0, T1: copy + drop + store>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T0>, arg1: vector<u8>) : T1 {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_scene_field<T0, T1>(arg0, arg1)
    }

    public fun has_global_record<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg1: vector<vector<u8>>) : bool {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_global_record<T0>(arg0, arg1)
    }

    public fun has_object_field<T0, T1: copy + drop + store>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ObjectStorage<T0>, arg1: vector<u8>) : bool {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_object_field<T0, T1>(arg0, arg1)
    }

    public fun has_scene_field<T0, T1: copy + drop + store>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T0>, arg1: vector<u8>) : bool {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_scene_field<T0, T1>(arg0, arg1)
    }

    public fun marketplace_fee_bps(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub) : u64 {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::marketplace_fee_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0))
    }

    public fun new_scene_permit_with_invitations<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: vector<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) : 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1> {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_scene_permit_with_invitations<T1>(v0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun remove_object_field<T0: copy + drop, T1, T2: copy + drop + store>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ObjectStorage<T1>, arg2: vector<u8>) : T2 {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_dapp_key<T1>(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_object_delete_field(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_id<T1>(arg1)), arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::remove_object_field<T1, T2>(arg1, arg2)
    }

    public fun remove_scene_field<T0: copy + drop, T1, T2, T3: copy + drop + store>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T2>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) : T3 {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T2>(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        assert_scene_storage_bound_to_permit<T1, T2>(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_active(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(arg1), 0x2::tx_context::epoch_timestamp_ms(arg4)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_scene_participant(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_participant_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg4)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_delete_field(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_type<T2>(arg2), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_id<T2>(arg2)), arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::remove_scene_field<T2, T3>(arg2, arg3)
    }

    public fun set_global_field<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<u8>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_global_field<T0>(arg1, arg2, arg3, arg4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
    }

    public fun set_global_record<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: bool) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_global_record<T0>(arg1, arg2, arg3, arg4, arg5);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
    }

    public fun set_object_field<T0: copy + drop, T1, T2: copy + drop + store>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ObjectStorage<T1>, arg2: vector<u8>, arg3: T2) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_dapp_key<T1>(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_object_field<T1, T2>(arg1, arg2, arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_object_set_field(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_id<T1>(arg1)), arg2, 0x2::bcs::to_bytes<T2>(&arg3));
    }

    public fun set_scene_field<T0: copy + drop, T1, T2, T3: copy + drop + store>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T2>, arg3: vector<u8>, arg4: T3, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T2>(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        assert_scene_storage_bound_to_permit<T1, T2>(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_active(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(arg1), 0x2::tx_context::epoch_timestamp_ms(arg5)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_scene_participant(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_participant_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg5)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_scene_field<T2, T3>(arg2, arg3, arg4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_set_field(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_type<T2>(arg2), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_id<T2>(arg2)), arg3, 0x2::bcs::to_bytes<T3>(&arg4));
    }

    public fun share_scene_permit<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(&arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_scene_permit<T1>(arg1);
    }

    public fun share_scene_storage<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T1>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T1>(&arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_scene_storage<T1>(arg1);
    }

    public fun accept_coin_type(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config_mut(arg0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_coin_type(v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_pending_coin_type_change(0x1::option::is_some<0x1::type_name::TypeName>(v1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::coin_type_change_not_ready(0x2::clock::timestamp_ms(arg1) >= 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::coin_type_effective_at_ms(v0));
        let v2 = *0x1::option::borrow<0x1::type_name::TypeName>(v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_accepted_coin_type(v0, v2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_coin_type(v0, 0x1::option::none<0x1::type_name::TypeName>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_coin_type_effective_at_ms(v0, 0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_coin_type_changed(0x1::type_name::into_string(v2));
    }

    public fun accept_framework_admin(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_framework_admin(v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_pending_ownership_transfer(v1 != @0x0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v1 == 0x2::tx_context::sender(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_framework_admin(v0, v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_framework_admin(v0, @0x0);
    }

    public fun accept_ownership<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_pending_admin(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_pending_ownership_transfer(v0 != @0x0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v0 == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_admin(arg1, v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_pending_admin(arg1, @0x0);
    }

    public fun accept_scene_permit_invitation<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_active(v2, v1));
        let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_invites_expire_at(v2);
        if (0x1::option::is_some<u64>(&v3)) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invitation_expired(v1 <= *0x1::option::borrow<u64>(&v3));
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::accept_invitation_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_permit_accept(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T1>(arg1)), 0x2::tx_context::sender(arg2));
    }

    public fun accept_treasury(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config_mut(arg0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_treasury(v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_pending_ownership_transfer(v1 != @0x0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v1 == 0x2::tx_context::sender(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_treasury(v0, v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_treasury(v0, @0x0);
    }

    public fun activate_session<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_canonical_owner(v1 == 0x2::tx_context::sender(arg5));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_session_key(arg2 != @0x0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_session_key(arg2 != 0x2::tx_context::sender(arg5));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_session_duration(arg3 >= 60000);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_session_duration(arg3 <= 604800000);
        let v2 = 0x2::clock::timestamp_ms(arg4) + arg3;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_session_key(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_session_expires_at(arg1, v2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_session_activated(v0, v1, arg2, v2);
    }

    fun assert_framework_version(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_latest_version(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_version(arg0) == 1);
    }

    fun assert_scene_storage_bound_to_permit<T0, T1>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T0>, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T1>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T0>(arg0) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T1>(arg1));
        let v0 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_authorized_permit_id<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_key(0x1::option::is_some<address>(&v0));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_key(*0x1::option::borrow<address>(&v0) == 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T0>(arg0)));
    }

    public(friend) fun bump_framework_version(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub) {
        if (1 > 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_version(arg0)) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_framework_version(arg0, 1);
        };
    }

    public fun buy_fungible_record<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg3: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::Listing<T1>, arg4: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_framework_version(arg1);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_dapp_key<T1>(&arg3) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg4) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x2::tx_context::sender(arg6) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg4));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg4) != 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_listing_expired<T1>(&arg3, 0x2::tx_context::epoch_timestamp_ms(arg6)));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_price<T1>(&arg3);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg3);
        let v3 = (((v1 as u256) * (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::marketplace_fee_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg1)) as u256) / 10000) as u64);
        let v4 = v1 - v3;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::insufficient_payment(0x2::coin::value<T1>(&arg5) >= v1);
        let v5 = 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&arg3));
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v4, arg6), v2);
        };
        if (v3 > 0) {
            let v6 = 0x2::coin::split<T1>(&mut arg5, v3, arg6);
            settle_marketplace_fee<T0, T1>(arg0, arg1, arg2, v6, v5, arg6);
        };
        let v7 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&arg3);
        let v8 = 0x2::bcs::new(*0x1::vector::borrow<vector<u8>>(&v7, 0));
        let v9 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&arg3);
        let v10 = *0x1::vector::borrow<vector<u8>>(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&arg3), 0);
        let v11 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v11, v10);
        let v12 = if (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_user_record<T0>(arg4, v9)) {
            let v13 = 0x2::bcs::new(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_user_field<T0>(arg4, v9, v10));
            0x2::bcs::peel_u64(&mut v13)
        } else {
            0
        };
        let v14 = (v12 as u256) + (0x2::bcs::peel_u64(&mut v8) as u256);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::math_overflow(v14 <= 18446744073709551615);
        let v15 = (v14 as u64);
        let v16 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v16, 0x2::bcs::to_bytes<u64>(&v15));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg4, v9, v11, v16, false);
        let (_, _, _, _, _, _, _, _) = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_listing<T1>(arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_item_sold(v0, v5, 0x2::tx_context::sender(arg6), v2, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_type<T1>(&arg3), v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T1>(), true);
        arg5
    }

    public fun buy_record<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg3: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::Listing<T1>, arg4: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_framework_version(arg1);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_dapp_key<T1>(&arg3) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg4) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x2::tx_context::sender(arg6) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg4));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg4) != 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_listing_expired<T1>(&arg3, 0x2::tx_context::epoch_timestamp_ms(arg6)));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_price<T1>(&arg3);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg3);
        let v3 = (((v1 as u256) * (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::marketplace_fee_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg1)) as u256) / 10000) as u64);
        let v4 = v1 - v3;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::insufficient_payment(0x2::coin::value<T1>(&arg5) >= v1);
        let v5 = 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&arg3));
        let v6 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::item_already_owned(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_user_record<T0>(arg4, v6));
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v4, arg6), v2);
        };
        if (v3 > 0) {
            let v7 = 0x2::coin::split<T1>(&mut arg5, v3, arg6);
            settle_marketplace_fee<T0, T1>(arg0, arg1, arg2, v7, v5, arg6);
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg4, v6, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&arg3), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&arg3), false);
        let (_, _, _, _, _, _, _, _) = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_listing<T1>(arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_item_sold(v0, v5, 0x2::tx_context::sender(arg6), v2, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_type<T1>(&arg3), v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T1>(), false);
        arg5
    }

    public fun cancel_fungible_listing<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::Listing<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_dapp_key<T1>(&arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x2::tx_context::sender(arg3) == v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v1 == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2));
        let v2 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&arg1);
        let v3 = *0x1::vector::borrow<vector<u8>>(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&arg1), 0);
        let v4 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v4, v3);
        let v5 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&arg1);
        let v6 = 0x2::bcs::new(*0x1::vector::borrow<vector<u8>>(&v5, 0));
        let v7 = if (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_user_record<T0>(arg2, v2)) {
            let v8 = 0x2::bcs::new(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_user_field<T0>(arg2, v2, v3));
            0x2::bcs::peel_u64(&mut v8)
        } else {
            0
        };
        let v9 = (v7 as u256) + (0x2::bcs::peel_u64(&mut v6) as u256);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::math_overflow(v9 <= 18446744073709551615);
        let v10 = (v9 as u64);
        let v11 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v11, 0x2::bcs::to_bytes<u64>(&v10));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg2, v2, v4, v11, false);
        let (_, _, _, _, _, _, _, _) = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_listing<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_listing_cancelled(v0, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&arg1)), v1, true);
    }

    fun compute_values_bytes(arg0: &vector<vector<u8>>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            v1 = v1 + (0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v0)) as u256);
            v0 = v0 + 1;
        };
        v1
    }

    public fun create_and_share_scene_permit<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: vector<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_scene_permit<T1>(new_scene_permit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun create_and_share_scene_permit_with_invitations<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: vector<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_scene_permit<T1>(new_scene_permit_with_invitations<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun create_and_share_typed_object<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg1));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_object_storage<T1>(v0, arg2, arg3, arg4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::register_object_entity_id(arg1, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_type<T1>(&v1), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_entity_id<T1>(&v1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_id<T1>(&v1)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_object_storage<T1>(v1);
    }

    public fun create_and_share_typed_scene_system<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_scene_storage<T1>(new_typed_scene_system<T0, T1>(arg0, arg1, arg2, arg3));
    }

    public fun create_and_share_typed_scene_with_permit<T0: copy + drop, T1, T2>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_scene_storage<T2>(new_typed_scene_with_permit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun create_dapp<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage {
        assert_framework_version(arg1);
        let v0 = arg4 == 0 || arg4 == 1;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_settlement_mode(v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_already_initialized(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_dapp_genesis_done<T0>(arg1));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg1);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::default_free_credit_duration_ms(v1);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = if (v2 > 0) {
            v3 + v2
        } else {
            0
        };
        let v5 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::default_write_fee_dapp_share_bps(v1);
        let v6 = 0x2::tx_context::sender(arg6);
        let v7 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v7, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_package_id<T0>());
        let (v8, v9) = get_effective_fees(arg1);
        let v10 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_dapp_storage<T0>(arg2, arg3, v7, v3, v6, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::default_free_credit(v1), v4, v8, v9, arg4, v5, arg6);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_genesis_done<T0>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_dapp_created(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>(), v6, v3, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_id(&v10)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(&v10);
        v10
    }

    public fun create_user_storage<T0: copy + drop>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg3: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg1);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg2));
        let v1 = 0x2::tx_context::sender(arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::user_storage_already_exists(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_registered_user_storage(arg2, v1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::register_user_storage(arg2, v1);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_user_storage<T0>(v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_max_write_limit(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg1)), arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_user_storage_created(v0, v1, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_id(&v2)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_user_storage(v2);
    }

    public fun dapp_key<T0: copy + drop>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    public fun deactivate_session<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_active_session(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::session_key(arg1) != @0x0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1);
        let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::session_key(arg1);
        let v4 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::session_expires_at(arg1);
        let v5 = v4 > 0 && 0x2::tx_context::epoch_timestamp_ms(arg2) >= v4;
        let v6 = if (v1 == v2) {
            true
        } else if (v1 == v3) {
            true
        } else {
            v5
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v6);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::clear_session(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_session_deactivated(v0, v2, v3);
    }

    public fun delete_field<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_write_authorized(arg1, 0x2::tx_context::sender(arg4), 0x2::tx_context::epoch_timestamp_ms(arg4)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::delete_user_field<T0>(arg1, arg2, arg3);
    }

    public fun delete_record<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: &0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_write_authorized(arg1, 0x2::tx_context::sender(arg4), 0x2::tx_context::epoch_timestamp_ms(arg4)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::delete_user_record<T0>(arg1, arg2, arg3);
    }

    public fun destroy_typed_object<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ObjectStorage<T1>) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg1));
        let v1 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_type<T1>(&arg2);
        let v2 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_entity_id<T1>(&arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unregister_object_entity_id(arg1, v1, v2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_object_destroyed(v0, v1, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::object_storage_id<T1>(&arg2)), v2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_object_storage<T1>(arg2);
    }

    public fun destroy_typed_scene<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T1>) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T1>(&arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_destroyed(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_type<T1>(&arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_id<T1>(&arg1)), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_authorized_permit_id<T1>(&arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_scene_storage<T1>(arg1);
    }

    public fun ensure_dapp_admin<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg1: address) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg0) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg0) == arg1);
    }

    public fun ensure_has_not_record<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg1: vector<vector<u8>>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ensure_has_not_user_record<T0>(arg0, arg1);
    }

    public fun ensure_has_record<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg1: vector<vector<u8>>) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ensure_has_user_record<T0>(arg0, arg1);
    }

    public fun ensure_latest_version<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg1: u32) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg0) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_latest_version(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_version(arg0) == arg1);
    }

    public fun ensure_not_paused<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg0) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg0));
    }

    public fun expire_fungible_listing<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::Listing<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_dapp_key<T1>(&arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_listing_expired<T1>(&arg1, 0x2::tx_context::epoch_timestamp_ms(arg3)));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v1 == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2));
        let v2 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&arg1);
        let v3 = *0x1::vector::borrow<vector<u8>>(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&arg1), 0);
        let v4 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v4, v3);
        let v5 = *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&arg1);
        let v6 = 0x2::bcs::new(*0x1::vector::borrow<vector<u8>>(&v5, 0));
        let v7 = if (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_user_record<T0>(arg2, v2)) {
            let v8 = 0x2::bcs::new(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_user_field<T0>(arg2, v2, v3));
            0x2::bcs::peel_u64(&mut v8)
        } else {
            0
        };
        let v9 = (v7 as u256) + (0x2::bcs::peel_u64(&mut v6) as u256);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::math_overflow(v9 <= 18446744073709551615);
        let v10 = (v9 as u64);
        let v11 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v11, 0x2::bcs::to_bytes<u64>(&v10));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg2, v2, v4, v11, false);
        let (_, _, _, _, _, _, _, _) = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_listing<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_listing_expired(v0, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&arg1)), v1, true);
    }

    public fun expire_listing<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::Listing<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_dapp_key<T1>(&arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_listing_expired<T1>(&arg1, 0x2::tx_context::epoch_timestamp_ms(arg3)));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v1 == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg2, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&arg1), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&arg1), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&arg1), false);
        let (_, _, _, _, _, _, _, _) = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_listing<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_listing_expired(v0, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&arg1)), v1, false);
    }

    public fun extend_free_credit<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_free_credit(arg1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::free_credit(arg1), arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_free_credit_extended(v0, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun get_effective_fees(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub) : (u256, u256) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config(arg0);
        (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::base_fee_per_write(v0), 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::bytes_fee_per_byte(v0))
    }

    public fun get_effective_fees_at(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u64) : (u256, u256) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config(arg0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::fee_effective_at_ms(v0);
        if (v1 > 0 && arg1 >= v1) {
            (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_base_fee(v0), 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_bytes_fee(v0))
        } else {
            (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::base_fee_per_write(v0), 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::bytes_fee_per_byte(v0))
        }
    }

    public fun get_field<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg1: vector<vector<u8>>, arg2: vector<u8>) : vector<u8> {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_user_field<T0>(arg0, arg1, arg2)
    }

    public fun grant_free_credit<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg4));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_free_credit(arg1, arg2, arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_free_credit_granted(v0, arg2, arg3, 0x2::tx_context::sender(arg4));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
    }

    public fun has_record<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg1: vector<vector<u8>>) : bool {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::has_user_record<T0>(arg0, arg1)
    }

    public(friend) fun initialize_framework_fee<T0>(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u256, arg2: u256, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_fee_config_initialized(arg0)) {
            return
        };
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config_mut(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_base_fee_per_write(v0, arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_bytes_fee_per_byte(v0, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_treasury(v0, arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_accepted_coin_type(v0, 0x1::type_name::with_defining_ids<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_default_write_fee_dapp_share_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0), arg4);
    }

    public fun is_scene_permit_participant<T0>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T0>, arg1: address) : bool {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_participant_in_scene_permit<T0>(arg0, arg1)
    }

    public fun join_scene_permit<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_active(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(arg1), 0x2::tx_context::epoch_timestamp_ms(arg2)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_participant_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg2));
        if (!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_participant_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg2))) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_permit_join(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T1>(arg1)), 0x2::tx_context::sender(arg2));
        };
    }

    public fun leave_scene_permit<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::remove_participant_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg2));
        if (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_participant_in_scene_permit<T1>(arg1, 0x2::tx_context::sender(arg2))) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_permit_leave(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T1>(arg1)), 0x2::tx_context::sender(arg2));
        };
    }

    public fun new_scene_permit<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: vector<address>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1> {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_scene_permit_with_participants<T1>(v0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun new_typed_scene_system<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T1> {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_scene_storage_system<T1>(v0, arg2, arg3)
    }

    public fun new_typed_scene_with_permit<T0: copy + drop, T1, T2>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T2> {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_scene_storage_with_permit<T1, T2>(v0, arg3, arg2, arg4)
    }

    public fun propose_coin_type<T0>(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config_mut(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1) + 172800000;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_coin_type(v0, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_coin_type_effective_at_ms(v0, v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_coin_type_change_proposed(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v1);
    }

    public fun propose_framework_admin(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(v0) == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_framework_admin(v0, arg1);
    }

    public fun propose_ownership<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg1) == 0x2::tx_context::sender(arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_pending_admin(arg1, arg2);
    }

    public fun propose_treasury(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config_mut(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::treasury(v0) == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_treasury(v0, arg1);
    }

    public fun recharge_credit<T0: copy + drop, T1>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_settlement_mode(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::settlement_mode(arg1) == 0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config(arg0);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::accepted_coin_type(v1);
        let v3 = 0x1::option::is_some<0x1::type_name::TypeName>(v2) && *0x1::option::borrow<0x1::type_name::TypeName>(v2) == 0x1::type_name::with_defining_ids<T1>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_payment_coin_type(v3);
        let v4 = (0x2::coin::value<T1>(&arg2) as u256);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::insufficient_credit(v4 > 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::treasury(v1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_credit(arg1, v4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_credit_recharged(v0, 0x2::tx_context::sender(arg3), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
    }

    public fun remove_scene_field_system_maintenance<T0: copy + drop, T1, T2: copy + drop + store>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T1>, arg2: vector<u8>) : T2 {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T1>(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_delete_field(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_id<T1>(arg1)), arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::remove_scene_field<T1, T2>(arg1, arg2)
    }

    public fun restore_record<T0: copy + drop, T1>(arg0: T0, arg1: 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::Listing<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_dapp_key<T1>(&arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_is_fungible<T1>(&arg1));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_seller<T1>(&arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x2::tx_context::sender(arg3) == v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(v1 == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg2, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&arg1), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&arg1), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&arg1), false);
        let (_, _, _, _, _, _, _, _) = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::destroy_listing<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_listing_cancelled(v0, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&arg1)), v1, false);
    }

    public fun revoke_free_credit<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::free_credit(arg1);
        if (v1 == 0) {
            return
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_free_credit(arg1, 0, 0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_free_credit_revoked(v0, v1, 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
    }

    public fun set_dapp_settlement_config<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg1) == 0x2::tx_context::sender(arg3));
        let v1 = arg2 == 0 || arg2 == 1;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_settlement_mode(v1);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::settlement_mode(arg1);
        if (v2 == arg2) {
            return
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_settlement_mode(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_settlement_mode_changed(v0, v2, arg2);
    }

    public fun set_dapp_write_fee_share<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::revenue_share_exceeds_max(arg2 <= 10000);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_write_fee_dapp_share_bps(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_dapp_revenue_share_set(v0, arg2);
    }

    public fun set_field<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_write_authorized(arg1, 0x2::tx_context::sender(arg5), 0x2::tx_context::epoch_timestamp_ms(arg5)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::user_debt_limit_exceeded(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_count(arg1) < 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_write_limit(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_field<T0>(arg1, arg2, arg3, arg4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::increment_write_count(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_write_bytes(arg1, (0x1::vector::length<u8>(&arg4) as u256));
    }

    public fun set_field_reactive<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg3) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_canonical_owner(0x2::tx_context::sender(arg7) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_scene_participant(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_participant(v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_scene_participant(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_participant(v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg3)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_active(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(arg1), 0x2::tx_context::epoch_timestamp_ms(arg7)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::user_debt_limit_exceeded(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_count(arg2) < 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_write_limit(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_field<T0>(arg3, arg4, arg5, arg6);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::increment_write_count(arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_write_bytes(arg2, (0x1::vector::length<u8>(&arg6) as u256));
    }

    public fun set_framework_max_write_limit(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::write_limit_out_of_range(arg1 >= 1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_framework_max_write_limit_cfg(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0), arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_framework_max_write_limit_updated(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_metadata<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg1) == 0x2::tx_context::sender(arg7));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_name(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_description(arg1, arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_website_url(arg1, arg4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_cover_url(arg1, arg5);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_partners(arg1, arg6);
    }

    public fun set_paused<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg1) == 0x2::tx_context::sender(arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_paused(arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_dapp_paused_changed(v0, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun set_record<T0: copy + drop>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_write_authorized(arg1, 0x2::tx_context::sender(arg6), 0x2::tx_context::epoch_timestamp_ms(arg6)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::user_debt_limit_exceeded(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_count(arg1) < 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_write_limit(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::increment_write_count(arg1);
        if (!arg5) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_write_bytes(arg1, compute_values_bytes(&arg4));
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_record_reactive<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::ScenePermit<T1>, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg3) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_dapp_key<T1>(arg1) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_id<T1>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_canonical_owner(0x2::tx_context::sender(arg7) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_scene_participant(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_participant(v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::not_scene_participant(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_participant(v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg3)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::is_scene_active(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_permit_meta<T1>(arg1), 0x2::tx_context::epoch_timestamp_ms(arg7)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::user_debt_limit_exceeded(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_count(arg2) < 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_write_limit(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::increment_write_count(arg2);
        if (!0x1::vector::is_empty<vector<u8>>(&arg6)) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_write_bytes(arg2, compute_values_bytes(&arg6));
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_record<T0>(arg3, arg4, arg5, arg6, false);
    }

    public fun set_scene_field_system<T0: copy + drop, T1, T2: copy + drop + store>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::SceneStorage<T1>, arg2: vector<u8>, arg3: T2) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_dapp_key<T1>(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_key(0x1::option::is_none<address>(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_authorized_permit_id<T1>(arg1)));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_scene_field<T1, T2>(arg1, arg2, arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_scene_set_field(v0, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_type<T1>(arg1), 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::scene_storage_id<T1>(arg1)), arg2, 0x2::bcs::to_bytes<T2>(&arg3));
    }

    public fun settle_marketplace_fee<T0: copy + drop, T1>(arg0: T0, arg1: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg3: 0x2::coin::Coin<T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg1);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_paused(!0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_paused(arg2));
        let v1 = 0x2::coin::value<T1>(&arg3);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T1>(arg3);
            return
        };
        let v2 = (((v1 as u256) * (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::marketplace_dapp_share_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg1)) as u256) / 10000) as u64);
        let v3 = v1 - v2;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v3, arg5), 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::treasury(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config(arg1)));
        };
        if (v2 > 0) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_dapp_revenue<T1>(arg2, 0x2::coin::into_balance<T1>(arg3));
        } else {
            0x2::coin::destroy_zero<T1>(arg3);
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_marketplace_fee_settled(v0, arg4, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T1>(), v1, v3, v2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_revenue_state_record<T0, T1>(arg2);
    }

    public fun settle_writes<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_count(arg2);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_bytes(arg2);
        if (v1 == 0 && v2 == 0) {
            return
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_settlement_mode(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::settlement_mode(arg1) == 0);
        let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_base_fee_per_write(arg1);
        let v4 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_bytes_fee_per_byte(arg1);
        if (v3 == 0 && v4 == 0) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_settled_to_write(arg2);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_writes_settled(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v1, v2, 0, 0);
            return
        };
        let v5 = (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_write_fee_share_bps(arg1) as u256);
        let v6 = (v3 * (v1 as u256) + v4 * v2) * (10000 - v5) / 10000;
        if (v6 == 0) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_settled_to_write(arg2);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_writes_settled(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v1, v2, 0, 0);
            return
        };
        let v7 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::effective_free_credit(arg1, 0x2::tx_context::epoch_timestamp_ms(arg3));
        let v8 = v7 + 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::credit_pool(arg1);
        if (v8 == 0) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_settlement_skipped(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v1, v2);
            return
        };
        if (v8 >= v6) {
            let v9 = if (v7 >= v6) {
                v6
            } else {
                v7
            };
            let v10 = v6 - v9;
            if (v9 > 0) {
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::deduct_free_credit(arg1, v9);
            };
            if (v10 > 0) {
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::deduct_credit(arg1, v10);
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_total_settled(arg1, v10);
            };
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_settled_to_write(arg2);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_writes_settled(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v1, v2, v9, v10);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
        } else {
            let v11 = ((v8 * (v1 as u256) / v6) as u64);
            let v12 = v8 * v2 / v6;
            if (v11 == 0 && v12 == 0) {
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_settlement_skipped(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v1, v2);
                return
            };
            let v13 = (v3 * (v11 as u256) + v4 * v12) * (10000 - v5) / 10000;
            let v14 = if (v7 >= v13) {
                v13
            } else {
                v7
            };
            let v15 = v13 - v14;
            if (v14 > 0) {
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::deduct_free_credit(arg1, v14);
            };
            if (v15 > 0) {
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::deduct_credit(arg1, v15);
                0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_total_settled(arg1, v15);
            };
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_settled_count(arg2, v11);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_settled_bytes(arg2, v12);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_settlement_partial(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v11, v12, v1 - v11, v2 - v12, v14, v15);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
        };
    }

    public fun settle_writes_user_pays<T0: copy + drop, T1>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg2) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_settlement_mode(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::settlement_mode(arg1) == 1);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config(arg0);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::accepted_coin_type(v1);
        let v3 = 0x1::option::is_some<0x1::type_name::TypeName>(v2) && *0x1::option::borrow<0x1::type_name::TypeName>(v2) == 0x1::type_name::with_defining_ids<T1>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::wrong_payment_coin_type(v3);
        let v4 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_count(arg2);
        let v5 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::unsettled_bytes(arg2);
        if (v4 == 0 && v5 == 0) {
            return arg3
        };
        let v6 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_base_fee_per_write(arg1);
        let v7 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_bytes_fee_per_byte(arg1);
        if (v6 == 0 && v7 == 0) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_settled_to_write(arg2);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_writes_settled(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v4, v5, 0, 0);
            return arg3
        };
        let v8 = v6 * (v4 as u256) + v7 * v5;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::insufficient_credit(v8 <= 18446744073709551615);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::insufficient_credit((0x2::coin::value<T1>(&arg3) as u256) >= v8);
        let v9 = 0x2::coin::split<T1>(&mut arg3, (v8 as u64), arg4);
        let v10 = (v8 as u64) - ((v8 * (0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_write_fee_share_bps(arg1) as u256) / 10000) as u64);
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v9, v10, arg4), 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::treasury(v1));
        };
        let v11 = 0x2::coin::into_balance<T1>(v9);
        if (0x2::balance::value<T1>(&v11) > 0) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_dapp_revenue<T1>(arg1, v11);
        } else {
            0x2::balance::destroy_zero<T1>(v11);
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_settled_to_write(arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::add_total_settled(arg1, v8);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_writes_settled(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg2), v4, v5, 0, v8);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_revenue_state_record<T0, T1>(arg1);
        arg3
    }

    public fun sync_dapp_fee<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>());
        let (v0, v1) = get_effective_fees(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_base_fee_per_write(arg1, v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_bytes_fee_per_byte(arg1, v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::emit_fee_state_record<T0>(arg1);
    }

    public fun sync_user_write_limit<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_max_write_limit(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_write_limit(arg1, v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_user_write_limit_synced(v0, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1), v1);
    }

    public fun take_fungible_record<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x2::tx_context::sender(arg8) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1));
        if (0x1::option::is_some<u64>(&arg7)) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x2::tx_context::epoch_timestamp_ms(arg8) < *0x1::option::borrow<u64>(&arg7));
        };
        let v1 = 0x2::bcs::new(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_user_field<T0>(arg1, arg3, arg4));
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = arg5 > 0 && arg5 <= v2;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::insufficient_balance(v3);
        let v4 = v2 - arg5;
        if (v4 == 0) {
            let v5 = 0x1::vector::empty<vector<u8>>();
            0x1::vector::push_back<vector<u8>>(&mut v5, arg4);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::delete_user_record<T0>(arg1, arg3, v5);
        } else {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_user_field<T0>(arg1, arg3, arg4, 0x2::bcs::to_bytes<u64>(&v4));
        };
        let v6 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v6, 0x2::bcs::to_bytes<u64>(&arg5));
        let v7 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1);
        let v8 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v8, arg4);
        let v9 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_listing<T1>(v6, arg2, arg3, v8, v7, arg6, arg7, v0, true, arg8);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_listing<T1>(v9);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_item_listed(v0, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&v9)), v7, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_type<T1>(&v9), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&v9), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&v9), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&v9), arg6, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T1>(), true, arg7);
    }

    public fun take_record<T0: copy + drop, T1>(arg0: T0, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::UserStorage, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::user_storage_dapp_key(arg1) == v0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x2::tx_context::sender(arg7) == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1));
        if (0x1::option::is_some<u64>(&arg6)) {
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::scene_expired(0x2::tx_context::epoch_timestamp_ms(arg7) < *0x1::option::borrow<u64>(&arg6));
        };
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg4)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_user_field<T0>(arg1, arg3, *0x1::vector::borrow<vector<u8>>(&arg4, v2)));
            v2 = v2 + 1;
        };
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::delete_user_record<T0>(arg1, arg3, arg4);
        let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::canonical_owner(arg1);
        let v4 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::new_listing<T1>(v1, arg2, arg3, arg4, v3, arg5, arg6, v0, false, arg7);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::share_listing<T1>(v4);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_item_listed(v0, 0x2::object::uid_to_address(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_id<T1>(&v4)), v3, *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_type<T1>(&v4), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_key<T1>(&v4), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_field_names<T1>(&v4), *0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::listing_record_data<T1>(&v4), arg5, 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T1>(), false, arg6);
    }

    public fun update_default_free_credit(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u256, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg3));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_default_free_credit(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0), arg1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_default_free_credit_updated(arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun update_default_revenue_share(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::revenue_share_exceeds_max(arg1 <= 10000);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_default_write_fee_dapp_share_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0), arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_default_revenue_share_updated(arg1);
    }

    public fun update_framework_fee(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u256, arg2: u256, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_fee_config_mut(arg0);
        let v2 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::fee_effective_at_ms(v1);
        if (v2 > 0 && v0 >= v2) {
            let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_base_fee(v1);
            let v4 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::pending_bytes_fee(v1);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_base_fee_per_write(v1, v3);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_bytes_fee_per_byte(v1, v4);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::push_fee_history(v1, v3, v4, v2);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_base_fee(v1, 0);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_bytes_fee(v1, 0);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_fee_effective_at_ms(v1, 0);
            0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_fee_updated(v3, v4, v2);
        };
        if (arg1 == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::base_fee_per_write(v1) && arg2 == 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::bytes_fee_per_byte(v1)) {
            return
        };
        let v5 = v0 + 172800000;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_base_fee(v1, arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_pending_bytes_fee(v1, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_fee_effective_at_ms(v1, v5);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_fee_update_scheduled(arg1, arg2, v5);
    }

    public fun update_marketplace_dapp_share(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::marketplace_fee_exceeds_max(arg1 <= 10000);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_marketplace_dapp_share_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0), arg1);
    }

    public fun update_marketplace_fee(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::framework_admin(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config(arg0)) == 0x2::tx_context::sender(arg2));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::marketplace_fee_exceeds_max(arg1 <= 10000);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_marketplace_fee_bps(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::get_config_mut(arg0), arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_marketplace_fee_updated(arg1);
    }

    public fun upgrade_dapp<T0: copy + drop>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: address, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_package_id<T0>();
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_package_ids(arg1);
        let v2 = 0x1::vector::contains<address>(&v1, &v0) || v0 == arg2;
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(v2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_permission(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg1) == 0x2::tx_context::sender(arg4));
        let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_package_ids(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_package_id(!0x1::vector::contains<address>(&v3, &arg2));
        0x1::vector::push_back<address>(&mut v3, arg2);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::invalid_version(arg3 > 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_version(arg1));
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_package_ids(arg1, v3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::set_dapp_version(arg1, arg3);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_dapp_upgraded(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1), arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun withdraw_dapp_revenue<T0: copy + drop, T1>(arg0: &0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assert_framework_version(arg0);
        let v0 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::type_info::get_type_name_string<T0>();
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::dapp_key_mismatch(0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_storage_dapp_key(arg1) == v0);
        let v1 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::take_dapp_revenue<T1>(arg1);
        let v2 = 0x2::balance::value<T1>(&v1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::error::no_revenue_to_withdraw(v2 > 0);
        let v3 = 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::dapp_admin(arg1);
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dubhe_events::emit_dapp_revenue_withdrawn(v0, v3, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg2), v3);
    }

    // decompiled from Move bytecode v6
}

