module 0xad2d116d9aa4db57484007f5e20242ff206530b8d763693a276ae36b397c4786::detaskmv {
    struct DetaskAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BagCountCap has store, key {
        id: 0x2::object::UID,
        count: u64,
        fee: u64,
        bagstatus: 0x2::table::Table<u64, BagStatus>,
        bagindex: 0x2::table::Table<0x1::string::String, u64>,
        namelist: vector<0x1::string::String>,
    }

    struct BagStatus has store {
        bagname: 0x1::string::String,
        bagtypename: 0x1::string::String,
        bagstatus: u64,
    }

    struct DetaskManagerCap has store, key {
        id: 0x2::object::UID,
        count: u64,
        fee: u64,
        fee2: u64,
        tbtask: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct Detask has store, key {
        id: 0x2::object::UID,
        nid: 0x2::object::ID,
        deName: 0x1::string::String,
        inscription: 0x1::string::String,
        describe: 0x1::string::String,
        email: 0x1::string::String,
        ext: 0x1::string::String,
        img: 0x1::string::String,
        reward: u64,
        tst: u64,
        tcount: u64,
        left_tcount: u64,
        creator: address,
        taker_addresses: vector<address>,
        taker_list: 0x2::table::Table<address, ListingLog>,
        ttype: u64,
        baglist: 0x2::bag::Bag,
        mslist: vector<0x2::object::ID>,
        st_timestamp_ms: u64,
        ed_timestamp_ms: u64,
    }

    struct DetaskCreatorCap has store, key {
        id: 0x2::object::UID,
        taskid: 0x2::object::ID,
    }

    struct ListingLog has store, key {
        id: 0x2::object::UID,
        taskid: 0x2::object::ID,
        user: address,
        tst: u64,
        logs: 0x1::string::String,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        taskid: 0x2::object::ID,
        owner: address,
    }

    struct UserTask has store, key {
        id: 0x2::object::UID,
        taskid: 0x2::object::ID,
        user: address,
        inscription: 0x1::string::String,
        tst: u64,
    }

    struct NewDetask has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        tcount: u64,
        task_type: u64,
    }

    struct NewDetaskExt has copy, drop {
        id: 0x2::object::ID,
        task_type: u64,
    }

    struct NewTaketask has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        tcount: u64,
        task_type: u64,
    }

    struct NewBagTypeEv has copy, drop {
        id: 0x2::object::ID,
        bagname: 0x1::string::String,
        bagtypename: 0x1::string::String,
        tcount: u64,
    }

    struct NewBagCountCapEv has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewDetaskManagerCapEv has copy, drop {
        id: 0x2::object::ID,
    }

    struct DETASKMV has drop {
        dummy_field: bool,
    }

    public entry fun backtoSender<T0: store + key>(arg0: 0x2::object::ID, arg1: &DetaskCreatorCap, arg2: &BagCountCap, arg3: &mut Detask, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg2.bagindex, 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0))), 4006);
        assert!(arg1.taskid == arg3.nid, 4007);
        let v1 = delist<T0>(arg3, arg0, arg4);
        0x2::transfer::public_transfer<T0>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun changeDetask(arg0: &DetaskAdminCap, arg1: &mut Detask, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.tst = arg2;
    }

    public entry fun changeUsertask(arg0: &DetaskAdminCap, arg1: &mut UserTask, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.tst = arg2;
    }

    public entry fun createtask(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut DetaskManagerCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 100000000, 4000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 100000000), arg13), @0xd73a6dc9ff5222aed93d45049767837030c74cba9835d8796c7acd311c12e0e2);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2::object::new(arg13);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = NewDetask{
            id        : v2,
            sender    : v0,
            tcount    : arg9,
            task_type : arg12,
        };
        0x2::event::emit<NewDetask>(v3);
        let v4 = Detask{
            id              : v1,
            nid             : v2,
            deName          : arg2,
            inscription     : arg3,
            describe        : arg4,
            email           : arg5,
            ext             : arg6,
            img             : arg7,
            reward          : arg8,
            tst             : 1,
            tcount          : arg9,
            left_tcount     : arg9,
            creator         : v0,
            taker_addresses : 0x1::vector::empty<address>(),
            taker_list      : 0x2::table::new<address, ListingLog>(arg13),
            ttype           : arg12,
            baglist         : 0x2::bag::new(arg13),
            mslist          : 0x1::vector::empty<0x2::object::ID>(),
            st_timestamp_ms : arg10,
            ed_timestamp_ms : arg11,
        };
        0x2::transfer::share_object<Detask>(v4);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.tbtask, arg1.count, v2);
        arg1.count = arg1.count + 1;
        let v5 = DetaskCreatorCap{
            id     : 0x2::object::new(arg13),
            taskid : v2,
        };
        0x2::transfer::transfer<DetaskCreatorCap>(v5, v0);
    }

    fun delist<T0: store + key>(arg0: &mut Detask, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id     : v0,
            taskid : _,
            owner  : v2,
        } = 0x2::bag::remove<0x2::object::ID, Listing>(&mut arg0.baglist, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 4008);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    fun init(arg0: DETASKMV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DetaskAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DetaskAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::object::new(arg1);
        let v2 = BagCountCap{
            id        : v1,
            count     : 0,
            fee       : 100000000,
            bagstatus : 0x2::table::new<u64, BagStatus>(arg1),
            bagindex  : 0x2::table::new<0x1::string::String, u64>(arg1),
            namelist  : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::public_share_object<BagCountCap>(v2);
        let v3 = NewBagCountCapEv{id: 0x2::object::uid_to_inner(&v1)};
        0x2::event::emit<NewBagCountCapEv>(v3);
        let v4 = 0x2::object::new(arg1);
        let v5 = DetaskManagerCap{
            id     : v4,
            count  : 0,
            fee    : 100000000,
            fee2   : 30000000,
            tbtask : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        0x2::transfer::public_share_object<DetaskManagerCap>(v5);
        let v6 = NewDetaskManagerCapEv{id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<NewDetaskManagerCapEv>(v6);
    }

    public entry fun putintobag<T0: store + key>(arg0: T0, arg1: &BagCountCap, arg2: &DetaskCreatorCap, arg3: &mut Detask, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg1.bagindex, 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0))), 4006);
        assert!(arg2.taskid == arg3.nid, 4007);
        let v1 = Listing{
            id     : 0x2::object::new(arg4),
            taskid : arg3.nid,
            owner  : 0x2::tx_context::sender(arg4),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v1.id, true, arg0);
        0x2::bag::add<0x2::object::ID, Listing>(&mut arg3.baglist, 0x2::object::id<T0>(&arg0), v1);
    }

    public entry fun registerBagtype(arg0: &DetaskAdminCap, arg1: &mut BagCountCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg1.bagindex, arg3) == false, 4005);
        0x2::table::add<0x1::string::String, u64>(&mut arg1.bagindex, arg3, arg1.count);
        let v0 = BagStatus{
            bagname     : arg2,
            bagtypename : arg3,
            bagstatus   : arg4,
        };
        0x2::table::add<u64, BagStatus>(&mut arg1.bagstatus, arg1.count, v0);
        let v1 = NewBagTypeEv{
            id          : 0x2::object::uid_to_inner(&arg1.id),
            bagname     : arg2,
            bagtypename : arg3,
            tcount      : arg1.count,
        };
        0x2::event::emit<NewBagTypeEv>(v1);
        arg1.count = arg1.count + 1;
    }

    public entry fun sendRewardtoTaker(arg0: &DetaskCreatorCap, arg1: &mut Detask, arg2: address, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg1.reward, 4000);
        assert!(0x2::table::contains<address, ListingLog>(&arg1.taker_list, arg2), 4009);
        let v0 = 0x2::table::borrow_mut<address, ListingLog>(&mut arg1.taker_list, arg2);
        assert!(v0.tst == 1, 4003);
        assert!(v0.taskid == arg0.taskid, 4004);
        v0.tst = 4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg1.reward), arg4), arg2);
    }

    public entry fun sendtouser<T0: store + key>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: &DetaskCreatorCap, arg3: &BagCountCap, arg4: &mut Detask, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg3.bagindex, 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v0))), 4006);
        assert!(arg2.taskid == arg4.nid, 4007);
        assert!(0x2::table::contains<address, ListingLog>(&arg4.taker_list, arg5), 4009);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 30000000, 4000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 30000000), arg6), @0xd73a6dc9ff5222aed93d45049767837030c74cba9835d8796c7acd311c12e0e2);
        let v1 = delist<T0>(arg4, arg1, arg6);
        0x2::transfer::public_transfer<T0>(v1, arg5);
        0x2::table::borrow_mut<address, ListingLog>(&mut arg4.taker_list, arg5).tst = 4;
    }

    public entry fun usertaketask(arg0: &mut Detask, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.taker_addresses, &v0), 4002);
        assert!(arg0.left_tcount > 0, 4001);
        arg0.left_tcount = arg0.left_tcount - 1;
        0x1::vector::push_back<address>(&mut arg0.taker_addresses, v0);
        let v1 = ListingLog{
            id     : 0x2::object::new(arg1),
            taskid : arg0.nid,
            user   : v0,
            tst    : 1,
            logs   : arg0.inscription,
        };
        0x2::table::add<address, ListingLog>(&mut arg0.taker_list, v0, v1);
    }

    // decompiled from Move bytecode v6
}

