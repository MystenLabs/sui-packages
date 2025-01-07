module 0xaa57b9ea6d10a81768aabd630780712f23e07ad4618ca7eb288b7e03529546b1::house_data {
    struct HouseData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        house: address,
        public_key: vector<u8>,
        max_stake: u64,
        min_stake: u64,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        base_fee_in_bp: u16,
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
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun base_fee_in_bp(arg0: &HouseData) : u16 {
        arg0.base_fee_in_bp
    }

    public(friend) fun borrow_balance_mut(arg0: &mut HouseData) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.balance
    }

    public(friend) fun borrow_fees_mut(arg0: &mut HouseData) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.fees
    }

    public fun claim_fees(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == house(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fees, fees(arg0), arg1), house(arg0));
    }

    public fun fees(arg0: &HouseData) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fees)
    }

    public fun house(arg0: &HouseData) : address {
        arg0.house
    }

    fun init(arg0: HOUSE_DATA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<HOUSE_DATA>(arg0, arg1);
        let v0 = HouseCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_house_data(arg0: HouseCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 1);
        let v0 = HouseData{
            id             : 0x2::object::new(arg3),
            balance        : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            house          : 0x2::tx_context::sender(arg3),
            public_key     : arg2,
            max_stake      : 50000000000,
            min_stake      : 1000000000,
            fees           : 0x2::balance::zero<0x2::sui::SUI>(),
            base_fee_in_bp : 100,
        };
        let HouseCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        0x2::transfer::share_object<HouseData>(v0);
    }

    public fun max_stake(arg0: &HouseData) : u64 {
        arg0.max_stake
    }

    public fun min_stake(arg0: &HouseData) : u64 {
        arg0.min_stake
    }

    public fun public_key(arg0: &HouseData) : vector<u8> {
        arg0.public_key
    }

    public fun top_up(arg0: &mut HouseData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun update_max_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == house(arg0), 0);
        arg0.max_stake = arg1;
    }

    public fun update_min_stake(arg0: &mut HouseData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == house(arg0), 0);
        arg0.min_stake = arg1;
    }

    public fun withdraw(arg0: &mut HouseData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == house(arg0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, balance(arg0), arg1), house(arg0));
    }

    // decompiled from Move bytecode v6
}

