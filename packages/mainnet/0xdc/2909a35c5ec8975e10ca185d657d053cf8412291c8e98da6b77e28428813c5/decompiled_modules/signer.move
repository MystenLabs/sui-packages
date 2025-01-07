module 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::signer {
    struct PriceFeed has drop {
        sender: address,
        price_bps: u64,
        token_address: 0x1::ascii::String,
        expired_at: u64,
    }

    public(friend) fun verify_signature(arg0: vector<u8>, arg1: address, arg2: u64, arg3: 0x1::ascii::String, arg4: u64, arg5: vector<u8>) : bool {
        let v0 = PriceFeed{
            sender        : arg1,
            price_bps     : arg2,
            token_address : arg3,
            expired_at    : arg4,
        };
        let v1 = 0x2::bcs::to_bytes<PriceFeed>(&v0);
        0x2::ed25519::ed25519_verify(&arg5, &arg0, &v1)
    }

    // decompiled from Move bytecode v6
}

