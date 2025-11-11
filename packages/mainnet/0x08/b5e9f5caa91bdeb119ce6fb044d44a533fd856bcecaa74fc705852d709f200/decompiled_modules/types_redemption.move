module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::types_redemption {
    struct Redemption has copy, drop, store {
        asset: 0x1::string::String,
        chain: 0x1::string::String,
        redemption_id: 0x1::string::String,
        amount: u64,
        burner: address,
    }

    public(friend) fun get_amount(arg0: &Redemption) : u64 {
        arg0.amount
    }

    public(friend) fun get_asset(arg0: &Redemption) : 0x1::string::String {
        arg0.asset
    }

    public(friend) fun get_chain(arg0: &Redemption) : 0x1::string::String {
        arg0.chain
    }

    public(friend) fun get_redemption_id(arg0: &Redemption) : 0x1::string::String {
        arg0.redemption_id
    }

    public(friend) fun new_redemption(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: address) : Redemption {
        Redemption{
            asset         : arg0,
            chain         : arg1,
            redemption_id : arg2,
            amount        : arg3,
            burner        : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

