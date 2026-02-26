module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::wtc_token {
    struct WTC_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenDistributed has copy, drop {
        category: vector<u8>,
        amount: u64,
        recipient: address,
    }

    struct TreasuryCapFrozen has copy, drop {
        total_supply: u64,
        message: vector<u8>,
    }

    fun init(arg0: WTC_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTC_TOKEN>(arg0, 9, b"WTC", b"Waveletica Coin", b"Platform utility coin for activity-based rewards, governance, staking, and DAO treasury. Earn WTC through campaigns, backing, voting, and community participation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjyjnvfuvshv35lilnqiuuamwbykcdp3uozd4wvwfiquzyodgeze")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WTC_TOKEN>>(0x2::coin::mint<WTC_TOKEN>(&mut v2, 350000000000000000, arg1), @0x47cd33511bf1c2bf2682904193b0909d20aa5b078c4c70824a0844b9445f6334);
        let v3 = TokenDistributed{
            category  : b"Creator Incentives",
            amount    : 350000000000000000,
            recipient : @0x47cd33511bf1c2bf2682904193b0909d20aa5b078c4c70824a0844b9445f6334,
        };
        0x2::event::emit<TokenDistributed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<WTC_TOKEN>>(0x2::coin::mint<WTC_TOKEN>(&mut v2, 250000000000000000, arg1), @0x2754a26fa0c764ed0cc6c5721cbfe31ec0b1e9279b84644c9f90d969fc7f538c);
        let v4 = TokenDistributed{
            category  : b"Community Rewards",
            amount    : 250000000000000000,
            recipient : @0x2754a26fa0c764ed0cc6c5721cbfe31ec0b1e9279b84644c9f90d969fc7f538c,
        };
        0x2::event::emit<TokenDistributed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<WTC_TOKEN>>(0x2::coin::mint<WTC_TOKEN>(&mut v2, 200000000000000000, arg1), @0xf13f90e39905f95ee678b0891fc4af0d9577a6edc0b8252c7021c543a2a780f2);
        let v5 = TokenDistributed{
            category  : b"Ecosystem Development",
            amount    : 200000000000000000,
            recipient : @0xf13f90e39905f95ee678b0891fc4af0d9577a6edc0b8252c7021c543a2a780f2,
        };
        0x2::event::emit<TokenDistributed>(v5);
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::vesting::create_vault<WTC_TOKEN>(0x2::coin::mint<WTC_TOKEN>(&mut v2, 120000000000000000, arg1), @0x8f16003764cccfd6ea229d11b1d457ab347045bccfc879f691af14efd5d7c82d, 183, 1095, arg1);
        let v6 = TokenDistributed{
            category  : b"Core Team (36-month Vesting)",
            amount    : 120000000000000000,
            recipient : @0x8f16003764cccfd6ea229d11b1d457ab347045bccfc879f691af14efd5d7c82d,
        };
        0x2::event::emit<TokenDistributed>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<WTC_TOKEN>>(0x2::coin::mint<WTC_TOKEN>(&mut v2, 50000000000000000, arg1), @0xfc5e981cadc2b6aa47fa7f017826d82a05298c35fa1813b7c3f143cfc63da1a5);
        let v7 = TokenDistributed{
            category  : b"Strategic Partners",
            amount    : 50000000000000000,
            recipient : @0xfc5e981cadc2b6aa47fa7f017826d82a05298c35fa1813b7c3f143cfc63da1a5,
        };
        0x2::event::emit<TokenDistributed>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<WTC_TOKEN>>(0x2::coin::mint<WTC_TOKEN>(&mut v2, 30000000000000000, arg1), @0x11f1c3fe5ccc6a68765449e7883272e2e1bb743e30038702b5330157f95d758f);
        let v8 = TokenDistributed{
            category  : b"Treasury & Reserve",
            amount    : 30000000000000000,
            recipient : @0x11f1c3fe5ccc6a68765449e7883272e2e1bb743e30038702b5330157f95d758f,
        };
        0x2::event::emit<TokenDistributed>(v8);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WTC_TOKEN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTC_TOKEN>>(v1);
        let v9 = TreasuryCapFrozen{
            total_supply : 1000000000000000000,
            message      : b"WTC TreasuryCap is permanently frozen. No additional minting possible.",
        };
        0x2::event::emit<TreasuryCapFrozen>(v9);
    }

    // decompiled from Move bytecode v6
}

