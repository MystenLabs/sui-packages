module 0x70b84b9a78859da8154061e87d5ed8e8fdf5188f6c7a2532fb102e6786eb7c39::team {
    struct Team has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        lineup: vector<vector<Member>>,
        win: u64,
        lose: u64,
        quit: u64,
    }

    struct Member has store, key {
        id: 0x2::object::UID,
        nft_info: NftInfo,
        status: 0x70b84b9a78859da8154061e87d5ed8e8fdf5188f6c7a2532fb102e6786eb7c39::status::Status,
    }

    struct NftInfo has store {
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        nft_name: 0x1::string::String,
        nft_img: 0x1::string::String,
    }

    entry fun create_team(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Team{
            id     : 0x2::object::new(arg1),
            name   : arg0,
            lineup : 0x1::vector::empty<vector<Member>>(),
            win    : 0,
            lose   : 0,
            quit   : 0,
        };
        0x2::transfer::transfer<Team>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

