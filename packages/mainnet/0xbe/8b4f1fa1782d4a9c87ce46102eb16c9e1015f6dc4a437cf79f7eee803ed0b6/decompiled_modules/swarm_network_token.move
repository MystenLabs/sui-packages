module 0xbe8b4f1fa1782d4a9c87ce46102eb16c9e1015f6dc4a437cf79f7eee803ed0b6::swarm_network_token {
    struct SWARM_NETWORK_TOKEN has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWARM_NETWORK_TOKEN>, arg1: MintCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let MintCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = 0x2::coin::into_balance<SWARM_NETWORK_TOKEN>(0x2::coin::mint<SWARM_NETWORK_TOKEN>(arg0, 1000000000000000000, arg8));
        0x2::transfer::public_transfer<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::Airdrop<SWARM_NETWORK_TOKEN>>(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::new<SWARM_NETWORK_TOKEN>(0x2::coin::take<SWARM_NETWORK_TOKEN>(&mut v1, 130000000000000000, arg8), arg2, 0x2::clock::timestamp_ms(arg7) + 1, 720 * 86400000, arg7, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::Airdrop<SWARM_NETWORK_TOKEN>>(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::new<SWARM_NETWORK_TOKEN>(0x2::coin::take<SWARM_NETWORK_TOKEN>(&mut v1, 80000000000000000, arg8), arg3, 0x2::clock::timestamp_ms(arg7) + 1, 360 * 86400000, arg7, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::Airdrop<SWARM_NETWORK_TOKEN>>(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::new<SWARM_NETWORK_TOKEN>(0x2::coin::take<SWARM_NETWORK_TOKEN>(&mut v1, 225000000000000000, arg8), arg4, 0x2::clock::timestamp_ms(arg7) + 1, 1440 * 86400000, arg7, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::Airdrop<SWARM_NETWORK_TOKEN>>(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::new<SWARM_NETWORK_TOKEN>(0x2::coin::take<SWARM_NETWORK_TOKEN>(&mut v1, 100000000000000000, arg8), arg5, 0x2::clock::timestamp_ms(arg7) + 1, 1080 * 86400000, arg7, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::Airdrop<SWARM_NETWORK_TOKEN>>(0xb37fe85436cfb5f0a4106021cfa0990d6a9be9f09fd137796a90558698543aeb::linear_vesting_airdrop::new<SWARM_NETWORK_TOKEN>(0x2::coin::take<SWARM_NETWORK_TOKEN>(&mut v1, 25000000000000000, arg8), arg6, 0x2::clock::timestamp_ms(arg7) + 1, 270 * 86400000, arg7, arg8), 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<SWARM_NETWORK_TOKEN>>(0x2::coin::from_balance<SWARM_NETWORK_TOKEN>(v1, arg8), @0x437771ac37a78b544e158d83f574fa2669b94a0f572379a189aa98b57d1df9d8);
    }

    public entry fun make_immutable(arg0: 0x2::package::UpgradeCap) {
        0x2::package::make_immutable(arg0);
    }

    fun init(arg0: SWARM_NETWORK_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARM_NETWORK_TOKEN>(arg0, 8, b"MRAWS2", b"The Mraws Token 2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blockchainassetregistry.infura-ipfs.io/ipfs/QmYu1AScYLvbDtwwCAnYsBKMX4mbsKNgSPjtxvPXQxymAB")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWARM_NETWORK_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARM_NETWORK_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

