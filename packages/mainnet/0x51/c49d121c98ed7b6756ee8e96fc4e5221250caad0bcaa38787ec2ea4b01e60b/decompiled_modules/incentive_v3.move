module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3 {
    struct Incentive has key {
        id: 0x2::object::UID,
    }

    public fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg2: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg6: &mut Incentive, arg7: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::account::AccountCap) {
        abort 0
    }

    public fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::oracle::PriceOracle, arg2: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg3: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg7: &mut Incentive, arg8: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::account::AccountCap) : 0x2::balance::Balance<T0> {
        abort 0
    }

    // decompiled from Move bytecode v7
}

