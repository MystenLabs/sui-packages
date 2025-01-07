module 0x85352400feb032201f769d1ebf0a48d53d086d89cde5267bb670878e724d5e96::greets {
    struct PostCardMetaData has drop, store {
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
        message: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        amount: u64,
        max_count: u64,
        minter: vector<address>,
    }

    struct PostCard has key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        message: 0x1::string::String,
        name: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        amount: u64,
    }

    struct GREETS has drop {
        dummy_field: bool,
    }

    struct ReceivablePostCardsList has key {
        id: 0x2::object::UID,
        receivable_post_card_list: 0x2::table::Table<vector<u8>, PostCardMetaData>,
    }

    struct PostCardEvent has copy, drop {
        object_id: 0x2::object::ID,
        receiver: address,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_owner: address,
    }

    struct TreasuryCap has key {
        id: 0x2::object::UID,
        treasury: 0x2::object::ID,
    }

    public fun balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun claim_receivable_card(arg0: &mut Treasury, arg1: &mut ReceivablePostCardsList, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::hash::sha2_256(arg2);
        assert!(0x2::table::contains<vector<u8>, PostCardMetaData>(&arg1.receivable_post_card_list, v0), 1);
        let v1 = 0x2::table::borrow_mut<vector<u8>, PostCardMetaData>(&mut arg1.receivable_post_card_list, v0);
        let v2 = PostCard{
            id            : 0x2::object::new(arg3),
            image_url     : v1.image_url,
            description   : v1.description,
            message       : v1.message,
            name          : v1.name,
            thumbnail_url : v1.thumbnail_url,
            project_url   : v1.project_url,
            creator       : v1.creator,
            amount        : v1.amount,
        };
        let v3 = 0x2::tx_context::sender(arg3);
        if (v1.amount > 0) {
            assert!(v1.max_count != 0, 4);
            assert!(0x1::vector::contains<address>(&v1.minter, &v3) == false, 3);
            v1.max_count = v1.max_count - 1;
            0x1::vector::push_back<address>(&mut v1.minter, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1.amount, arg3), v3);
        } else {
            0x2::table::remove<vector<u8>, PostCardMetaData>(&mut arg1.receivable_post_card_list, v0);
        };
        let v4 = PostCardEvent{
            object_id : 0x2::object::uid_to_inner(&v2.id),
            receiver  : v3,
        };
        0x2::event::emit<PostCardEvent>(v4);
        0x2::transfer::transfer<PostCard>(v2, v3);
    }

    public entry fun create_receivable_card(arg0: &mut Treasury, arg1: &mut ReceivablePostCardsList, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg7 > 0) {
            assert!(0x2::tx_context::sender(arg9) == treasury_owner(arg0), 2);
        };
        let v0 = PostCardMetaData{
            image_url     : arg4,
            description   : arg3,
            name          : arg6,
            message       : arg5,
            thumbnail_url : arg4,
            project_url   : 0x1::string::utf8(b"https://sendmypaper.art/"),
            creator       : 0x1::string::utf8(b"paperGreets"),
            amount        : arg7,
            max_count     : arg8,
            minter        : 0x1::vector::empty<address>(),
        };
        0x2::table::add<vector<u8>, PostCardMetaData>(&mut arg1.receivable_post_card_list, arg2, v0);
    }

    public entry fun create_treasury(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) > 0, 0);
        let v0 = Treasury{
            id             : 0x2::object::new(arg1),
            balance        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            treasury_owner : 0x2::tx_context::sender(arg1),
        };
        let v1 = TreasuryCap{
            id       : 0x2::object::new(arg1),
            treasury : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun deposit_coin_into_treasury(arg0: &mut TreasuryCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Treasury) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        assert!(arg0.treasury == 0x2::object::id<Treasury>(arg2), 5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.balance, arg1);
    }

    fun init(arg0: GREETS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"message"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{message}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<GREETS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PostCard>(&v4, v0, v2, arg1);
        0x2::display::update_version<PostCard>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PostCard>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ReceivablePostCardsList{
            id                        : 0x2::object::new(arg1),
            receivable_post_card_list : 0x2::table::new<vector<u8>, PostCardMetaData>(arg1),
        };
        0x2::transfer::share_object<ReceivablePostCardsList>(v6);
    }

    public entry fun remove_from_table(arg0: &mut Treasury, arg1: &mut ReceivablePostCardsList, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == treasury_owner(arg0), 2);
        let v0 = 0x1::hash::sha2_256(arg2);
        assert!(0x2::table::contains<vector<u8>, PostCardMetaData>(&mut arg1.receivable_post_card_list, v0), 1);
        0x2::table::remove<vector<u8>, PostCardMetaData>(&mut arg1.receivable_post_card_list, v0);
    }

    public fun treasury_owner(arg0: &Treasury) : address {
        arg0.treasury_owner
    }

    public entry fun withdraw_from_treasury(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == treasury_owner(arg0), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, balance(arg0), arg1), arg0.treasury_owner);
    }

    // decompiled from Move bytecode v6
}

