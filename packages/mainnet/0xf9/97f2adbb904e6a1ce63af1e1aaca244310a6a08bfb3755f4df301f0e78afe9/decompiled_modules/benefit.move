module 0xf997f2adbb904e6a1ce63af1e1aaca244310a6a08bfb3755f4df301f0e78afe9::benefit {
    struct Benefit has copy, drop, store {
        name: 0x1::string::String,
        claimed: 0x1::option::Option<bool>,
        expiration_timestamp: 0x1::option::Option<u64>,
    }

    public(friend) fun claimed(arg0: &Benefit) : &0x1::option::Option<bool> {
        &arg0.claimed
    }

    public(friend) fun claimed_mut(arg0: &mut Benefit) : &mut 0x1::option::Option<bool> {
        &mut arg0.claimed
    }

    public(friend) fun expiration_timestamp(arg0: &Benefit) : &0x1::option::Option<u64> {
        &arg0.expiration_timestamp
    }

    public(friend) fun expiration_timestamp_mut(arg0: &mut Benefit) : &mut 0x1::option::Option<u64> {
        &mut arg0.expiration_timestamp
    }

    public(friend) fun name(arg0: &Benefit) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun name_mut(arg0: &mut Benefit) : &mut 0x1::string::String {
        &mut arg0.name
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::option::Option<bool>, arg2: 0x1::option::Option<u64>) : Benefit {
        Benefit{
            name                 : arg0,
            claimed              : arg1,
            expiration_timestamp : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

