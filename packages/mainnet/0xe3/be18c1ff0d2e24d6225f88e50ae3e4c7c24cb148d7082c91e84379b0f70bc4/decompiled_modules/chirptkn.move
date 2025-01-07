module 0xe3be18c1ff0d2e24d6225f88e50ae3e4c7c24cb148d7082c91e84379b0f70bc4::chirptkn {
    struct CHIRPTKN has drop {
        dummy_field: bool,
    }

    struct ChirpTknAdmin has key {
        id: 0x2::object::UID,
        trs: 0x2::coin::TreasuryCap<CHIRPTKN>,
        name: 0x1::string::String,
    }

    struct ChirpMinter has key {
        id: 0x2::object::UID,
        amountsPerYears: vector<u64>,
        keepersPctPerYears: vector<u64>,
        investorsPctPerYears: vector<u64>,
        teamPctPerYears: vector<u64>,
        reservePctPerYears: vector<u64>,
        mintsPerYear: u64,
        mintCount: u64,
        curYearLeft: u64,
        preMintAmount: u64,
        preMintReservePct: u64,
        keepersWallet: address,
        investorsWallet: address,
        teamWallet: address,
        treasuryWallet: address,
        reserveWallet: address,
        lastMinted: u64,
    }

    struct ChirpMinterAmounts has key {
        id: 0x2::object::UID,
        amounts: vector<u64>,
        mintCount: u64,
    }

    public entry fun mint(arg0: &mut ChirpMinter, arg1: &mut ChirpTknAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = arg0.mintCount;
        while (arg2 > 0) {
            arg2 = arg2 - 1;
            let v9 = arg0.mintCount / arg0.mintsPerYear;
            let v10 = arg0.mintCount % arg0.mintsPerYear;
            if (v10 == 0) {
                if (v9 >= 0x1::vector::length<u64>(&arg0.amountsPerYears)) {
                    break
                };
                arg0.curYearLeft = *0x1::vector::borrow<u64>(&arg0.amountsPerYears, v9);
            };
            let v11 = arg0.curYearLeft / (arg0.mintsPerYear - v10);
            arg0.curYearLeft = arg0.curYearLeft - v11;
            arg0.mintCount = arg0.mintCount + 1;
            let v12 = v11 * *0x1::vector::borrow<u64>(&arg0.keepersPctPerYears, v9) / 10000;
            let v13 = v11 * *0x1::vector::borrow<u64>(&arg0.investorsPctPerYears, v9) / 10000;
            let v14 = v11 * *0x1::vector::borrow<u64>(&arg0.teamPctPerYears, v9) / 10000;
            let v15 = v11 * *0x1::vector::borrow<u64>(&arg0.reservePctPerYears, v9) / 10000;
            v5 = v5 + v11;
            0x1::vector::push_back<u64>(&mut v6, v12);
            0x1::vector::push_back<u64>(&mut v7, v13);
            v0 = v0 + v12;
            v1 = v1 + v13;
            v2 = v2 + v14;
            v3 = v3 + v15;
            let v16 = v4 + v11 - v12 - v13 - v14;
            v4 = v16 - v15;
        };
        arg0.lastMinted = v5;
        let v17 = ChirpMinterAmounts{
            id        : 0x2::object::new(arg3),
            amounts   : v6,
            mintCount : v8,
        };
        0x2::transfer::transfer<ChirpMinterAmounts>(v17, arg0.keepersWallet);
        let v18 = ChirpMinterAmounts{
            id        : 0x2::object::new(arg3),
            amounts   : v7,
            mintCount : v8,
        };
        0x2::transfer::transfer<ChirpMinterAmounts>(v18, arg0.investorsWallet);
        mint_and_send(arg1, v0, arg0.keepersWallet, arg3);
        mint_and_send(arg1, v1, arg0.investorsWallet, arg3);
        mint_and_send(arg1, v2, arg0.teamWallet, arg3);
        mint_and_send(arg1, v3, arg0.reserveWallet, arg3);
        mint_and_send(arg1, v4, arg0.treasuryWallet, arg3);
    }

    public entry fun delete_amounts(arg0: ChirpMinterAmounts) {
        let ChirpMinterAmounts {
            id        : v0,
            amounts   : _,
            mintCount : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CHIRPTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = b"TESTCHIRP";
        let (v2, v3) = 0x2::coin::create_currency<CHIRPTKN>(arg0, 6, v1, b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRPTKN>>(v3);
        let v4 = ChirpTknAdmin{
            id   : 0x2::object::new(arg1),
            trs  : v2,
            name : 0x1::string::utf8(v1),
        };
        0x2::transfer::transfer<ChirpTknAdmin>(v4, v0);
        let v5 = ChirpMinter{
            id                   : 0x2::object::new(arg1),
            amountsPerYears      : vector[51000000, 51000000, 34438300, 34438300, 23254834, 23254834, 15703078, 15703078, 10603673, 10603673],
            keepersPctPerYears   : vector[5000, 5000, 5000, 5000, 6500, 6500, 6500, 6500, 7500, 7500],
            investorsPctPerYears : vector[3000, 3500, 3681, 3681, 0, 0, 0, 0, 0, 0],
            teamPctPerYears      : vector[1206, 1000, 820, 820, 3000, 3000, 3000, 3000, 2000, 2000],
            reservePctPerYears   : vector[294, 100, 100, 100, 100, 100, 100, 100, 100, 100],
            mintsPerYear         : 365,
            mintCount            : 0,
            curYearLeft          : 0,
            preMintAmount        : 30000000,
            preMintReservePct    : 7500,
            keepersWallet        : v0,
            investorsWallet      : v0,
            teamWallet           : v0,
            treasuryWallet       : v0,
            reserveWallet        : v0,
            lastMinted           : 0,
        };
        0x2::transfer::transfer<ChirpMinter>(v5, v0);
    }

    fun mint_and_send(arg0: &mut ChirpTknAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CHIRPTKN>>(0x2::coin::mint<CHIRPTKN>(&mut arg0.trs, arg1 * 1000000, arg3), arg2);
        };
    }

    public fun next_amount(arg0: &mut ChirpMinterAmounts) : u64 {
        if (0x1::vector::length<u64>(&arg0.amounts) > 0) {
            return 0x1::vector::remove<u64>(&mut arg0.amounts, 0)
        };
        0
    }

    public entry fun pre_mint(arg0: &mut ChirpMinter, arg1: &mut ChirpTknAdmin, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.preMintAmount > 0) {
            let v0 = arg0.preMintAmount * arg0.preMintReservePct / 10000;
            mint_and_send(arg1, v0, arg0.reserveWallet, arg2);
            mint_and_send(arg1, arg0.preMintAmount - v0, arg0.treasuryWallet, arg2);
            arg0.preMintAmount = 0;
        };
    }

    public entry fun set_wallets(arg0: &mut ChirpMinter, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address) {
        arg0.keepersWallet = arg1;
        arg0.investorsWallet = arg2;
        arg0.teamWallet = arg3;
        arg0.treasuryWallet = arg4;
        arg0.reserveWallet = arg5;
    }

    // decompiled from Move bytecode v6
}

