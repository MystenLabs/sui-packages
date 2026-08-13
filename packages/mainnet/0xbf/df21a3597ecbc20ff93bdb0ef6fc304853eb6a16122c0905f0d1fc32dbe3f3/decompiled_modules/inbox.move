module 0xbfdf21a3597ecbc20ff93bdb0ef6fc304853eb6a16122c0905f0d1fc32dbe3f3::inbox {
    struct Registry has key {
        id: 0x2::object::UID,
    }

    struct Inbox has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Swept<phantom T0> has copy, drop {
        inbox: address,
        owner: address,
        amount: u64,
    }

    struct Rescued<phantom T0> has copy, drop {
        inbox: address,
        owner: address,
        amount: u64,
    }

    fun forward<T0>(arg0: &mut Inbox, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = arg0.owner;
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        0x2::coin::send_funds<T0>(v1, v0);
        let v2 = Swept<T0>{
            inbox  : 0x2::object::uid_to_address(&arg0.id),
            owner  : v0,
            amount : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<Swept<T0>>(v2);
    }

    public fun inbox_address(arg0: &Registry, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_claimed(arg0: &Registry, arg1: address) : bool {
        0x2::derived_object::exists<address>(&arg0.id, arg1)
    }

    public fun owner(arg0: &Inbox) : address {
        arg0.owner
    }

    fun rescue<T0>(arg0: &mut Inbox, arg1: u64) {
        let v0 = arg0.owner;
        let v1 = 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1));
        0x2::balance::send_funds<T0>(v1, v0);
        let v2 = Rescued<T0>{
            inbox  : 0x2::object::uid_to_address(&arg0.id),
            owner  : v0,
            amount : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<Rescued<T0>>(v2);
    }

    public fun rescue_funds<T0>(arg0: &mut Inbox, arg1: u64) {
        rescue<T0>(arg0, arg1);
    }

    public fun rescue_funds_first<T0>(arg0: &mut Registry, arg1: address, arg2: u64) {
        let v0 = Inbox{
            id    : 0x2::derived_object::claim<address>(&mut arg0.id, arg1),
            owner : arg1,
        };
        let v1 = &mut v0;
        rescue<T0>(v1, arg2);
        0x2::transfer::share_object<Inbox>(v0);
    }

    public fun sweep<T0>(arg0: &mut Inbox, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        forward<T0>(arg0, arg1);
    }

    public fun sweep_first<T0>(arg0: &mut Registry, arg1: address, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = Inbox{
            id    : 0x2::derived_object::claim<address>(&mut arg0.id, arg1),
            owner : arg1,
        };
        let v1 = &mut v0;
        forward<T0>(v1, arg2);
        0x2::transfer::share_object<Inbox>(v0);
    }

    // decompiled from Move bytecode v7
}

