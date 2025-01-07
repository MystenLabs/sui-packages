module 0x7b8368820ad59f241962f0f5890e7de024d1141f38651d055ce9735fe08d7a8a::nft_raffle {
    struct NFT_Raffle<T0: store + key> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        round: u64,
        status: u8,
        participants: vector<address>,
        reward_nfts: vector<T0>,
        winnerCount: u64,
        winners: vector<address>,
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: vector<u8>, arg1: u64, arg2: vector<address>, arg3: vector<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT_Raffle<T0>{
            id           : 0x2::object::new(arg4),
            name         : 0x1::string::utf8(arg0),
            round        : arg1,
            status       : 0,
            participants : arg2,
            reward_nfts  : arg3,
            winnerCount  : 0x1::vector::length<T0>(&arg3),
            winners      : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<NFT_Raffle<T0>>(v0);
    }

    fun getWinners<T0: store + key>(arg0: &NFT_Raffle<T0>) : vector<address> {
        arg0.winners
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun settle_nft_raffle<T0: store + key>(arg0: &mut NFT_Raffle<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 1, 0);
        0x7b8368820ad59f241962f0f5890e7de024d1141f38651d055ce9735fe08d7a8a::drand_lib::verify_drand_signature(arg1, arg2, arg0.round);
        arg0.status = 1;
        let v0 = 0x7b8368820ad59f241962f0f5890e7de024d1141f38651d055ce9735fe08d7a8a::drand_lib::derive_randomness(arg1);
        let v1 = 0;
        let v2;
        let v3;
        loop {
            v1 = v1 + 1;
            let v4 = 0x1::vector::length<address>(&arg0.participants);
            0x1::vector::swap<address>(&mut arg0.participants, 0x7b8368820ad59f241962f0f5890e7de024d1141f38651d055ce9735fe08d7a8a::drand_lib::safe_selection(v4, &v0, 0), v4 - 1);
            v2 = 0x1::vector::pop_back<address>(&mut arg0.participants);
            0x1::vector::push_back<address>(&mut arg0.winners, v2);
            v3 = 0x1::vector::pop_back<T0>(&mut arg0.reward_nfts);
            if (v1 < arg0.winnerCount) {
                0x2::transfer::public_transfer<T0>(v3, v2);
            } else {
                break
            };
        };
        0x2::transfer::public_transfer<T0>(v3, v2);
    }

    // decompiled from Move bytecode v6
}

