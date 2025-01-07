module 0xaec95a73361b2e37dac6492f7101229aee23010c855810a1f7c8c0ec204d2364::random_nft_airdrop {
    struct AirDropNFT has store, key {
        id: 0x2::object::UID,
    }

    struct MetalNFT has store, key {
        id: 0x2::object::UID,
        metal: u8,
    }

    struct MintingCapability has key {
        id: 0x2::object::UID,
    }

    struct RandomnessNFT has store, key {
        id: 0x2::object::UID,
        value: u8,
    }

    fun arithmetic_is_less_than(arg0: u8, arg1: u8, arg2: u8) : u8 {
        assert!(arg2 >= arg1 && arg1 > 0, 0);
        let v0 = arg2 / arg1;
        (v0 - arg0 / arg1) / v0
    }

    fun destroy_airdrop_nft(arg0: AirDropNFT) {
        let AirDropNFT { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintingCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MintingCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun metal_string(arg0: &MetalNFT) : 0x1::string::String {
        if (arg0.metal == 1) {
            0x1::string::utf8(b"Gold")
        } else if (arg0.metal == 2) {
            0x1::string::utf8(b"Silver")
        } else {
            0x1::string::utf8(b"Bronze")
        }
    }

    public fun mint(arg0: &MintingCapability, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : vector<AirDropNFT> {
        let v0 = 0x1::vector::empty<AirDropNFT>();
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = AirDropNFT{id: 0x2::object::new(arg2)};
            0x1::vector::push_back<AirDropNFT>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    entry fun reveal(arg0: AirDropNFT, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        destroy_airdrop_nft(arg0);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        let v2 = arithmetic_is_less_than(v1, 11, 100);
        let v3 = arithmetic_is_less_than(v1, 41, 100) * (1 - v2);
        let v4 = MetalNFT{
            id    : 0x2::object::new(arg2),
            metal : v2 * 1 + v3 * 2 + (1 - v2) * (1 - v3) * 3,
        };
        0x2::transfer::public_transfer<MetalNFT>(v4, 0x2::tx_context::sender(arg2));
    }

    entry fun reveal_alternative1(arg0: AirDropNFT, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        destroy_airdrop_nft(arg0);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100);
        if (v1 <= 60) {
            let v2 = MetalNFT{
                id    : 0x2::object::new(arg2),
                metal : 3,
            };
            0x2::transfer::public_transfer<MetalNFT>(v2, 0x2::tx_context::sender(arg2));
        } else if (v1 <= 90) {
            let v3 = MetalNFT{
                id    : 0x2::object::new(arg2),
                metal : 2,
            };
            0x2::transfer::public_transfer<MetalNFT>(v3, 0x2::tx_context::sender(arg2));
        } else if (v1 <= 100) {
            let v4 = MetalNFT{
                id    : 0x2::object::new(arg2),
                metal : 1,
            };
            0x2::transfer::public_transfer<MetalNFT>(v4, 0x2::tx_context::sender(arg2));
        };
    }

    entry fun reveal_alternative2_step1(arg0: AirDropNFT, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        destroy_airdrop_nft(arg0);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = RandomnessNFT{
            id    : 0x2::object::new(arg2),
            value : 0x2::random::generate_u8_in_range(&mut v0, 1, 100),
        };
        0x2::transfer::public_transfer<RandomnessNFT>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun reveal_alternative2_step2(arg0: RandomnessNFT, arg1: &mut 0x2::tx_context::TxContext) : MetalNFT {
        let RandomnessNFT {
            id    : v0,
            value : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = if (v1 <= 10) {
            1
        } else if (10 < v1 && v1 <= 40) {
            2
        } else {
            3
        };
        MetalNFT{
            id    : 0x2::object::new(arg1),
            metal : v2,
        }
    }

    // decompiled from Move bytecode v6
}

