module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop {
    struct ItemDrop has copy, drop, store {
        item_ids: vector<u256>,
        quantities: vector<u256>,
        actual_rates: vector<u256>,
        rates: vector<u256>,
    }

    public fun get(arg0: &ItemDrop) : (vector<u256>, vector<u256>, vector<u256>, vector<u256>) {
        (arg0.item_ids, arg0.quantities, arg0.actual_rates, arg0.rates)
    }

    public fun get_actual_rates(arg0: &ItemDrop) : vector<u256> {
        arg0.actual_rates
    }

    public fun get_item_ids(arg0: &ItemDrop) : vector<u256> {
        arg0.item_ids
    }

    public fun get_quantities(arg0: &ItemDrop) : vector<u256> {
        arg0.quantities
    }

    public fun get_rates(arg0: &ItemDrop) : vector<u256> {
        arg0.rates
    }

    public fun new(arg0: vector<u256>, arg1: vector<u256>, arg2: vector<u256>, arg3: vector<u256>) : ItemDrop {
        ItemDrop{
            item_ids     : arg0,
            quantities   : arg1,
            actual_rates : arg2,
            rates        : arg3,
        }
    }

    public(friend) fun set(arg0: &mut ItemDrop, arg1: vector<u256>, arg2: vector<u256>, arg3: vector<u256>, arg4: vector<u256>) {
        arg0.item_ids = arg1;
        arg0.quantities = arg2;
        arg0.actual_rates = arg3;
        arg0.rates = arg4;
    }

    public(friend) fun set_actual_rates(arg0: &mut ItemDrop, arg1: vector<u256>) {
        arg0.actual_rates = arg1;
    }

    public(friend) fun set_item_ids(arg0: &mut ItemDrop, arg1: vector<u256>) {
        arg0.item_ids = arg1;
    }

    public(friend) fun set_quantities(arg0: &mut ItemDrop, arg1: vector<u256>) {
        arg0.quantities = arg1;
    }

    public(friend) fun set_rates(arg0: &mut ItemDrop, arg1: vector<u256>) {
        arg0.rates = arg1;
    }

    // decompiled from Move bytecode v6
}

