module 0x5f99ecf9a57a0a4e707936492eed0020469ea5efd02179a81b1c4246f78b0fd::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::ascii::String,
        question_id: 0x1::string::String,
        side: 0x1::string::String,
    }

    struct QuestionInfo has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        question_id: 0x1::string::String,
        yes_count: u64,
        no_count: u64,
        start_time: 0x1::string::String,
        end_time: 0x1::string::String,
    }

    struct Supply has key {
        id: 0x2::object::UID,
        nft_supply: u64,
        question_counter: u64,
    }

    struct Owner has key {
        id: 0x2::object::UID,
    }

    struct MembershipCap has key {
        id: 0x2::object::UID,
    }

    struct CollectionDetails has key {
        id: 0x2::object::UID,
    }

    struct QuestionValidity has store, key {
        id: 0x2::object::UID,
    }

    struct Pausable has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    struct MintNFTEvent has copy, drop {
        object_id: vector<0x2::object::ID>,
        creator: vector<address>,
        name: vector<0x1::string::String>,
    }

    struct BurnNFTEvent has copy, drop {
        object_id: vector<0x2::object::ID>,
    }

    struct PausedEvent has copy, drop {
        status: bool,
    }

    struct UnPausedEvent has copy, drop {
        status: bool,
    }

    struct NewMembershipEvent has copy, drop {
        user_address: address,
        member_id: 0x2::object::ID,
    }

    struct QuestionRegisterEvent has copy, drop {
        question: 0x1::string::String,
        question_id: 0x1::string::String,
        question_obj_id: 0x2::object::ID,
    }

    struct EditQuestionEvent has copy, drop {
        question_id: 0x2::object::ID,
    }

    struct NFTAdminCreatedEvent has copy, drop {
        admin: address,
    }

    struct NFTAdminChangedEvent has copy, drop {
        admin: address,
    }

    struct NFTOwnerChangedEvent has copy, drop {
        owner: address,
    }

    struct InitializeEvent has copy, drop {
        supply_id: 0x2::object::ID,
        collection_details_id: 0x2::object::ID,
        owner_id: 0x2::object::ID,
    }

    public entry fun batch_burn(arg0: vector<NFT>, arg1: &mut Supply, arg2: &mut CollectionDetails, arg3: &mut QuestionInfo) {
        assert!(!0x2::dynamic_object_field::borrow_mut<vector<u8>, Pausable>(&mut arg2.id, b"pausable").is_paused, 2);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<NFT>(&arg0)) {
            let NFT {
                id          : v1,
                name        : _,
                description : _,
                url         : _,
                question_id : v5,
                side        : v6,
            } = 0x1::vector::pop_back<NFT>(&mut arg0);
            let v7 = v6;
            let v8 = v1;
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::uid_to_inner(&v8));
            assert!(v5 == arg3.question_id, 1);
            let v9 = 0x1::string::utf8(b"o");
            if (0x1::string::index_of(&v7, &v9) == 1) {
                arg3.no_count = arg3.no_count - 1;
            } else {
                arg3.yes_count = arg3.yes_count - 1;
            };
            arg1.nft_supply = arg1.nft_supply - 1;
            0x2::object::delete(v8);
        };
        let v10 = BurnNFTEvent{object_id: v0};
        0x2::event::emit<BurnNFTEvent>(v10);
        0x1::vector::destroy_empty<NFT>(arg0);
    }

    public entry fun batch_mint(arg0: &mut MembershipCap, arg1: &mut CollectionDetails, arg2: &mut Supply, arg3: &mut QuestionInfo, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::ascii::String, arg7: bool, arg8: 0x1::string::String, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::borrow_mut<vector<u8>, Pausable>(&mut arg1.id, b"pausable").is_paused, 2);
        assert!(arg8 == arg3.question_id, 1);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = 0x1::vector::empty<0x1::string::String>();
        while (arg9 != 0) {
            0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg11));
            0x1::vector::push_back<0x1::string::String>(&mut v2, arg4);
            let v3 = if (arg7 == false) {
                arg3.no_count = arg3.no_count + 1;
                0x1::string::utf8(b"No")
            } else {
                arg3.yes_count = arg3.yes_count + 1;
                0x1::string::utf8(b"Yes")
            };
            let v4 = NFT{
                id          : 0x2::object::new(arg11),
                name        : arg4,
                description : arg5,
                url         : arg6,
                question_id : arg8,
                side        : v3,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::uid_to_inner(&v4.id));
            0x2::transfer::transfer<NFT>(v4, arg10);
            arg9 = arg9 - 1;
        };
        let v5 = MintNFTEvent{
            object_id : v0,
            creator   : v1,
            name      : v2,
        };
        0x2::event::emit<MintNFTEvent>(v5);
        arg2.nft_supply = arg2.nft_supply + arg9;
    }

    public entry fun change_admin(arg0: Admin, arg1: address) {
        0x2::transfer::transfer<Admin>(arg0, arg1);
        let v0 = NFTAdminChangedEvent{admin: arg1};
        0x2::event::emit<NFTAdminChangedEvent>(v0);
    }

    public entry fun change_owner(arg0: Owner, arg1: address) {
        0x2::transfer::transfer<Owner>(arg0, arg1);
        let v0 = NFTOwnerChangedEvent{owner: arg1};
        0x2::event::emit<NFTOwnerChangedEvent>(v0);
    }

    public entry fun create_admin(arg0: &Owner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<Admin>(v0, arg1);
        let v1 = NFTAdminCreatedEvent{admin: arg1};
        0x2::event::emit<NFTAdminCreatedEvent>(v1);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun edit_question(arg0: &Admin, arg1: &mut QuestionInfo, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        arg1.question = arg2;
        arg1.start_time = arg3;
        arg1.end_time = arg4;
        let v0 = EditQuestionEvent{question_id: 0x2::object::uid_to_inner(&arg1.id)};
        0x2::event::emit<EditQuestionEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Supply{
            id               : 0x2::object::new(arg0),
            nft_supply       : 0,
            question_counter : 0,
        };
        let v1 = Owner{id: 0x2::object::new(arg0)};
        let v2 = CollectionDetails{id: 0x2::object::new(arg0)};
        let v3 = Pausable{
            id        : 0x2::object::new(arg0),
            is_paused : false,
        };
        0x2::dynamic_object_field::add<vector<u8>, Pausable>(&mut v2.id, b"pausable", v3);
        let v4 = InitializeEvent{
            supply_id             : 0x2::object::uid_to_inner(&v0.id),
            collection_details_id : 0x2::object::uid_to_inner(&v2.id),
            owner_id              : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<InitializeEvent>(v4);
        0x2::transfer::share_object<Supply>(v0);
        0x2::transfer::transfer<Owner>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<CollectionDetails>(v2);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun nft_transfer(arg0: NFT, arg1: address, arg2: &mut CollectionDetails, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::borrow_mut<vector<u8>, Pausable>(&mut arg2.id, b"pausable").is_paused, 2);
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public entry fun pausable_button(arg0: &Admin, arg1: &mut CollectionDetails) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Pausable>(&mut arg1.id, b"pausable");
        if (v0.is_paused) {
            v0.is_paused = false;
            let v1 = PausedEvent{status: v0.is_paused};
            0x2::event::emit<PausedEvent>(v1);
        } else {
            v0.is_paused = true;
            let v2 = UnPausedEvent{status: v0.is_paused};
            0x2::event::emit<UnPausedEvent>(v2);
        };
    }

    public fun question_id(arg0: &NFT) : &0x1::string::String {
        &arg0.question_id
    }

    public entry fun question_register(arg0: &Admin, arg1: &mut Supply, arg2: &mut CollectionDetails, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg2.id, arg4), 0);
        let v0 = QuestionInfo{
            id          : 0x2::object::new(arg7),
            question    : arg3,
            question_id : arg4,
            yes_count   : 0,
            no_count    : 0,
            start_time  : arg5,
            end_time    : arg6,
        };
        let v1 = QuestionValidity{id: 0x2::object::new(arg7)};
        let v2 = QuestionRegisterEvent{
            question        : arg3,
            question_id     : arg4,
            question_obj_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<QuestionRegisterEvent>(v2);
        arg1.question_counter = arg1.question_counter + 1;
        0x2::dynamic_object_field::add<0x1::string::String, QuestionValidity>(&mut arg2.id, arg4, v1);
        0x2::transfer::share_object<QuestionInfo>(v0);
    }

    public entry fun set_membership(arg0: &Admin, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        while (v0 != 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            let v2 = MembershipCap{id: 0x2::object::new(arg2)};
            let v3 = NewMembershipEvent{
                user_address : v1,
                member_id    : 0x2::object::uid_to_inner(&v2.id),
            };
            0x2::event::emit<NewMembershipEvent>(v3);
            0x2::transfer::transfer<MembershipCap>(v2, v1);
            v0 = v0 - 1;
        };
    }

    public fun side(arg0: &NFT) : &0x1::string::String {
        &arg0.side
    }

    public fun total_supply(arg0: &Supply) : &u64 {
        &arg0.nft_supply
    }

    public fun url(arg0: &NFT) : &0x1::ascii::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

