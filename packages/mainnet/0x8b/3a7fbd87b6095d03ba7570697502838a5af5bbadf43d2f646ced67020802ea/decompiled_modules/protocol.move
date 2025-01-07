module 0x8b3a7fbd87b6095d03ba7570697502838a5af5bbadf43d2f646ced67020802ea::protocol {
    struct AlphaPoolInfo has store {
        alphaUnlockedPerSecond: u64,
        poolWeight: u64,
        tokensInvested: u64,
    }

    struct PoolInfo has store {
        poolWeight: u64,
        tokensInvested: u64,
    }

    struct ProtocolInfo has key {
        id: 0x2::object::UID,
        totalWeight: u64,
        alpha: AlphaPoolInfo,
        sui: PoolInfo,
        usdc: PoolInfo,
        usdt: PoolInfo,
    }

    public(friend) fun addTokensInvested(arg0: &mut ProtocolInfo, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x1::string::utf8(arg1);
        if (v0 == 0x1::string::utf8(b"ALPHA")) {
            arg0.alpha.tokensInvested = arg0.alpha.tokensInvested + arg2;
        } else if (v0 == 0x1::string::utf8(b"SUI")) {
            arg0.sui.tokensInvested = arg0.sui.tokensInvested + arg2;
        } else if (v0 == 0x1::string::utf8(b"USDC")) {
            arg0.usdc.tokensInvested = arg0.usdc.tokensInvested + arg2;
        } else {
            assert!(v0 == 0x1::string::utf8(b"USDT"), 404);
            arg0.usdt.tokensInvested = arg0.usdt.tokensInvested + arg2;
        };
    }

    public(friend) fun getAlphaUnlockedPerSecond(arg0: &ProtocolInfo) : u64 {
        arg0.alpha.alphaUnlockedPerSecond
    }

    public(friend) fun getPoolWeight(arg0: &ProtocolInfo, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        if (v0 == 0x1::string::utf8(b"ALPHA")) {
            arg0.alpha.poolWeight
        } else if (v0 == 0x1::string::utf8(b"SUI")) {
            arg0.sui.poolWeight
        } else if (v0 == 0x1::string::utf8(b"USDC")) {
            arg0.usdc.poolWeight
        } else {
            assert!(v0 == 0x1::string::utf8(b"USDT"), 404);
            arg0.usdt.poolWeight
        }
    }

    public(friend) fun getTokensInvested(arg0: &ProtocolInfo, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        if (v0 == 0x1::string::utf8(b"ALPHA")) {
            arg0.alpha.tokensInvested
        } else if (v0 == 0x1::string::utf8(b"SUI")) {
            arg0.sui.tokensInvested
        } else if (v0 == 0x1::string::utf8(b"USDC")) {
            arg0.usdc.tokensInvested
        } else {
            assert!(v0 == 0x1::string::utf8(b"USDT"), 404);
            arg0.usdt.tokensInvested
        }
    }

    public(friend) fun getTotalWeight(arg0: &ProtocolInfo) : u64 {
        arg0.totalWeight
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphaPoolInfo{
            alphaUnlockedPerSecond : 0,
            poolWeight             : 0,
            tokensInvested         : 0,
        };
        let v1 = PoolInfo{
            poolWeight     : 0,
            tokensInvested : 0,
        };
        let v2 = PoolInfo{
            poolWeight     : 0,
            tokensInvested : 0,
        };
        let v3 = PoolInfo{
            poolWeight     : 0,
            tokensInvested : 0,
        };
        let v4 = ProtocolInfo{
            id          : 0x2::object::new(arg0),
            totalWeight : v0.poolWeight + v1.poolWeight + v2.poolWeight + v3.poolWeight,
            alpha       : v0,
            sui         : v1,
            usdc        : v2,
            usdt        : v3,
        };
        0x2::transfer::share_object<ProtocolInfo>(v4);
    }

    public(friend) fun setAlphaUnlockedPerSecond(arg0: &mut ProtocolInfo, arg1: u64) {
        arg0.alpha.alphaUnlockedPerSecond = arg1;
    }

    public(friend) fun setPoolWeight(arg0: &mut ProtocolInfo, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x1::string::utf8(arg1);
        if (v0 == 0x1::string::utf8(b"ALPHA")) {
            arg0.alpha.poolWeight = arg2;
            arg0.totalWeight = arg0.totalWeight + arg2 - arg0.alpha.poolWeight;
        } else if (v0 == 0x1::string::utf8(b"SUI")) {
            arg0.sui.poolWeight = arg2;
            arg0.totalWeight = arg0.totalWeight + arg2 - arg0.sui.poolWeight;
        } else if (v0 == 0x1::string::utf8(b"USDC")) {
            arg0.usdc.poolWeight = arg2;
            arg0.totalWeight = arg0.totalWeight + arg2 - arg0.usdc.poolWeight;
        } else {
            assert!(v0 == 0x1::string::utf8(b"USDT"), 404);
            arg0.usdt.poolWeight = arg2;
            arg0.totalWeight = arg0.totalWeight + arg2 - arg0.usdt.poolWeight;
        };
    }

    public(friend) fun setTokensInvested(arg0: &mut ProtocolInfo, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x1::string::utf8(arg1);
        if (v0 == 0x1::string::utf8(b"ALPHA")) {
            arg0.alpha.tokensInvested = arg2;
        } else if (v0 == 0x1::string::utf8(b"SUI")) {
            arg0.sui.tokensInvested = arg2;
        } else if (v0 == 0x1::string::utf8(b"USDC")) {
            arg0.usdc.tokensInvested = arg2;
        } else {
            assert!(v0 == 0x1::string::utf8(b"USDT"), 404);
            arg0.usdt.tokensInvested = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

