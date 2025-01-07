module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types {
    struct ValsetArgs has drop {
        validators: vector<vector<u8>>,
        powers: vector<u64>,
        valset_nonce: u256,
    }

    public(friend) fun create_valset_args(arg0: vector<vector<u8>>, arg1: vector<u64>, arg2: u256) : ValsetArgs {
        ValsetArgs{
            validators   : arg0,
            powers       : arg1,
            valset_nonce : arg2,
        }
    }

    public fun powers(arg0: &ValsetArgs) : vector<u64> {
        arg0.powers
    }

    public fun validators(arg0: &ValsetArgs) : vector<vector<u8>> {
        arg0.validators
    }

    public fun valset_nonce(arg0: &ValsetArgs) : u256 {
        arg0.valset_nonce
    }

    // decompiled from Move bytecode v6
}

