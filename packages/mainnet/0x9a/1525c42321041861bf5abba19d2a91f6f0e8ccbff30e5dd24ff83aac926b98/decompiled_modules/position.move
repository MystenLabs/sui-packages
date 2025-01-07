module 0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::position {
    struct Position has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        farm: 0x2::object::ID,
        lp_nft: 0x2::object::ID,
        value: u64,
        create_time: u64,
    }

    struct POSITION has drop {
        dummy_field: bool,
    }

    public(friend) fun burn(arg0: Position) {
        let Position {
            id          : v0,
            pool        : _,
            farm        : _,
            lp_nft      : _,
            value       : _,
            create_time : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_farm_id(arg0: &Position) : 0x2::object::ID {
        arg0.farm
    }

    public fun get_lp_nft_id(arg0: &Position) : 0x2::object::ID {
        arg0.lp_nft
    }

    public fun get_pool_id(arg0: &Position) : 0x2::object::ID {
        arg0.pool
    }

    public fun get_position_time(arg0: &Position) : u64 {
        arg0.create_time
    }

    public fun get_value(arg0: &Position) : u64 {
        arg0.value
    }

    fun init(arg0: POSITION, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Coral's Position NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coral.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmTxRsWbrLG6mkjg375wW77Lfzm38qsUQjRBj3b2K3t8q1?filename=Turbos_nft.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"An NFT created by Coral Vault"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coral.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Coral Team"));
        let v4 = 0x2::package::claim<POSITION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Position>(&v4, v0, v2, arg1);
        0x2::display::update_version<Position>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Position>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Position {
        Position{
            id          : 0x2::object::new(arg5),
            pool        : arg0,
            farm        : arg1,
            lp_nft      : arg2,
            value       : arg3,
            create_time : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

