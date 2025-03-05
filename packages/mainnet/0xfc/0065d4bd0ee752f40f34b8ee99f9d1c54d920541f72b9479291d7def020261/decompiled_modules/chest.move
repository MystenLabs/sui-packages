module 0x9ac9960933ef2266d1e19f275e5b8bd76033e704e8cc3faacf7ad69ba3e212cd::chest {
    struct AllocationNFT has store, key {
        id: 0x2::object::UID,
        img_url: 0x2::url::Url,
        token_uri: 0x2::url::Url,
        amount_invested: u128,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    struct CHEST has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: AllocationNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AllocationNFT>(arg0, arg1);
    }

    public fun burn(arg0: AllocationNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let AllocationNFT {
            id              : v0,
            img_url         : _,
            token_uri       : _,
            amount_invested : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CHEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Demonopol Allocation NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{token_uri}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Demonpol NFT representing the commitment"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://demonopol.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"@demonopol"));
        let v4 = 0x2::package::claim<CHEST>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AllocationNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<AllocationNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AllocationNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun invested_amount_of(arg0: &AllocationNFT) : u128 {
        arg0.amount_invested
    }

    public(friend) fun mint_to(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AllocationNFT{
            id              : 0x2::object::new(arg4),
            img_url         : 0x2::url::new_unsafe_from_bytes(arg1),
            token_uri       : 0x2::url::new_unsafe_from_bytes(arg2),
            amount_invested : arg3,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<AllocationNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<AllocationNFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

