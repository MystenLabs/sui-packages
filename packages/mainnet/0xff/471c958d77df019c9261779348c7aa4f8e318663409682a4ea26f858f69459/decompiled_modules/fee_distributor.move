module 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::fee_distributor {
    public(friend) fun distribute<T0>(arg0: &mut 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::deposit<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

