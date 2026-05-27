module 0x9ebbf85211d3391f23868b3ae6b7821bd10651e598d3f7b575ffc13ed51d6a6a::farm_coin {
    struct FarmCoinInitEvent has copy, drop {
        treasury_cap_id: 0x2::object::ID,
        metadata_cap_id: 0x2::object::ID,
        initial_supply: u64,
    }

    struct FarmCoinMintEvent has copy, drop {
        amount: u64,
        new_total_supply: u64,
    }

    struct FARM_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARM_COIN>(arg0, 9, 0x1::string::utf8(b"FARM"), 0x1::string::utf8(b"SRM Farm Token"), 0x1::string::utf8(b"Reward token for SRM DEX farming pools. Earned by staking LP tokens."), 0x1::string::utf8(b"https://suirewards.me/farm-icon.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<FARM_COIN>>(0x2::coin::mint<FARM_COIN>(&mut v2, 170000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = 0x2::coin_registry::finalize<FARM_COIN>(v0, arg1);
        let v4 = FarmCoinInitEvent{
            treasury_cap_id : 0x2::object::id<0x2::coin::TreasuryCap<FARM_COIN>>(&v2),
            metadata_cap_id : 0x2::object::id<0x2::coin_registry::MetadataCap<FARM_COIN>>(&v3),
            initial_supply  : 170000000000000000,
        };
        0x2::event::emit<FarmCoinInitEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARM_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARM_COIN>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun initial_supply() : u64 {
        170000000000000000
    }

    public fun mint_additional(arg0: &mut 0x2::coin::TreasuryCap<FARM_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmCoinMintEvent{
            amount           : arg1,
            new_total_supply : 0x2::coin::total_supply<FARM_COIN>(arg0),
        };
        0x2::event::emit<FarmCoinMintEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<FARM_COIN>>(0x2::coin::mint<FARM_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

