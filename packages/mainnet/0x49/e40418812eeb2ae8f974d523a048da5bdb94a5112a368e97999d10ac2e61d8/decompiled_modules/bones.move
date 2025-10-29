module 0x46ebdb70f94983dcf1beff8453459675a1c980c1b5ab5bcae3b36725b82d97be::bones {
    struct BONES has key {
        id: 0x2::object::UID,
    }

    struct BonesBank has key {
        id: 0x2::object::UID,
        pool: 0x2::coin::Coin<BONES>,
        bones_per_burn: u64,
    }

    struct DoonieBurnedForBones has copy, drop {
        burner: address,
        token_id: u64,
        amount: u64,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BONES> {
        assert!(0x2::tx_context::sender(arg1) == @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24, 1);
        let (v0, v1) = 0x2::coin_registry::new_currency<BONES>(arg0, 0, 0x1::string::utf8(b"BONES"), 0x1::string::utf8(b"BONES"), 0x1::string::utf8(b"Bones"), 0x1::string::utf8(b"https://walrus.doonies.net/bones.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BONES>>(0x2::coin_registry::finalize<BONES>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONES>>(v2, 0x2::tx_context::sender(arg1));
        0x2::coin::mint<BONES>(&mut v2, 1000000000, arg1)
    }

    public entry fun burn_for_bones(arg0: &mut 0x46ebdb70f94983dcf1beff8453459675a1c980c1b5ab5bcae3b36725b82d97be::doonies::NFTCollection, arg1: &mut BonesBank, arg2: 0x46ebdb70f94983dcf1beff8453459675a1c980c1b5ab5bcae3b36725b82d97be::doonies::NFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.bones_per_burn;
        assert!(v1 > 0, 1);
        0x46ebdb70f94983dcf1beff8453459675a1c980c1b5ab5bcae3b36725b82d97be::doonies::burn_nft_internal(arg2, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BONES>>(0x2::coin::split<BONES>(&mut arg1.pool, v1, arg3), v0);
        let v2 = DoonieBurnedForBones{
            burner   : v0,
            token_id : 0x46ebdb70f94983dcf1beff8453459675a1c980c1b5ab5bcae3b36725b82d97be::doonies::get_token_id(&arg2),
            amount   : v1,
        };
        0x2::event::emit<DoonieBurnedForBones>(v2);
    }

    public entry fun create_bones_bank(arg0: 0x2::coin::Coin<BONES>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24, 1);
        let v0 = BonesBank{
            id             : 0x2::object::new(arg2),
            pool           : arg0,
            bones_per_burn : arg1,
        };
        0x2::transfer::share_object<BonesBank>(v0);
    }

    public entry fun deposit_bones(arg0: &mut BonesBank, arg1: 0x2::coin::Coin<BONES>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24, 1);
        0x2::coin::join<BONES>(&mut arg0.pool, arg1);
    }

    public entry fun set_bones_per_burn(arg0: &mut BonesBank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24, 1);
        arg0.bones_per_burn = arg1;
    }

    // decompiled from Move bytecode v6
}

