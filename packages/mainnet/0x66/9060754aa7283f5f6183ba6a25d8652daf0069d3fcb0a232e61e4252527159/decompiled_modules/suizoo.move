module 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::suizoo {
    struct SuiZoo has drop {
        dummy_field: bool,
    }

    struct Transfer has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<SuiZoo>,
        to: address,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        banned: vector<address>,
        swapped_amount: u64,
    }

    struct SuiZooTreasuryCap has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SuiZoo>,
    }

    fun borrow(arg0: &0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>) : &0x2::balance::Balance<SuiZoo> {
        let v0 = SuiZoo{dummy_field: false};
        0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::borrow<SuiZoo>(v0, arg0)
    }

    fun borrow_mut(arg0: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>) : &mut 0x2::balance::Balance<SuiZoo> {
        let v0 = SuiZoo{dummy_field: false};
        0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::borrow_mut<SuiZoo>(v0, arg0)
    }

    fun into_balance(arg0: 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>) : 0x2::balance::Balance<SuiZoo> {
        let v0 = SuiZoo{dummy_field: false};
        0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::into_balance<SuiZoo>(v0, arg0)
    }

    public entry fun take(arg0: &mut Registry, arg1: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::creator<SuiZoo>(arg1) == v0, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v0) == false, 2);
        arg0.swapped_amount = arg0.swapped_amount + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<SuiZoo>>(0x2::coin::take<SuiZoo>(borrow_mut(arg1), arg2, arg3), v0);
    }

    public entry fun transfer(arg0: &Registry, arg1: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::creator<SuiZoo>(arg1) == v0, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &arg3) == false, 2);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v0) == false, 2);
        let v1 = Transfer{
            id      : 0x2::object::new(arg4),
            balance : 0x2::balance::split<SuiZoo>(borrow_mut(arg1), arg2),
            to      : arg3,
        };
        0x2::transfer::transfer<Transfer>(v1, arg3);
    }

    fun from_balance(arg0: 0x2::balance::Balance<SuiZoo>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo> {
        let v0 = SuiZoo{dummy_field: false};
        0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::from_balance<SuiZoo>(v0, arg0, arg1, arg2)
    }

    fun zero(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo> {
        let v0 = SuiZoo{dummy_field: false};
        0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::zero<SuiZoo>(v0, arg0, arg1)
    }

    public entry fun accept_transfer(arg0: &Registry, arg1: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>, arg2: Transfer) {
        let Transfer {
            id      : v0,
            balance : v1,
            to      : v2,
        } = arg2;
        let v3 = v2;
        assert!(0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::creator<SuiZoo>(arg1) == v3, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v3) == false, 2);
        0x2::balance::join<SuiZoo>(borrow_mut(arg1), v1);
        0x2::object::delete(v0);
    }

    public entry fun ban(arg0: &SuiZooTreasuryCap, arg1: &mut Registry, arg2: address) {
        0x1::vector::push_back<address>(&mut arg1.banned, arg2);
    }

    public fun banned(arg0: &Registry) : &vector<address> {
        &arg0.banned
    }

    public entry fun burn(arg0: &mut SuiZooTreasuryCap, arg1: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>, arg2: u64) {
        0x2::balance::decrease_supply<SuiZoo>(&mut arg0.supply, 0x2::balance::split<SuiZoo>(borrow_mut(arg1), arg2));
    }

    public entry fun create(arg0: &SuiZooTreasuryCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>>(zero(arg1, arg2), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SuiZoo{dummy_field: false};
        let v2 = SuiZooTreasuryCap{
            id     : 0x2::object::new(arg0),
            supply : 0x2::balance::create_supply<SuiZoo>(v1),
        };
        let v3 = zero(v0, arg0);
        0x2::transfer::public_transfer<0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>>(v3, v0);
        0x2::transfer::public_transfer<SuiZooTreasuryCap>(v2, v0);
        let v4 = Registry{
            id             : 0x2::object::new(arg0),
            banned         : 0x1::vector::empty<address>(),
            swapped_amount : 0,
        };
        0x2::transfer::share_object<Registry>(v4);
    }

    public entry fun mint(arg0: &mut SuiZooTreasuryCap, arg1: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>, arg2: u64) {
        0x2::balance::join<SuiZoo>(borrow_mut(arg1), 0x2::balance::increase_supply<SuiZoo>(&mut arg0.supply, arg2));
    }

    public entry fun put_back(arg0: &mut Registry, arg1: &mut 0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::RegulatedCoin<SuiZoo>, arg2: 0x2::coin::Coin<SuiZoo>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<SuiZoo>(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x669060754aa7283f5f6183ba6a25d8652daf0069d3fcb0a232e61e4252527159::regulated_coin::creator<SuiZoo>(arg1) == v1, 1);
        assert!(0x1::vector::contains<address>(&arg0.banned, &v1) == false, 2);
        arg0.swapped_amount = arg0.swapped_amount - 0x2::balance::value<SuiZoo>(&v0);
        0x2::balance::join<SuiZoo>(borrow_mut(arg1), v0);
    }

    public fun swapped_amount(arg0: &Registry) : u64 {
        arg0.swapped_amount
    }

    // decompiled from Move bytecode v6
}

