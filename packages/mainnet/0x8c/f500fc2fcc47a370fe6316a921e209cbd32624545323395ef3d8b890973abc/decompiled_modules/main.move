module 0x8cf500fc2fcc47a370fe6316a921e209cbd32624545323395ef3d8b890973abc::main {
    struct NFT has store, key {
        id: 0x2::object::UID,
        collection: u8,
        rarity: u8,
        price: u64,
    }

    public entry fun buy_nft(arg0: NFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<NFT>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

