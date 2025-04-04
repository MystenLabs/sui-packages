module 0x6fe902a9dae9e77f4b9d876e032fc92cbd9803cc87127d9c1097034620179d3b::cat {
    struct CatNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        walrus_sui_object: 0x1::string::String,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CAT has drop {
        dummy_field: bool,
    }

    public entry fun add_balance(arg0: &mut CatNFT, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"img_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        let v4 = 0x2::package::claim<CAT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CatNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<CatNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CatNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::string::is_empty(&arg0), 0);
        assert!(!0x1::string::is_empty(&arg3), 1);
        let v0 = CatNFT{
            id                : 0x2::object::new(arg5),
            name              : arg0,
            description       : arg1,
            img_url           : arg2,
            walrus_blob_id    : arg3,
            walrus_sui_object : arg4,
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<CatNFT>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun withdraw_balance(arg0: &mut CatNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

