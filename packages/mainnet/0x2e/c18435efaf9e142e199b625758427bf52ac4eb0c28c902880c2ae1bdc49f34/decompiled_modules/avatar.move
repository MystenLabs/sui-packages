module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct Avatar<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        look: 0x1::string::String,
        glow: 0x2::balance::Balance<T0>,
        memory_ptr: 0x1::string::String,
        memory_count: u64,
        agent_epoch: u64,
    }

    struct MemoryCard has key {
        id: 0x2::object::UID,
        avatar: 0x2::object::ID,
        text: 0x1::string::String,
        private: bool,
    }

    struct JunctionHalt has key {
        id: 0x2::object::UID,
        halted: bool,
    }

    struct Junction has key {
        id: 0x2::object::UID,
        halt: 0x2::object::ID,
    }

    struct FeeConfig<phantom T0> has key {
        id: 0x2::object::UID,
        fee_on: bool,
        note_fee: u64,
        pool: 0x2::balance::Balance<T0>,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        note_count: u64,
    }

    struct Note has drop, store {
        author: 0x2::object::ID,
        text: 0x1::string::String,
        kind: u8,
        ts_ms: u64,
        retracted: bool,
    }

    struct Interaction has copy, drop {
        avatar: 0x2::object::ID,
        kind: u8,
        glow_delta: u64,
        glow_up: bool,
        memory_delta: u64,
        target: 0x1::option::Option<0x2::object::ID>,
    }

    struct FeeSet has copy, drop {
        cfg: 0x2::object::ID,
        fee_on: bool,
        note_fee: u64,
    }

    struct HaltSet has copy, drop {
        halted: bool,
    }

    fun emit<T0>(arg0: &Avatar<T0>, arg1: u8, arg2: u64, arg3: bool, arg4: u64, arg5: 0x1::option::Option<0x2::object::ID>) {
        let v0 = Interaction{
            avatar       : 0x2::object::id<Avatar<T0>>(arg0),
            kind         : arg1,
            glow_delta   : arg2,
            glow_up      : arg3,
            memory_delta : arg4,
            target       : arg5,
        };
        0x2::event::emit<Interaction>(v0);
    }

    public fun add_glow<T0>(arg0: &mut Avatar<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.glow, 0x2::coin::into_balance<T0>(arg1));
        emit<T0>(arg0, 4, 0x2::coin::value<T0>(&arg1), true, 0, 0x1::option::none<0x2::object::ID>());
    }

    public fun agent_epoch<T0>(arg0: &Avatar<T0>) : u64 {
        arg0.agent_epoch
    }

    public fun assert_live(arg0: &Junction, arg1: &JunctionHalt) {
        assert!(0x2::object::id<JunctionHalt>(arg1) == arg0.halt, 7);
        assert!(!arg1.halted, 8);
    }

    public(friend) fun bump_agent_epoch<T0>(arg0: &mut Avatar<T0>) {
        arg0.agent_epoch = arg0.agent_epoch + 1;
    }

    public fun create_fee_config<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 1000000, 9);
        let v0 = FeeConfig<T0>{
            id       : 0x2::object::new(arg2),
            fee_on   : false,
            note_fee : arg1,
            pool     : 0x2::balance::zero<T0>(),
        };
        let v1 = FeeSet{
            cfg      : 0x2::object::id<FeeConfig<T0>>(&v0),
            fee_on   : false,
            note_fee : arg1,
        };
        0x2::event::emit<FeeSet>(v1);
        0x2::transfer::share_object<FeeConfig<T0>>(v0);
    }

    public fun create_listing(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing{
            id         : 0x2::object::new(arg1),
            title      : arg0,
            note_count : 0,
        };
        0x2::transfer::share_object<Listing>(v0);
    }

    public fun fee_on<T0>(arg0: &FeeConfig<T0>) : bool {
        arg0.fee_on
    }

    public fun fee_pool<T0>(arg0: &FeeConfig<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun glow<T0>(arg0: &Avatar<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.glow)
    }

    public fun halt(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &Junction, arg2: &mut JunctionHalt) {
        assert!(0x2::object::id<JunctionHalt>(arg2) == arg1.halt, 7);
        arg2.halted = true;
        let v0 = HaltSet{halted: true};
        0x2::event::emit<HaltSet>(v0);
    }

    public fun halt_id(arg0: &Junction) : 0x2::object::ID {
        arg0.halt
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<AVATAR>(arg0, arg1), @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
        let v0 = JunctionHalt{
            id     : 0x2::object::new(arg1),
            halted : true,
        };
        let v1 = Junction{
            id   : 0x2::object::new(arg1),
            halt : 0x2::object::id<JunctionHalt>(&v0),
        };
        0x2::transfer::share_object<Junction>(v1);
        0x2::transfer::share_object<JunctionHalt>(v0);
    }

    public fun is_halted(arg0: &JunctionHalt) : bool {
        arg0.halted
    }

    public fun is_private(arg0: &MemoryCard) : bool {
        arg0.private
    }

    public fun leave_note<T0>(arg0: &mut FeeConfig<T0>, arg1: &mut Listing, arg2: &mut Avatar<T0>, arg3: &Junction, arg4: &JunctionHalt, arg5: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::guard::Guard, arg6: 0x1::string::String, arg7: u8, arg8: &0x2::clock::Clock) {
        assert_live(arg3, arg4);
        assert!(0x1::string::length(&arg6) <= 280, 2);
        assert!(arg7 <= 2, 6);
        let v0 = 0x2::object::id<Avatar<T0>>(arg2);
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(&arg1.id, v0), 3);
        let v1 = 0;
        if (arg0.fee_on) {
            assert!(0x2::balance::value<T0>(&arg2.glow) >= arg0.note_fee, 1);
            let v2 = arg0.note_fee;
            v1 = v2;
            0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut arg2.glow, v2));
        };
        let v3 = Note{
            author    : v0,
            text      : arg6,
            kind      : arg7,
            ts_ms     : 0x2::clock::timestamp_ms(arg8),
            retracted : false,
        };
        0x2::dynamic_field::add<0x2::object::ID, Note>(&mut arg1.id, v0, v3);
        arg1.note_count = arg1.note_count + 1;
        arg2.memory_count = arg2.memory_count + 1;
        emit<T0>(arg2, 2, v1, false, 1, 0x1::option::some<0x2::object::ID>(0x2::object::id<Listing>(arg1)));
    }

    public fun memory_count<T0>(arg0: &Avatar<T0>) : u64 {
        arg0.memory_count
    }

    public fun mint<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Avatar<T0>{
            id           : 0x2::object::new(arg2),
            owner        : 0x2::tx_context::sender(arg2),
            name         : arg0,
            look         : arg1,
            glow         : 0x2::balance::zero<T0>(),
            memory_ptr   : 0x1::string::utf8(b""),
            memory_count : 0,
            agent_epoch  : 0,
        };
        emit<T0>(&v0, 0, 0, true, 0, 0x1::option::none<0x2::object::ID>());
        0x2::transfer::transfer<Avatar<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun note_count(arg0: &Listing) : u64 {
        arg0.note_count
    }

    public fun note_retracted<T0>(arg0: &Listing, arg1: &Avatar<T0>) : bool {
        0x2::dynamic_field::borrow<0x2::object::ID, Note>(&arg0.id, 0x2::object::id<Avatar<T0>>(arg1)).retracted
    }

    public fun owner<T0>(arg0: &Avatar<T0>) : address {
        arg0.owner
    }

    public fun retract_note<T0>(arg0: &mut Listing, arg1: &mut Avatar<T0>) {
        let v0 = 0x2::object::id<Avatar<T0>>(arg1);
        assert!(0x2::dynamic_field::exists<0x2::object::ID>(&arg0.id, v0), 4);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, Note>(&mut arg0.id, v0);
        assert!(v1.author == v0, 5);
        v1.retracted = true;
        arg1.memory_count = arg1.memory_count + 1;
        emit<T0>(arg1, 3, 0, true, 1, 0x1::option::some<0x2::object::ID>(0x2::object::id<Listing>(arg0)));
    }

    public fun set_fee<T0>(arg0: &0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin::AdminCap, arg1: &mut FeeConfig<T0>, arg2: bool, arg3: u64) {
        assert!(arg3 <= 1000000, 9);
        arg1.fee_on = arg2;
        arg1.note_fee = arg3;
        let v0 = FeeSet{
            cfg      : 0x2::object::id<FeeConfig<T0>>(arg1),
            fee_on   : arg2,
            note_fee : arg3,
        };
        0x2::event::emit<FeeSet>(v0);
    }

    public fun set_memory_ptr<T0>(arg0: &mut Avatar<T0>, arg1: 0x1::string::String) {
        arg0.memory_ptr = arg1;
    }

    public(friend) fun split_glow<T0>(arg0: &mut Avatar<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.glow, arg1)
    }

    public(friend) fun take_fee_pool<T0>(arg0: &mut FeeConfig<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.pool)
    }

    public fun take_glow<T0>(arg0: &mut Avatar<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.glow, arg1), arg2)
    }

    public fun transfer_avatar<T0>(arg0: Avatar<T0>, arg1: address, arg2: u64) : 0x2::transfer_policy::TransferRequest<Avatar<T0>> {
        let v0 = 0x2::object::id<Avatar<T0>>(&arg0);
        arg0.owner = arg1;
        arg0.agent_epoch = arg0.agent_epoch + 1;
        0x2::transfer::transfer<Avatar<T0>>(arg0, arg1);
        0x2::transfer_policy::new_request<Avatar<T0>>(v0, arg2, v0)
    }

    public fun transfer_memory(arg0: MemoryCard, arg1: address, arg2: u64) : 0x2::transfer_policy::TransferRequest<MemoryCard> {
        let v0 = 0x2::object::id<MemoryCard>(&arg0);
        0x2::transfer::transfer<MemoryCard>(arg0, arg1);
        0x2::transfer_policy::new_request<MemoryCard>(v0, arg2, v0)
    }

    public(friend) fun unhalt(arg0: &Junction, arg1: &mut JunctionHalt) {
        assert!(0x2::object::id<JunctionHalt>(arg1) == arg0.halt, 7);
        arg1.halted = false;
        let v0 = HaltSet{halted: false};
        0x2::event::emit<HaltSet>(v0);
    }

    public fun write_memory<T0>(arg0: &mut Avatar<T0>, arg1: 0x1::string::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryCard{
            id      : 0x2::object::new(arg3),
            avatar  : 0x2::object::id<Avatar<T0>>(arg0),
            text    : arg1,
            private : arg2,
        };
        arg0.memory_count = arg0.memory_count + 1;
        emit<T0>(arg0, 1, 0, true, 1, 0x1::option::some<0x2::object::ID>(0x2::object::id<MemoryCard>(&v0)));
        0x2::transfer::transfer<MemoryCard>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

