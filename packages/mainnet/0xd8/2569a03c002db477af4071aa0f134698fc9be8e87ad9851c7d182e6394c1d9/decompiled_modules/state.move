module 0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::state {
    struct STATE has drop {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        pause: bool,
        fee_enabled: bool,
        fee_rate: u16,
        dex_flag: u256,
    }

    public(friend) fun fee_enabled(arg0: &State) : bool {
        arg0.fee_enabled
    }

    public(friend) fun fee_rate(arg0: &State) : u16 {
        arg0.fee_rate
    }

    public(friend) fun get_config<T0: copy + drop + store, T1: copy + drop + store>(arg0: &State, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    fun init(arg0: STATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id          : 0x2::object::new(arg1),
            pause       : false,
            fee_enabled : false,
            fee_rate    : 0,
            dex_flag    : 115792089237316195423570985008687907853269984665640564039457584007913129639935,
        };
        0x2::transfer::public_share_object<State>(v0);
    }

    public(friend) fun pause(arg0: &State) : bool {
        arg0.pause
    }

    entry fun set_config<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut State, arg1: T0, arg2: T1, arg3: &0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::capability::AdminCap) {
        0x2::dynamic_field::remove_if_exists<T0, T1>(&mut arg0.id, arg1);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    entry fun update(arg0: &mut State, arg1: bool, arg2: u16, arg3: u256, arg4: &0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::capability::AdminCap) {
        arg0.fee_enabled = arg1;
        arg0.fee_rate = arg2;
        arg0.dex_flag = arg3;
    }

    // decompiled from Move bytecode v6
}

