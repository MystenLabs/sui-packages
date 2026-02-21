module 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::milestone {
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

    public fun create_milestone(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : (Milestone, MilestoneCap) {
        assert!(arg1 > 0, 1);
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
        assert!(0x2::object::id<Milestone>(arg0) == arg1.milestone_id, 2);
        assert!(!arg0.completed, 3);
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

