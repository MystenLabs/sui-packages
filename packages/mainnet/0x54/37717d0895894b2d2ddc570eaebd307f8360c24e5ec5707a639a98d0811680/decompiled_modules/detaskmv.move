module 0x5437717d0895894b2d2ddc570eaebd307f8360c24e5ec5707a639a98d0811680::detaskmv {
    struct DetaskAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Detask has store, key {
        id: 0x2::object::UID,
        nid: 0x2::object::ID,
        deName: 0x1::string::String,
        inscription: 0x1::string::String,
        describe: 0x1::string::String,
        email: 0x1::string::String,
        ext: 0x1::string::String,
        reward: u64,
        tst: u64,
        tcount: u64,
        left_tcount: u64,
        creator: address,
        taker_addresses: vector<address>,
        st_timestamp_ms: u64,
        ed_timestamp_ms: u64,
    }

    struct DetaskCreatorCap has store, key {
        id: 0x2::object::UID,
        taskid: 0x2::object::ID,
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

    struct NewTaketask has copy, drop {
        id: 0x2::object::ID,
        sender: address,
        tcount: u64,
        task_type: u64,
    }

    struct DETASKMV has drop {
        dummy_field: bool,
    }

    public entry fun changeDetask(arg0: &DetaskAdminCap, arg1: &mut Detask, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.tst = arg2;
    }

    public entry fun changeUserTask(arg0: &DetaskAdminCap, arg1: &mut UserTask, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.tst = arg2;
    }

    public entry fun createtask(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 100000000, 4000);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 100000000), arg10), @0xd73a6dc9ff5222aed93d45049767837030c74cba9835d8796c7acd311c12e0e2);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = NewDetask{
            id        : v2,
            sender    : v0,
            tcount    : arg7,
            task_type : 1,
        };
        0x2::event::emit<NewDetask>(v3);
        let v4 = Detask{
            id              : v1,
            nid             : v2,
            deName          : arg1,
            inscription     : arg2,
            describe        : arg3,
            email           : arg4,
            ext             : arg5,
            reward          : arg6,
            tst             : 1,
            tcount          : arg7,
            left_tcount     : arg7,
            creator         : v0,
            taker_addresses : 0x1::vector::empty<address>(),
            st_timestamp_ms : arg8,
            ed_timestamp_ms : arg9,
        };
        0x2::transfer::share_object<Detask>(v4);
        let v5 = DetaskCreatorCap{
            id     : 0x2::object::new(arg10),
            taskid : v2,
        };
        0x2::transfer::transfer<DetaskCreatorCap>(v5, v0);
    }

    fun init(arg0: DETASKMV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DetaskAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DetaskAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun sendRewardtoTaker(arg0: &DetaskCreatorCap, arg1: &mut Detask, arg2: &mut UserTask, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg1.reward, 4000);
        assert!(arg2.tst == 1, 4003);
        assert!(arg2.taskid == arg0.taskid, 4004);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), arg1.reward), arg4), arg2.user);
        arg2.tst = 2;
    }

    public entry fun usertaketask(arg0: &mut Detask, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.taker_addresses, &v0), 4002);
        assert!(arg0.left_tcount > 0, 4001);
        let v1 = 0x2::object::new(arg1);
        arg0.left_tcount = arg0.left_tcount - 1;
        let v2 = NewTaketask{
            id        : 0x2::object::uid_to_inner(&v1),
            sender    : v0,
            tcount    : arg0.left_tcount,
            task_type : 1,
        };
        0x2::event::emit<NewTaketask>(v2);
        0x1::vector::push_back<address>(&mut arg0.taker_addresses, v0);
        let v3 = UserTask{
            id          : v1,
            taskid      : arg0.nid,
            user        : v0,
            inscription : arg0.inscription,
            tst         : 1,
        };
        0x2::transfer::share_object<UserTask>(v3);
    }

    // decompiled from Move bytecode v6
}

