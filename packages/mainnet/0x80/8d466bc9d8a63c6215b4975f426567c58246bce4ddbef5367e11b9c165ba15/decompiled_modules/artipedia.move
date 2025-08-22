module 0xb7c36a747d6fdd6b59ab0354cea52a31df078c242242465a867481b6f4509498::artipedia {
    struct ARTIPEDIA has drop {
        dummy_field: bool,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
        treasury_cap: 0x2::coin::TreasuryCap<ARTIPEDIA>,
    }

    struct Approval has store, key {
        id: 0x2::object::UID,
        recipient: address,
        amount: u64,
    }

    struct InitEvent has copy, drop {
        admin: address,
    }

    struct AdminAddedEvent has copy, drop {
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop {
        admin: address,
    }

    struct ExchangeApproved has copy, drop {
        admin: address,
        recipient: address,
        amount: u64,
    }

    public fun total_supply(arg0: &AdminRegistry) : u64 {
        0x2::coin::total_supply<ARTIPEDIA>(&arg0.treasury_cap)
    }

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
        let v1 = AdminAddedEvent{admin: arg1};
        0x2::event::emit<AdminAddedEvent>(v1);
    }

    public entry fun approve_exchange(arg0: &AdminRegistry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_admin(arg0, v0), 1);
        let v1 = Approval{
            id        : 0x2::object::new(arg3),
            recipient : arg1,
            amount    : arg2,
        };
        let v2 = ExchangeApproved{
            admin     : v0,
            recipient : arg1,
            amount    : arg2,
        };
        0x2::event::emit<ExchangeApproved>(v2);
        0x2::transfer::public_transfer<Approval>(v1, arg1);
    }

    public entry fun exchange_points(arg0: &mut AdminRegistry, arg1: Approval, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.recipient, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTIPEDIA>>(0x2::coin::mint<ARTIPEDIA>(&mut arg0.treasury_cap, arg1.amount, arg2), v0);
        let Approval {
            id        : v1,
            recipient : _,
            amount    : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public entry fun incinerate(arg0: &mut AdminRegistry, arg1: 0x2::coin::Coin<ARTIPEDIA>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg2);
        0x2::coin::burn<ARTIPEDIA>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: ARTIPEDIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTIPEDIA>(arg0, 9, b"ARTPIA", b"ARTIPEDIA", b"ARTIPEDIA token for exchanging points", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bl5t74gddm6pwignkw4qvn4qbiq6cwpe47stk2yzrcm2egpd7egq.arweave.net/Cvs_8MMbPPsgzVW5CreQCiHhWeTn5TVrGYiZohnj-Q0")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v3, v2);
        let v4 = AdminRegistry{
            id           : 0x2::object::new(arg1),
            admins       : v3,
            treasury_cap : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTIPEDIA>>(v1);
        0x2::transfer::share_object<AdminRegistry>(v4);
        let v5 = InitEvent{admin: v2};
        0x2::event::emit<InitEvent>(v5);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
        let v1 = AdminRemovedEvent{admin: arg1};
        0x2::event::emit<AdminRemovedEvent>(v1);
    }

    public entry fun stack_incinerate(arg0: &mut AdminRegistry, arg1: vector<0x2::coin::Coin<ARTIPEDIA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<ARTIPEDIA>>(&mut arg1);
        while (!0x1::vector::is_empty<0x2::coin::Coin<ARTIPEDIA>>(&arg1)) {
            0x2::coin::join<ARTIPEDIA>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<ARTIPEDIA>>(&mut arg1));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<ARTIPEDIA>>(arg1);
        assert!(0x2::coin::value<ARTIPEDIA>(&v0) >= arg2, 3);
        0x2::coin::burn<ARTIPEDIA>(&mut arg0.treasury_cap, 0x2::coin::split<ARTIPEDIA>(&mut v0, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTIPEDIA>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

