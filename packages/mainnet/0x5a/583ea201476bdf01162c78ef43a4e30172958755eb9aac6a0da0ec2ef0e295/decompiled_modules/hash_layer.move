module 0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::hash_layer {
    struct ChainState has key {
        id: 0x2::object::UID,
        difficulty: u64,
        reward: u64,
        last_adjustment_time: u64,
        last_block: Block,
    }

    struct ArtefactNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        epoch: u64,
        difficulty: u64,
        reward: u64,
        url: 0x2::url::Url,
    }

    struct Header has copy, drop, store {
        height: u64,
        previous_hash: vector<u8>,
        nonce: u64,
        data: vector<u8>,
    }

    struct Block has copy, drop, store {
        header: Header,
        block_hash: vector<u8>,
    }

    struct HASH_LAYER has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::hash::MiningController, arg1: &mut 0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::balance_keeper::BalanceKeeper, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::balance_keeper::withdraw_all(arg1, arg2);
        if (v0 != 0) {
            0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::hash::mint(v0, 0x2::tx_context::sender(arg2), arg0, arg2);
        };
    }

    fun adjust_difficulty(arg0: &mut ChainState, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 - arg0.last_adjustment_time;
        if (v1 == 0 || v1 > v0) {
            return
        };
        let v2 = arg0.difficulty;
        let v3 = v2;
        if (v1 < 86400000) {
            if (v2 < 255) {
                v3 = v2 + 1;
            };
        } else if (v1 > 86400000) {
            if (v2 > 1) {
                v3 = v2 - 1;
            };
        };
        if (v3 < 1) {
            arg0.difficulty = 1;
        } else if (v3 > 255) {
            arg0.difficulty = 255;
        } else {
            arg0.difficulty = v3;
        };
        arg0.last_adjustment_time = v0;
    }

    public fun create_block(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut ChainState, arg4: &0x2::clock::Clock, arg5: &mut 0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::balance_keeper::BalanceKeeper, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Header{
            height        : arg3.last_block.header.height + 1,
            previous_hash : arg3.last_block.block_hash,
            nonce         : arg0,
            data          : arg1,
        };
        let v1 = 0x2::bcs::to_bytes<Header>(&v0);
        let v2 = 0x2::hash::blake2b256(&v1);
        assert!(has_leading_zero_bits(&v2, arg3.difficulty), 0);
        let v3 = Block{
            header     : v0,
            block_hash : v2,
        };
        arg3.last_block = v3;
        0x2::event::emit<Block>(v3);
        if (arg3.last_block.header.height % 1440 == 0) {
            adjust_difficulty(arg3, arg4);
            mint_artefact_nft(arg2, arg3, arg6);
        };
        if (arg3.last_block.header.height % 444 == 0) {
            arg3.reward = reward_for_block(arg3.last_block.header.height);
        };
        0x5a583ea201476bdf01162c78ef43a4e30172958755eb9aac6a0da0ec2ef0e295::balance_keeper::deposit(arg5, arg3.reward * 1000000000, arg6);
    }

    fun has_leading_zero_bits(arg0: &vector<u8>, arg1: u64) : bool {
        let v0 = arg1 / 8;
        let v1 = arg1 % 8;
        let v2 = if (v1 > 0) {
            1
        } else {
            0
        };
        if (0x1::vector::length<u8>(arg0) < v0 + v2) {
            return false
        };
        let v3 = 0;
        while (v3 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v3) != 0) {
                return false
            };
            v3 = v3 + 1;
        };
        if (v1 > 0) {
            if (*0x1::vector::borrow<u8>(arg0, v3) & 255 << ((8 - v1) as u8) & 255 != 0) {
                return false
            };
        };
        true
    }

    fun init(arg0: HASH_LAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Header{
            height        : 0,
            previous_hash : 0x1::vector::empty<u8>(),
            nonce         : 0,
            data          : b"For people. Not for corporations. We will remember 10/10/2025",
        };
        let v1 = Block{
            header     : v0,
            block_hash : 0x1::vector::empty<u8>(),
        };
        let v2 = Header{
            height        : v1.header.height,
            previous_hash : v1.header.previous_hash,
            nonce         : v1.header.nonce,
            data          : v1.header.data,
        };
        let v3 = Block{
            header     : v2,
            block_hash : v1.block_hash,
        };
        let v4 = ChainState{
            id                   : 0x2::object::new(arg1),
            difficulty           : 1,
            reward               : 7000,
            last_adjustment_time : 0,
            last_block           : v3,
        };
        0x2::event::emit<Block>(v1);
        0x2::transfer::share_object<ChainState>(v4);
    }

    fun mint_artefact_nft(arg0: vector<u8>, arg1: &ChainState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.last_block.header.height / 1440;
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, b"Artefact #");
        0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1::u64::to_string(v0)));
        let v2 = ArtefactNFT{
            id         : 0x2::object::new(arg2),
            name       : 0x1::string::utf8(v1),
            epoch      : v0,
            difficulty : arg1.difficulty,
            reward     : arg1.reward,
            url        : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        0x2::transfer::public_transfer<ArtefactNFT>(v2, 0x2::tx_context::sender(arg2));
    }

    fun reward_for_block(arg0: u64) : u64 {
        let v0 = if (arg0 >= 444) {
            arg0 / 444
        } else {
            0
        };
        if (v0 >= 7000) {
            0
        } else {
            7000 - v0
        }
    }

    // decompiled from Move bytecode v6
}

