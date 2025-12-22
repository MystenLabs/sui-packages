module 0x13a87cd2b137dcf833624d9d6ee7c96cf553294d0dfac9c9488ffdc30b944dcb::campaign {
    struct Campaign<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        goal: u64,
        raised: u64,
        deadline_ms: u64,
        min_contribution: 0x1::option::Option<u64>,
        status: u8,
        total_contributors: u64,
        total_contributions: u64,
        vault: 0x2::balance::Balance<T0>,
        metadata_ref: vector<u8>,
        nft_image_url: vector<u8>,
        funds_withdrawn: bool,
    }

    public fun new<T0>(arg0: address, arg1: u64, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Campaign<T0> {
        Campaign<T0>{
            id                  : 0x2::object::new(arg6),
            creator             : arg0,
            goal                : arg1,
            raised              : 0,
            deadline_ms         : arg2,
            min_contribution    : arg3,
            status              : 0,
            total_contributors  : 0,
            total_contributions : 0,
            vault               : 0x2::balance::zero<T0>(),
            metadata_ref        : arg4,
            nft_image_url       : arg5,
            funds_withdrawn     : false,
        }
    }

    public(friend) fun add_contribution<T0>(arg0: &mut Campaign<T0>, arg1: 0x2::balance::Balance<T0>, arg2: bool) {
        assert!(arg0.status == 0, 2);
        0x2::balance::join<T0>(&mut arg0.vault, arg1);
        arg0.raised = arg0.raised + 0x2::balance::value<T0>(&arg1);
        arg0.total_contributions = arg0.total_contributions + 1;
        if (arg2) {
            arg0.total_contributors = arg0.total_contributors + 1;
        };
    }

    public fun check_min_contribution<T0>(arg0: &Campaign<T0>, arg1: u64) {
        if (0x1::option::is_some<u64>(&arg0.min_contribution)) {
            assert!(arg1 >= *0x1::option::borrow<u64>(&arg0.min_contribution), 10);
        };
    }

    public fun creator<T0>(arg0: &Campaign<T0>) : address {
        arg0.creator
    }

    public fun deadline_ms<T0>(arg0: &Campaign<T0>) : u64 {
        arg0.deadline_ms
    }

    public(friend) fun finalize<T0>(arg0: &mut Campaign<T0>, arg1: u64) {
        assert!(arg0.status == 0, 2);
        let v0 = arg0.raised >= arg0.goal;
        assert!(arg1 >= arg0.deadline_ms || v0, 7);
        if (v0) {
            arg0.status = 1;
        } else {
            arg0.status = 2;
        };
    }

    public fun goal<T0>(arg0: &Campaign<T0>) : u64 {
        arg0.goal
    }

    public fun id<T0>(arg0: &Campaign<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_active<T0>(arg0: &Campaign<T0>) : bool {
        arg0.status == 0
    }

    public fun is_failed<T0>(arg0: &Campaign<T0>) : bool {
        arg0.status == 2
    }

    public fun is_successful<T0>(arg0: &Campaign<T0>) : bool {
        arg0.status == 1
    }

    public fun metadata_ref<T0>(arg0: &Campaign<T0>) : vector<u8> {
        arg0.metadata_ref
    }

    public fun min_contribution<T0>(arg0: &Campaign<T0>) : 0x1::option::Option<u64> {
        arg0.min_contribution
    }

    public fun nft_image_url<T0>(arg0: &Campaign<T0>) : vector<u8> {
        arg0.nft_image_url
    }

    public(friend) fun process_refund<T0>(arg0: &mut Campaign<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.status == 2, 5);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg1, 9);
        0x2::balance::split<T0>(&mut arg0.vault, arg1)
    }

    public fun raised<T0>(arg0: &Campaign<T0>) : u64 {
        arg0.raised
    }

    public fun share<T0>(arg0: Campaign<T0>) {
        0x2::transfer::share_object<Campaign<T0>>(arg0);
    }

    public fun status<T0>(arg0: &Campaign<T0>) : u8 {
        arg0.status
    }

    public fun total_contributions<T0>(arg0: &Campaign<T0>) : u64 {
        arg0.total_contributions
    }

    public fun total_contributors<T0>(arg0: &Campaign<T0>) : u64 {
        arg0.total_contributors
    }

    public fun vault_balance<T0>(arg0: &Campaign<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public(friend) fun withdraw_funds<T0>(arg0: &mut Campaign<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        assert!(arg0.status == 1, 4);
        assert!(arg0.creator == arg1, 6);
        assert!(!arg0.funds_withdrawn, 8);
        arg0.funds_withdrawn = true;
        0x2::balance::split<T0>(&mut arg0.vault, 0x2::balance::value<T0>(&arg0.vault))
    }

    // decompiled from Move bytecode v6
}

