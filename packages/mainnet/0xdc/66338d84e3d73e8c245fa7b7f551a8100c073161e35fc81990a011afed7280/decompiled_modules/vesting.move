module 0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::vesting {
    struct Vesting has key {
        id: 0x2::object::UID,
        beneficiary: address,
        label: vector<u8>,
        locked: 0x2::balance::Balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>,
        total: u64,
        released: u64,
        start_ms: u64,
        cliff_ms: u64,
        duration_ms: u64,
    }

    struct VestingCreated has copy, drop {
        vesting: 0x2::object::ID,
        beneficiary: address,
        label: vector<u8>,
        total: u64,
        start_ms: u64,
        cliff_ms: u64,
        duration_ms: u64,
    }

    struct Released has copy, drop {
        vesting: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        released_total: u64,
        remaining: u64,
    }

    public fun beneficiary(arg0: &Vesting) : address {
        arg0.beneficiary
    }

    public fun cliff_ms(arg0: &Vesting) : u64 {
        arg0.cliff_ms
    }

    public fun create(arg0: &0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::AdminCap, arg1: 0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&arg1);
        assert!(v0 > 0, 0);
        assert!(arg6 > 0, 2);
        assert!(arg5 <= arg6, 2);
        let v1 = 0x2::object::new(arg7);
        let v2 = VestingCreated{
            vesting     : 0x2::object::uid_to_inner(&v1),
            beneficiary : arg2,
            label       : arg3,
            total       : v0,
            start_ms    : arg4,
            cliff_ms    : arg5,
            duration_ms : arg6,
        };
        0x2::event::emit<VestingCreated>(v2);
        let v3 = Vesting{
            id          : v1,
            beneficiary : arg2,
            label       : arg3,
            locked      : 0x2::coin::into_balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(arg1),
            total       : v0,
            released    : 0,
            start_ms    : arg4,
            cliff_ms    : arg5,
            duration_ms : arg6,
        };
        0x2::transfer::share_object<Vesting>(v3);
    }

    public fun duration_ms(arg0: &Vesting) : u64 {
        arg0.duration_ms
    }

    public fun is_complete(arg0: &Vesting) : bool {
        arg0.released >= arg0.total
    }

    public fun label(arg0: &Vesting) : vector<u8> {
        arg0.label
    }

    public fun locked_amount(arg0: &Vesting) : u64 {
        0x2::balance::value<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&arg0.locked)
    }

    public fun releasable(arg0: &Vesting, arg1: &0x2::clock::Clock) : u64 {
        let v0 = vested_amount(arg0, arg1);
        if (v0 <= arg0.released) {
            0
        } else {
            v0 - arg0.released
        }
    }

    public fun release(arg0: &mut Vesting, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = releasable(arg0, arg1);
        assert!(v0 > 0, 1);
        arg0.released = arg0.released + v0;
        let v1 = Released{
            vesting        : 0x2::object::id<Vesting>(arg0),
            beneficiary    : arg0.beneficiary,
            amount         : v0,
            released_total : arg0.released,
            remaining      : 0x2::balance::value<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&arg0.locked),
        };
        0x2::event::emit<Released>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>>(0x2::coin::from_balance<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(0x2::balance::split<0xdc66338d84e3d73e8c245fa7b7f551a8100c073161e35fc81990a011afed7280::llama::LLAMA>(&mut arg0.locked, v0), arg2), arg0.beneficiary);
    }

    public fun released(arg0: &Vesting) : u64 {
        arg0.released
    }

    public fun start_ms(arg0: &Vesting) : u64 {
        arg0.start_ms
    }

    public fun total(arg0: &Vesting) : u64 {
        arg0.total
    }

    public fun vested_amount(arg0: &Vesting, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.start_ms) {
            return 0
        };
        let v1 = v0 - arg0.start_ms;
        if (v1 < arg0.cliff_ms) {
            return 0
        };
        if (v1 >= arg0.duration_ms) {
            return arg0.total
        };
        (((arg0.total as u128) * (v1 as u128) / (arg0.duration_ms as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

