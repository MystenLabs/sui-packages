module 0xcfd244abb9e57cd84788a4394c772d69dcde6c80c3458d7287e87735ef820239::nftwallet {
    struct ArchiveBox has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        owner: address,
        nft_ids: vector<0x2::object::ID>,
    }

    struct CoinDeposited has copy, drop {
        wallet: 0x2::object::ID,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct NftDeposited has copy, drop {
        wallet: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct NftWithdrawn has copy, drop {
        wallet: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    public entry fun create_wallet(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ArchiveBox{
            id        : 0x2::object::new(arg1),
            name      : arg0,
            image_url : 0x1::string::utf8(b"https://raw.githubusercontent.com/0xmurphyf/TheArchive/main/public/archive-assets/memory-vial.png"),
            owner     : 0x2::tx_context::sender(arg1),
            nft_ids   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_transfer<ArchiveBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun deposit_coin(arg0: &mut ArchiveBox, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::object::uid_to_address(&arg0.id));
        let v0 = CoinDeposited{
            wallet    : 0x2::object::uid_to_inner(&arg0.id),
            coin_type : 0x1::string::utf8(b"0x2::sui::SUI"),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<CoinDeposited>(v0);
    }

    public fun deposit_nft<T0: store + key>(arg0: &mut ArchiveBox, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.nft_ids, v0);
        let v1 = NftDeposited{
            wallet : 0x2::object::uid_to_inner(&arg0.id),
            nft_id : v0,
        };
        0x2::event::emit<NftDeposited>(v1);
    }

    public entry fun set_image_url(arg0: &mut ArchiveBox, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.image_url = arg1;
    }

    public entry fun transfer_wallet(arg0: ArchiveBox, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<ArchiveBox>(arg0, arg1);
    }

    public fun withdraw_coin<T0>(arg0: &mut ArchiveBox, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg0.owner);
    }

    public fun withdraw_nft<T0: store + key>(arg0: &mut ArchiveBox, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.nft_ids, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(&mut arg0.nft_ids, v0);
                break
            };
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), arg0.owner);
        let v1 = NftWithdrawn{
            wallet : 0x2::object::uid_to_inner(&arg0.id),
            nft_id : arg1,
        };
        0x2::event::emit<NftWithdrawn>(v1);
    }

    public fun withdraw_sui(arg0: &mut ArchiveBox, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), arg0.owner);
    }

    // decompiled from Move bytecode v7
}

