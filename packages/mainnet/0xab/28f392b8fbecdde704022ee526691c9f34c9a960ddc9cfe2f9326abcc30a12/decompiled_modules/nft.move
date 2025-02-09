module 0xab28f392b8fbecdde704022ee526691c9f34c9a960ddc9cfe2f9326abcc30a12::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct BlackSquidJumpingNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        list: u8,
        row: u8,
        playing: bool,
        award: u64,
        history_data: vector<vector<u8>>,
    }

    struct MintedVecSet has key {
        id: 0x2::object::UID,
        vec_set: 0x2::vec_set::VecSet<address>,
    }

    public fun transfer(arg0: &mut MintedVecSet, arg1: BlackSquidJumpingNFT, arg2: address, arg3: &0x2::tx_context::TxContext) {
        if (arg2 != 0x2::tx_context::sender(arg3)) {
            let v0 = 0x2::tx_context::sender(arg3);
            0x2::vec_set::remove<address>(&mut arg0.vec_set, &v0);
            0x2::vec_set::insert<address>(&mut arg0.vec_set, arg2);
        };
        0x2::transfer::transfer<BlackSquidJumpingNFT>(arg1, arg2);
    }

    public fun burn(arg0: &mut MintedVecSet, arg1: BlackSquidJumpingNFT, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::vec_set::remove<address>(&mut arg0.vec_set, &v0);
        let BlackSquidJumpingNFT {
            id           : v1,
            name         : _,
            image_url    : _,
            list         : _,
            row          : _,
            playing      : _,
            award        : _,
            history_data : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun get_award(arg0: &BlackSquidJumpingNFT) : u64 {
        arg0.award
    }

    public fun get_info(arg0: &BlackSquidJumpingNFT) : (u8, u8, u64) {
        (arg0.list, arg0.row, arg0.award)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/zcy1024/BlackSquid-Jumping"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Good Luck! Have Fun!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://github.com/zcy1024/BlackSquid-Jumping"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Debirth"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BlackSquidJumpingNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BlackSquidJumpingNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BlackSquidJumpingNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MintedVecSet{
            id      : 0x2::object::new(arg1),
            vec_set : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<MintedVecSet>(v6);
    }

    public fun is_playing(arg0: &BlackSquidJumpingNFT) : bool {
        arg0.playing
    }

    public fun mint(arg0: &mut MintedVecSet, arg1: &mut 0x2::tx_context::TxContext) : BlackSquidJumpingNFT {
        0x2::vec_set::insert<address>(&mut arg0.vec_set, 0x2::tx_context::sender(arg1));
        BlackSquidJumpingNFT{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"BlackSquidJumpingNFT"),
            image_url    : 0x1::string::utf8(b"https://github.com/zcy1024/BlackSquid-Jumping/blob/main/public/NFT.gif?raw=true"),
            list         : 0,
            row          : 0,
            playing      : false,
            award        : 0,
            history_data : vector[],
        }
    }

    public fun mint_and_keep(arg0: &mut MintedVecSet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1);
        0x2::transfer::transfer<BlackSquidJumpingNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun update(arg0: &mut BlackSquidJumpingNFT, arg1: u8, arg2: u8, arg3: bool, arg4: u64) {
        arg0.list = arg1;
        arg0.row = arg2;
        arg0.playing = arg3;
        arg0.award = arg4;
        if (arg1 == 0) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.history_data, b"");
        } else {
            0x1::vector::push_back<u8>(0x1::vector::borrow_mut<vector<u8>>(&mut arg0.history_data, 0x1::vector::length<vector<u8>>(&arg0.history_data) - 1), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

