module 0x2732bad529e84ff2e9f3f11f60269d829ef64ba218c7a2175b9b5e7ca3e261a4::gifted_box {
    struct GIFTED_BOX has drop {
        dummy_field: bool,
    }

    struct GiftBox has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        sender: address,
        is_claimed: bool,
    }

    struct ClaimerCap has store, key {
        id: 0x2::object::UID,
    }

    struct GiftVault has key {
        id: 0x2::object::UID,
    }

    struct GiftingRecord has copy, drop, store {
        gift_box_id: 0x2::object::ID,
        sender: address,
    }

    struct GiftingReceipt {
        gift_box_id: 0x2::object::ID,
    }

    struct GiftedBoxMint has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct GiftedBoxTransfer has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        sender: address,
        recipient: address,
    }

    struct GiftedBoxSend has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        sender: address,
        gift_box_sender: address,
        vault: address,
    }

    struct GiftedBoxClaimBySender has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        recipient: address,
        vault: address,
    }

    struct GiftedBoxClaimByClaimer has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        recipient: address,
        vault: address,
    }

    struct GiftedBoxDepositObject has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        object_id: 0x2::object::ID,
        sender: address,
    }

    struct GiftedBoxWithdrawObject has copy, drop {
        gift_box_id: 0x2::object::ID,
        name: 0x1::string::String,
        object_id: 0x2::object::ID,
        recipient: address,
    }

    fun transfer(arg0: GiftBox, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = GiftedBoxTransfer{
            gift_box_id : 0x2::object::uid_to_inner(&arg0.id),
            name        : arg0.name,
            sender      : 0x2::tx_context::sender(arg2),
            recipient   : arg1,
        };
        0x2::event::emit<GiftedBoxTransfer>(v0);
        0x2::transfer::transfer<GiftBox>(arg0, arg1);
    }

    public fun claim_by_claimer(arg0: &ClaimerCap, arg1: &mut GiftVault, arg2: 0x2::transfer::Receiving<GiftBox>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::receive<GiftBox>(&mut arg1.id, arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&v0.id, b"gifting_record"), 1);
        0x2::dynamic_field::remove<vector<u8>, GiftingRecord>(&mut v0.id, b"gifting_record");
        v0.is_claimed = true;
        let v1 = GiftedBoxClaimByClaimer{
            gift_box_id : 0x2::object::uid_to_inner(&v0.id),
            name        : v0.name,
            recipient   : arg3,
            vault       : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::event::emit<GiftedBoxClaimByClaimer>(v1);
        transfer(v0, arg3, arg4);
    }

    public entry fun claim_by_sender(arg0: &mut GiftVault, arg1: 0x2::transfer::Receiving<GiftBox>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::receive<GiftBox>(&mut arg0.id, arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&v0.id, b"gifting_record"), 1);
        let v1 = 0x2::dynamic_field::remove<vector<u8>, GiftingRecord>(&mut v0.id, b"gifting_record");
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(&v1.sender == &v2, 2);
        v0.is_claimed = true;
        let v3 = GiftedBoxClaimBySender{
            gift_box_id : 0x2::object::uid_to_inner(&v0.id),
            name        : v0.name,
            recipient   : 0x2::tx_context::sender(arg2),
            vault       : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<GiftedBoxClaimBySender>(v3);
        transfer(v0, 0x2::tx_context::sender(arg2), arg2);
    }

    public entry fun deposit<T0: store + key>(arg0: &GiftBox, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GiftedBoxDepositObject{
            gift_box_id : 0x2::object::uid_to_inner(&arg0.id),
            name        : arg0.name,
            object_id   : 0x2::object::id<T0>(&arg1),
            sender      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GiftedBoxDepositObject>(v0);
        0x2::transfer::public_transfer<T0>(arg1, 0x2::object::uid_to_address(&arg0.id));
    }

    public fun gift_vault_id(arg0: &GiftVault) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: GIFTED_BOX, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://link-sui.gifted.art/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://images-sui.gifted.art/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Gifted Experience of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gifted.art"));
        let v4 = 0x2::package::claim<GIFTED_BOX>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GiftBox>(&v4, v0, v2, arg1);
        0x2::display::update_version<GiftBox>(&mut v5);
        let v6 = ClaimerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ClaimerCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = GiftVault{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<GiftVault>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GiftBox>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : (GiftBox, GiftingReceipt) {
        let v0 = GiftBox{
            id         : 0x2::object::new(arg1),
            name       : arg0,
            sender     : 0x2::tx_context::sender(arg1),
            is_claimed : false,
        };
        let v1 = GiftedBoxMint{
            gift_box_id : 0x2::object::uid_to_inner(&v0.id),
            name        : arg0,
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<GiftedBoxMint>(v1);
        let v2 = GiftingReceipt{gift_box_id: 0x2::object::id<GiftBox>(&v0)};
        (v0, v2)
    }

    public fun send(arg0: &GiftVault, arg1: GiftBox, arg2: GiftingReceipt, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_claimed, 3);
        let GiftingReceipt { gift_box_id: v0 } = arg2;
        assert!(0x2::object::id<GiftBox>(&arg1) == v0, 4);
        let v1 = GiftingRecord{
            gift_box_id : 0x2::object::id<GiftBox>(&arg1),
            sender      : 0x2::tx_context::sender(arg4),
        };
        arg1.sender = arg3;
        let v2 = GiftedBoxSend{
            gift_box_id     : 0x2::object::uid_to_inner(&arg1.id),
            name            : arg1.name,
            sender          : 0x2::tx_context::sender(arg4),
            gift_box_sender : arg3,
            vault           : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<GiftedBoxSend>(v2);
        0x2::dynamic_field::add<vector<u8>, GiftingRecord>(&mut arg1.id, b"gifting_record", v1);
        let v3 = 0x2::object::id<GiftVault>(arg0);
        0x2::transfer::transfer<GiftBox>(arg1, 0x2::object::id_to_address(&v3));
    }

    public entry fun withdraw<T0: store + key>(arg0: &mut GiftBox, arg1: 0x2::transfer::Receiving<T0>, arg2: address) {
        let v0 = 0x2::transfer::public_receive<T0>(&mut arg0.id, arg1);
        let v1 = GiftedBoxWithdrawObject{
            gift_box_id : 0x2::object::uid_to_inner(&arg0.id),
            name        : arg0.name,
            object_id   : 0x2::object::id<T0>(&v0),
            recipient   : arg2,
        };
        0x2::event::emit<GiftedBoxWithdrawObject>(v1);
        0x2::transfer::public_transfer<T0>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

