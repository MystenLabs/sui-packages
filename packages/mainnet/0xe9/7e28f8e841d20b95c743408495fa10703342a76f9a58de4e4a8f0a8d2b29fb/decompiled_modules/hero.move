module 0xe97e28f8e841d20b95c743408495fa10703342a76f9a58de4e4a8f0a8d2b29fb::hero {
    struct Control has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        is_open: bool,
        max_count: u64,
        cur_count: u64,
        mint_fee: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        list: vector<0x2::object::ID>,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        level: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    struct WithdrawEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public fun url(arg0: &Hero) : &0x2::url::Url {
        &arg0.url
    }

    entry fun burn(arg0: Hero) {
        let Hero {
            id          : v0,
            level       : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun check_level(arg0: u8) {
        assert!(arg0 == 10 || arg0 == 1, 202);
    }

    fun check_owner(arg0: &Control, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 103);
    }

    fun check_version(arg0: &Control) {
        assert!(arg0.version == 1, 201);
    }

    public fun description(arg0: &Hero) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Control{
            id        : 0x2::object::new(arg0),
            version   : 1,
            owner     : 0x2::tx_context::sender(arg0),
            is_open   : true,
            max_count : 1000,
            cur_count : 0,
            mint_fee  : 100000000,
            vault     : 0x2::balance::zero<0x2::sui::SUI>(),
            list      : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Control>(v0);
    }

    entry fun migrate_version(arg0: &mut Control, arg1: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 201);
        arg0.version = 1;
    }

    entry fun mint(arg0: &mut Control, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg0.is_open, 104);
        assert!(arg0.cur_count < arg0.max_count, 101);
        if (arg0.mint_fee > 0) {
            let v0 = arg0.mint_fee;
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 105);
            let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0));
            if (0x2::balance::value<0x2::sui::SUI>(&v1) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), 0x2::tx_context::sender(arg3));
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
            };
        } else if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v2 = Hero{
            id          : 0x2::object::new(arg3),
            level       : 10,
            name        : arg2,
            description : 0x1::string::utf8(b"Owlit Community"),
            url         : 0x2::url::new_unsafe_from_bytes(b""),
        };
        let v3 = MintNFTEvent{
            object_id : 0x2::object::id<Hero>(&v2),
            creator   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintNFTEvent>(v3);
        arg0.cur_count = arg0.cur_count + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.list, 0x2::object::id<Hero>(&v2));
        0x2::transfer::public_transfer<Hero>(v2, 0x2::tx_context::sender(arg3));
    }

    entry fun mint_to(arg0: &mut Control, arg1: 0x1::string::String, arg2: u8, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        check_level(arg2);
        assert!(arg0.cur_count < arg0.max_count, 101);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = Hero{
                id          : 0x2::object::new(arg4),
                level       : arg2,
                name        : arg1,
                description : 0x1::string::utf8(b"Owlit Community NFT"),
                url         : 0x2::url::new_unsafe_from_bytes(b""),
            };
            arg0.cur_count = arg0.cur_count + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.list, 0x2::object::id<Hero>(&v1));
            0x2::transfer::public_transfer<Hero>(v1, *0x1::vector::borrow<address>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public fun name(arg0: &Hero) : &0x1::string::String {
        &arg0.name
    }

    entry fun update_desciption(arg0: &mut Hero, arg1: 0x1::string::String) {
        arg0.description = arg1;
    }

    entry fun update_info(arg0: &mut Hero, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        arg0.name = arg1;
        arg0.description = arg2;
    }

    entry fun update_is_open(arg0: &mut Control, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.is_open = arg1;
    }

    entry fun update_max_count(arg0: &mut Control, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.max_count = arg1;
    }

    entry fun update_mint_fee(arg0: &mut Control, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        arg0.mint_fee = arg1;
    }

    entry fun update_name(arg0: &mut Hero, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    entry fun update_url(arg0: &mut Hero, arg1: vector<u8>) {
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    entry fun withdraw_valut(arg0: &mut Control, arg1: &mut 0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) > 0, 106);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg1), arg0.owner);
        let v1 = WithdrawEvent{
            recipient : arg0.owner,
            amount    : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

