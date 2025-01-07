module 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::abc {
    struct Abc has drop {
        dummy_field: bool,
    }

    struct Transfer has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<Abc>,
        to: address,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        banned: vector<address>,
        swapped_amount: u64,
    }

    struct AbcTreasuryCap has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<Abc>,
    }

    fun borrow(arg0: &0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>) : &0x2::balance::Balance<Abc> {
        let v0 = Abc{dummy_field: false};
        0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::borrow<Abc>(v0, arg0)
    }

    fun borrow_mut(arg0: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>) : &mut 0x2::balance::Balance<Abc> {
        let v0 = Abc{dummy_field: false};
        0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::borrow_mut<Abc>(v0, arg0)
    }

    public entry fun take(arg0: &mut Registry, arg1: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::creator<Abc>(arg1) == v0, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v0) == false, 2);
        arg0.swapped_amount = arg0.swapped_amount + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<Abc>>(0x2::coin::take<Abc>(borrow_mut(arg1), arg2, arg3), v0);
    }

    public entry fun transfer(arg0: &Registry, arg1: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::creator<Abc>(arg1) == v0, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &arg3) == false, 2);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v0) == false, 2);
        let v1 = Transfer{
            id      : 0x2::object::new(arg4),
            balance : 0x2::balance::split<Abc>(borrow_mut(arg1), arg2),
            to      : arg3,
        };
        0x2::transfer::transfer<Transfer>(v1, arg3);
    }

    public entry fun accept_transfer(arg0: &Registry, arg1: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>, arg2: Transfer) {
        let Transfer {
            id      : v0,
            balance : v1,
            to      : v2,
        } = arg2;
        let v3 = v2;
        assert!(0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::creator<Abc>(arg1) == v3, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v3) == false, 2);
        0x2::balance::join<Abc>(borrow_mut(arg1), v1);
        0x2::object::delete(v0);
    }

    public entry fun ban(arg0: &AbcTreasuryCap, arg1: &mut Registry, arg2: address) {
        0x1::vector::push_back<address>(&mut arg1.banned, arg2);
    }

    public fun banned(arg0: &Registry) : &vector<address> {
        &arg0.banned
    }

    public entry fun burn(arg0: &mut AbcTreasuryCap, arg1: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>, arg2: u64) {
        0x2::balance::decrease_supply<Abc>(&mut arg0.supply, 0x2::balance::split<Abc>(borrow_mut(arg1), arg2));
    }

    public entry fun create(arg0: &AbcTreasuryCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>>(zero(arg1, arg2), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Abc{dummy_field: false};
        let v2 = AbcTreasuryCap{
            id     : 0x2::object::new(arg0),
            supply : 0x2::balance::create_supply<Abc>(v1),
        };
        let v3 = zero(v0, arg0);
        0x2::transfer::public_transfer<0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>>(v3, v0);
        0x2::transfer::public_transfer<AbcTreasuryCap>(v2, v0);
        let v4 = Registry{
            id             : 0x2::object::new(arg0),
            banned         : 0x1::vector::empty<address>(),
            swapped_amount : 0,
        };
        0x2::transfer::share_object<Registry>(v4);
    }

    public entry fun mint(arg0: &mut AbcTreasuryCap, arg1: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>, arg2: u64) {
        0x2::balance::join<Abc>(borrow_mut(arg1), 0x2::balance::increase_supply<Abc>(&mut arg0.supply, arg2));
    }

    public entry fun put_back(arg0: &mut Registry, arg1: &mut 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc>, arg2: 0x2::coin::Coin<Abc>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<Abc>(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::creator<Abc>(arg1) == v1, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v1) == false, 2);
        arg0.swapped_amount = arg0.swapped_amount - 0x2::balance::value<Abc>(&v0);
        0x2::balance::join<Abc>(borrow_mut(arg1), v0);
    }

    public fun swapped_amount(arg0: &Registry) : u64 {
        arg0.swapped_amount
    }

    fun zero(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::RegulatedCoin<Abc> {
        let v0 = Abc{dummy_field: false};
        0xddc59ffc9a4663b6172515d9aa9e31ccb35fd9c7429902e66a84a21619866f57::regulated_coin::zero<Abc>(v0, arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

