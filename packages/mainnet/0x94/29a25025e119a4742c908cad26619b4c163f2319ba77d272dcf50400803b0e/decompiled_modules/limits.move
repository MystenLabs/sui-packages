module 0x9429a25025e119a4742c908cad26619b4c163f2319ba77d272dcf50400803b0e::limits {
    struct Collection has store, key {
        id: 0x2::object::UID,
        votes: vector<u64>,
        volumes: vector<u64>,
        scores: vector<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64>,
        payout_percent: vector<u128>,
    }

    public fun calc(arg0: Collection, arg1: u64) : Collection {
        assert!(0x1::vector::length<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64>(&arg0.scores) == 0, 993719);
        let v0 = 0x1::vector::length<u64>(&arg0.votes);
        let v1 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from(0);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::mul(dist_factor(*0x1::vector::borrow<u64>(&arg0.volumes, v2), arg1, 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from_rational(22, 10), 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from(1)), 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from((*0x1::vector::borrow<u64>(&arg0.votes, v2) as u128)));
            v1 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::add(v1, v3);
            0x1::vector::push_back<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64>(&mut arg0.scores, v3);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < v0) {
            0x1::vector::push_back<u128>(&mut arg0.payout_percent, 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::to_u128(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::mul(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::div(*0x1::vector::borrow<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64>(&arg0.scores, v4), v1), 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from((1000000 as u128)))));
            v4 = v4 + 1;
        };
        arg0
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Collection {
        let v0 = Collection{
            id             : 0x2::object::new(arg1),
            votes          : vector[],
            volumes        : vector[],
            scores         : 0x1::vector::empty<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64>(),
            payout_percent : vector[],
        };
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0.votes, 10000);
            0x1::vector::push_back<u64>(&mut v0.volumes, v1 * 10000000000);
            v1 = v1 + 1;
        };
        v0
    }

    public fun denominator() : u64 {
        1000000
    }

    fun dist_factor(arg0: u64, arg1: u64, arg2: 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64, arg3: 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64) : 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::FixedPoint64 {
        let v0 = 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::div(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from_rational((arg0 as u128), (1000000 as u128)), 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::from_rational((arg1 as u128), (1000000 as u128)));
        let v1 = if (0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::gte(v0, arg3)) {
            0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::min(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::sub(v0, arg3), arg3)
        } else {
            0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::sub(arg3, v0)
        };
        0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::div(arg3, 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::exp(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::mul(arg2, 0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::fixed_point64::pow(v1, 2))))
    }

    public fun payout_percent(arg0: &Collection) : vector<u128> {
        arg0.payout_percent
    }

    // decompiled from Move bytecode v6
}

