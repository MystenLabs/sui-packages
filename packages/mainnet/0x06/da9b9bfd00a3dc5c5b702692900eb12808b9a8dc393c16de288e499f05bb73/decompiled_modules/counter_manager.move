module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter_manager {
    struct CounterManager has key {
        id: 0x2::object::UID,
        counter: 0x2::borrow::Referent<0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter>,
    }

    public fun borrow_counter(arg0: &mut CounterManager) : (0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter>(&mut arg0.counter)
    }

    public fun create(arg0: 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CounterManager{
            id      : 0x2::object::new(arg1),
            counter : 0x2::borrow::new<0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter>(arg0, arg1),
        };
        0x2::transfer::share_object<CounterManager>(v0);
    }

    public fun return_counter(arg0: &mut CounterManager, arg1: 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter::Counter>(&mut arg0.counter, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

