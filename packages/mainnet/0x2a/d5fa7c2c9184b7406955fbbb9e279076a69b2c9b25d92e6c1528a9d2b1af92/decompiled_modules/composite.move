module 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::composite {
    struct CompositeCreated has copy, drop {
        composite_id: 0x2::object::ID,
        creator_agent: 0x2::object::ID,
        name: 0x1::string::String,
        skill_count: u64,
        created_at: u64,
    }

    struct CompositeStepCompleted has copy, drop {
        composite_id: 0x2::object::ID,
        step_index: u64,
        task_id: 0x2::object::ID,
        completed_at: u64,
    }

    struct CompositeCompleted has copy, drop {
        composite_id: 0x2::object::ID,
        total_payment: u64,
        completed_at: u64,
    }

    struct CompositeCancelled has copy, drop {
        composite_id: 0x2::object::ID,
        at_step: u64,
        refund_amount: u64,
        cancelled_at: u64,
    }

    struct CompositeStep has copy, drop, store {
        skill_id: 0x2::object::ID,
        payment_amount: u64,
        priority_tier: u8,
        completed: bool,
        task_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Composite has key {
        id: 0x2::object::UID,
        creator_agent: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        steps: vector<CompositeStep>,
        current_step: u64,
        total_payment: u64,
        active: bool,
        created_at: u64,
        completed_at: 0x1::option::Option<u64>,
    }

    public fun id(arg0: &Composite) : 0x2::object::ID {
        0x2::object::id<Composite>(arg0)
    }

    public fun add_step(arg0: &mut Composite, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: 0x2::object::ID, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg5), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.creator_agent, 1);
        assert!(arg0.active, 2);
        assert!(arg0.current_step == 0, 2);
        let v0 = CompositeStep{
            skill_id       : arg2,
            payment_amount : arg3,
            priority_tier  : arg4,
            completed      : false,
            task_id        : 0x1::option::none<0x2::object::ID>(),
        };
        0x1::vector::push_back<CompositeStep>(&mut arg0.steps, v0);
        arg0.total_payment = arg0.total_payment + arg3;
    }

    public fun cancel(arg0: &mut Composite, arg1: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg1) == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg1) == arg0.creator_agent, 1);
        assert!(arg0.active, 2);
        arg0.active = false;
        let v0 = 0;
        let v1 = arg0.current_step;
        while (v1 < 0x1::vector::length<CompositeStep>(&arg0.steps)) {
            v0 = v0 + 0x1::vector::borrow<CompositeStep>(&arg0.steps, v1).payment_amount;
            v1 = v1 + 1;
        };
        let v2 = CompositeCancelled{
            composite_id  : 0x2::object::id<Composite>(arg0),
            at_step       : arg0.current_step,
            refund_amount : v0,
            cancelled_at  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<CompositeCancelled>(v2);
    }

    public(friend) fun complete_step(arg0: &mut Composite, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 == arg0.current_step, 2);
        assert!(arg1 < 0x1::vector::length<CompositeStep>(&arg0.steps), 2);
        let v0 = 0x1::vector::borrow_mut<CompositeStep>(&mut arg0.steps, arg1);
        v0.completed = true;
        v0.task_id = 0x1::option::some<0x2::object::ID>(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = CompositeStepCompleted{
            composite_id : 0x2::object::id<Composite>(arg0),
            step_index   : arg1,
            task_id      : arg2,
            completed_at : v1,
        };
        0x2::event::emit<CompositeStepCompleted>(v2);
        arg0.current_step = arg0.current_step + 1;
        if (arg0.current_step >= 0x1::vector::length<CompositeStep>(&arg0.steps)) {
            arg0.active = false;
            arg0.completed_at = 0x1::option::some<u64>(v1);
            let v3 = CompositeCompleted{
                composite_id  : 0x2::object::id<Composite>(arg0),
                total_payment : arg0.total_payment,
                completed_at  : v1,
            };
            0x2::event::emit<CompositeCompleted>(v3);
        };
    }

    public fun completed_at(arg0: &Composite) : 0x1::option::Option<u64> {
        arg0.completed_at
    }

    public fun create(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Composite {
        assert!(0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::owner(arg0) == 0x2::tx_context::sender(arg3), 0);
        Composite{
            id            : 0x2::object::new(arg3),
            creator_agent : 0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent>(arg0),
            name          : arg1,
            description   : arg2,
            steps         : 0x1::vector::empty<CompositeStep>(),
            current_step  : 0,
            total_payment : 0,
            active        : true,
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg3),
            completed_at  : 0x1::option::none<u64>(),
        }
    }

    public fun create_and_share(arg0: &0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::agent::Agent, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1, arg2, arg3);
        let v1 = CompositeCreated{
            composite_id  : 0x2::object::id<Composite>(&v0),
            creator_agent : v0.creator_agent,
            name          : v0.name,
            skill_count   : 0x1::vector::length<CompositeStep>(&v0.steps),
            created_at    : v0.created_at,
        };
        0x2::event::emit<CompositeCreated>(v1);
        0x2::transfer::share_object<Composite>(v0);
    }

    public fun created_at(arg0: &Composite) : u64 {
        arg0.created_at
    }

    public fun creator_agent(arg0: &Composite) : 0x2::object::ID {
        arg0.creator_agent
    }

    public fun current_step(arg0: &Composite) : u64 {
        arg0.current_step
    }

    public fun description(arg0: &Composite) : 0x1::string::String {
        arg0.description
    }

    public fun get_step(arg0: &Composite, arg1: u64) : &CompositeStep {
        0x1::vector::borrow<CompositeStep>(&arg0.steps, arg1)
    }

    public fun is_active(arg0: &Composite) : bool {
        arg0.active
    }

    public fun is_complete(arg0: &Composite) : bool {
        0x1::option::is_some<u64>(&arg0.completed_at)
    }

    public fun name(arg0: &Composite) : 0x1::string::String {
        arg0.name
    }

    public fun step_completed(arg0: &CompositeStep) : bool {
        arg0.completed
    }

    public fun step_count(arg0: &Composite) : u64 {
        0x1::vector::length<CompositeStep>(&arg0.steps)
    }

    public fun step_payment(arg0: &CompositeStep) : u64 {
        arg0.payment_amount
    }

    public fun step_priority(arg0: &CompositeStep) : u8 {
        arg0.priority_tier
    }

    public fun step_skill_id(arg0: &CompositeStep) : 0x2::object::ID {
        arg0.skill_id
    }

    public fun step_task_id(arg0: &CompositeStep) : 0x1::option::Option<0x2::object::ID> {
        arg0.task_id
    }

    public fun total_payment(arg0: &Composite) : u64 {
        arg0.total_payment
    }

    // decompiled from Move bytecode v6
}

