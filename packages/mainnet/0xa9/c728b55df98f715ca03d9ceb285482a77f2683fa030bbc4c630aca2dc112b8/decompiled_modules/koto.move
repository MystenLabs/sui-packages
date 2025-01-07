module 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::koto {
    struct Koto has drop {
        dummy_field: bool,
    }

    struct Transfer has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<Koto>,
        to: address,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        banned: vector<address>,
    }

    struct KotoTreasuryCap has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<Koto>,
    }

    fun borrow(arg0: &0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>) : &0x2::balance::Balance<Koto> {
        let v0 = Koto{dummy_field: false};
        0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::borrow<Koto>(v0, arg0)
    }

    fun borrow_mut(arg0: &mut 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>) : &mut 0x2::balance::Balance<Koto> {
        let v0 = Koto{dummy_field: false};
        0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::borrow_mut<Koto>(v0, arg0)
    }

    public entry fun transfer(arg0: &Registry, arg1: &mut 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::creator<Koto>(arg1) == v0, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &arg3) == false, 2);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v0) == false, 2);
        let v1 = Transfer{
            id      : 0x2::object::new(arg4),
            balance : 0x2::balance::split<Koto>(borrow_mut(arg1), arg2),
            to      : arg3,
        };
        0x2::transfer::transfer<Transfer>(v1, arg3);
    }

    public entry fun accept_transfer(arg0: &Registry, arg1: &mut 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>, arg2: Transfer) {
        let Transfer {
            id      : v0,
            balance : v1,
            to      : v2,
        } = arg2;
        let v3 = v2;
        assert!(0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::creator<Koto>(arg1) == v3, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v3) == false, 2);
        0x2::balance::join<Koto>(borrow_mut(arg1), v1);
        0x2::object::delete(v0);
    }

    public entry fun ban(arg0: &KotoTreasuryCap, arg1: &mut Registry, arg2: address) {
        0x1::vector::push_back<address>(&mut arg1.banned, arg2);
    }

    public fun banned(arg0: &Registry) : &vector<address> {
        &arg0.banned
    }

    public entry fun burn(arg0: &mut KotoTreasuryCap, arg1: &mut 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>, arg2: u64) {
        0x2::balance::decrease_supply<Koto>(&mut arg0.supply, 0x2::balance::split<Koto>(borrow_mut(arg1), arg2));
    }

    public entry fun create(arg0: &KotoTreasuryCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>>(zero(arg1, arg2), arg1);
    }

    fun from_balance(arg0: 0x2::balance::Balance<Koto>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto> {
        let v0 = Koto{dummy_field: false};
        0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::from_balance<Koto>(v0, arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Koto{dummy_field: false};
        let v2 = KotoTreasuryCap{
            id     : 0x2::object::new(arg0),
            supply : 0x2::balance::create_supply<Koto>(v1),
        };
        let v3 = zero(v0, arg0);
        0x2::transfer::public_transfer<0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>>(v3, v0);
        0x2::transfer::public_transfer<KotoTreasuryCap>(v2, v0);
        let v4 = Registry{
            id     : 0x2::object::new(arg0),
            banned : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Registry>(v4);
    }

    fun into_balance(arg0: 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>) : 0x2::balance::Balance<Koto> {
        let v0 = Koto{dummy_field: false};
        0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::into_balance<Koto>(v0, arg0)
    }

    public entry fun mint(arg0: &mut KotoTreasuryCap, arg1: &mut 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto>, arg2: u64) {
        0x2::balance::join<Koto>(borrow_mut(arg1), 0x2::balance::increase_supply<Koto>(&mut arg0.supply, arg2));
    }

    fun zero(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::RegulatedCoin<Koto> {
        let v0 = Koto{dummy_field: false};
        0xa9c728b55df98f715ca03d9ceb285482a77f2683fa030bbc4c630aca2dc112b8::regulated_coin::zero<Koto>(v0, arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

