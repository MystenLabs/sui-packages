module 0x3ae976ef1345716195c811464ea8957499fcda338211ca0e65e68a58ca7c774::house_data {
    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>,
        house: address,
    }

    struct HouseCap has key {
        id: 0x2::object::UID,
    }

    struct HOUSE_DATA has drop {
        dummy_field: bool,
    }

    public(friend) fun borrow(arg0: &HouseData) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut(arg0: &mut HouseData) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun balance(arg0: &HouseData) : u64 {
        0x2::balance::value<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(&arg0.balance)
    }

    public(friend) fun borrow_balance_mut(arg0: &mut HouseData) : &mut 0x2::balance::Balance<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN> {
        &mut arg0.balance
    }

    fun init(arg0: HOUSE_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<HOUSE_DATA>(arg0, arg1);
        let v0 = HouseCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_house_data(arg0: HouseCap, arg1: &mut 0x2::coin::TreasuryCap<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseData{
            id      : 0x2::object::new(arg3),
            balance : 0x2::coin::into_balance<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(0x2::coin::mint<0x820453d29a70f37b4555f7e8340c278119a84b8de48d701eaf34e61489246cf::lihuazhang_faucet_coin::LIHUAZHANG_FAUCET_COIN>(arg1, arg2, arg3)),
            house   : 0x2::tx_context::sender(arg3),
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    // decompiled from Move bytecode v6
}

