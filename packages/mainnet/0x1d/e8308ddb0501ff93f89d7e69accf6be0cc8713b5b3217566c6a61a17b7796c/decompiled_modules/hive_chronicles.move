module 0x1de8308ddb0501ff93f89d7e69accf6be0cc8713b5b3217566c6a61a17b7796c::hive_chronicles {
    struct HiveChroniclesAccess has key {
        id: 0x2::object::UID,
        enter_hive_cap: 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::EnterHiveCap,
        hive_chronicle_dof_cap: 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::ProfileDofOwnershipCapability,
    }

    struct HiveChronicles has store, key {
        id: 0x2::object::UID,
        chronicle_logs: 0x2::linked_table::LinkedTable<u64, ChronicleLog>,
        total_logs: u64,
    }

    struct ChronicleLog has store {
        timestamp: u64,
        asset_id: 0x1::option::Option<u64>,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        visual_url: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct NewChronicleLog has copy, drop {
        username: 0x1::string::String,
        log_index: u64,
        timestamp: u64,
        asset_id: 0x1::option::Option<u64>,
        move_type: 0x1::string::String,
        user_log: 0x1::string::String,
        visual_url: 0x1::option::Option<0x1::string::String>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_hive_chronicles(arg0: &0x2::clock::Clock, arg1: 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::EnterHiveCap, arg2: 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::ProfileDofOwnershipCapability, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveChroniclesAccess{
            id                     : 0x2::object::new(arg3),
            enter_hive_cap         : arg1,
            hive_chronicle_dof_cap : arg2,
        };
        0x2::transfer::share_object<HiveChroniclesAccess>(v0);
    }

    public entry fun kraft_hive_profile(arg0: &HiveChroniclesAccess, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2ba6b97fc5c4310f5dfad5ae717ead306764665fe6d7cac9ff2de8cbf6afff8e::hsui_vault::HSuiVault, arg4: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfileMappingStore, arg5: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveManager, arg6: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HSuiDisperser<0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = kraft_new_hive_chronicle(arg13);
        let v1 = &mut v0;
        make_new_chronicle_log(0x2::clock::timestamp_ms(arg1), arg8, v1, 0x1::option::none<u64>(), 0x1::string::utf8(b"[DegenHive - Installation Update]"), 0x1::string::utf8(b"Welcome to DegenHive! Your journey through new dimensions in the DegenHive cosmos is about to expand. Stay connected."), 0x1::option::none<0x1::string::String>(), arg13);
        0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::kraft_hive_profile_and_return_sui<HiveChronicles>(&arg0.hive_chronicle_dof_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg13), 0x2::tx_context::sender(arg13), arg13);
    }

    fun kraft_new_hive_chronicle(arg0: &mut 0x2::tx_context::TxContext) : HiveChronicles {
        HiveChronicles{
            id             : 0x2::object::new(arg0),
            chronicle_logs : 0x2::linked_table::new<u64, ChronicleLog>(arg0),
            total_logs     : 0,
        }
    }

    fun make_new_chronicle_log(arg0: u64, arg1: 0x1::string::String, arg2: &mut HiveChronicles, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg5) < 180, 9746);
        let v0 = arg2.total_logs;
        let v1 = ChronicleLog{
            timestamp  : arg0,
            asset_id   : arg3,
            move_type  : arg4,
            user_log   : arg5,
            visual_url : arg6,
            likes      : 0x2::linked_table::new<address, bool>(arg7),
        };
        0x2::linked_table::push_back<u64, ChronicleLog>(&mut arg2.chronicle_logs, v0, v1);
        arg2.total_logs = arg2.total_logs + 1;
        let v2 = NewChronicleLog{
            username   : arg1,
            log_index  : v0,
            timestamp  : arg0,
            asset_id   : arg3,
            move_type  : arg4,
            user_log   : arg5,
            visual_url : arg6,
        };
        0x2::event::emit<NewChronicleLog>(v2);
    }

    // decompiled from Move bytecode v6
}

