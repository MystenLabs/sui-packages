module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::milestone {
    struct Milestone has key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        amount: u64,
        completed: bool,
        target_date: u64,
        description: vector<u8>,
    }

    struct MilestoneCap has store, key {
        id: 0x2::object::UID,
        milestone_id: 0x2::object::ID,
    }

    public entry fun create_and_transfer_milestone(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_milestone(arg0, arg1, arg2, arg3, arg5);
        0x2::transfer::transfer<Milestone>(v0, arg4);
        0x2::transfer::transfer<MilestoneCap>(v1, arg4);
    }

    public fun create_milestone(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : (Milestone, MilestoneCap) {
        assert!(arg1 > 0, 30);
        let v0 = Milestone{
            id          : 0x2::object::new(arg4),
            campaign_id : arg0,
            amount      : arg1,
            completed   : false,
            target_date : arg2,
            description : arg3,
        };
        let v1 = MilestoneCap{
            id           : 0x2::object::new(arg4),
            milestone_id : 0x2::object::id<Milestone>(&v0),
        };
        (v0, v1)
    }

    public fun get_amount(arg0: &Milestone) : u64 {
        arg0.amount
    }

    public fun get_campaign_id(arg0: &Milestone) : 0x2::object::ID {
        arg0.campaign_id
    }

    public fun is_completed(arg0: &Milestone) : bool {
        arg0.completed
    }

    public fun mark_completed(arg0: &mut Milestone, arg1: &MilestoneCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Milestone>(arg0) == arg1.milestone_id, 31);
        assert!(!arg0.completed, 32);
        arg0.completed = true;
    }

    public fun transfer_cap(arg0: MilestoneCap, arg1: address) {
        0x2::transfer::transfer<MilestoneCap>(arg0, arg1);
    }

    public fun transfer_to_creator(arg0: Milestone, arg1: address) {
        0x2::transfer::transfer<Milestone>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

