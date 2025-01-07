module 0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::decom {
    struct DECOM has drop {
        dummy_field: bool,
    }

    struct DecomAdminCap has store, key {
        id: 0x2::object::UID,
        render_data: 0x1::string::String,
        owner_render_data: 0x1::string::String,
        authorized_resselers: 0x2::table::Table<address, bool>,
        ownership: 0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::CredenzaOwnership,
    }

    struct DecomToken has store, key {
        id: 0x2::object::UID,
        uri: 0x1::string::String,
    }

    struct DecomTokenMintedEvent has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        uri: 0x1::string::String,
    }

    struct DecomAdminCapCreatedEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public fun burn(arg0: DecomToken) {
        let DecomToken {
            id  : v0,
            uri : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun buy_decom_token<T0>(arg0: &0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::sellable::CredenzaSellableConfig<DECOM>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::sellable::accept_payment_coin<DECOM, T0>(arg0, arg1, arg2);
        let v0 = DecomToken{
            id  : 0x2::object::new(arg2),
            uri : 0x1::string::utf8(b""),
        };
        let v1 = DecomTokenMintedEvent{
            id        : 0x2::object::uid_to_inner(&v0.id),
            recipient : 0x2::tx_context::sender(arg2),
            uri       : v0.uri,
        };
        0x2::event::emit<DecomTokenMintedEvent>(v1);
        0x2::transfer::public_transfer<DecomToken>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: DECOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = DecomAdminCap{
            id                   : v0,
            render_data          : 0x1::string::utf8(b""),
            owner_render_data    : 0x1::string::utf8(b""),
            authorized_resselers : 0x2::table::new<address, bool>(arg1),
            ownership            : 0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::create_ownership(0x2::object::uid_to_inner(&v0), arg1),
        };
        0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::add_owner(&mut v1.ownership, 0x2::tx_context::sender(arg1));
        let v2 = DecomAdminCapCreatedEvent{id: 0x2::object::uid_to_inner(&v1.id)};
        0x2::event::emit<DecomAdminCapCreatedEvent>(v2);
        0x2::transfer::public_share_object<DecomAdminCap>(v1);
        let (_, v4) = 0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::sellable::create_config<DECOM>(arg0, arg1);
        0x2::transfer::public_share_object<0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::sellable::CredenzaSellableConfig<DECOM>>(v4);
    }

    public fun mint(arg0: &DecomAdminCap, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        let v0 = DecomToken{
            id  : 0x2::object::new(arg3),
            uri : arg2,
        };
        let v1 = DecomTokenMintedEvent{
            id        : 0x2::object::uid_to_inner(&v0.id),
            recipient : arg1,
            uri       : arg2,
        };
        0x2::event::emit<DecomTokenMintedEvent>(v1);
        0x2::transfer::public_transfer<DecomToken>(v0, arg1);
    }

    public fun set_authorized_reseller(arg0: &mut DecomAdminCap, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        if (0x2::table::contains<address, bool>(&arg0.authorized_resselers, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.authorized_resselers, arg1);
        };
        0x2::table::add<address, bool>(&mut arg0.authorized_resselers, arg1, arg2);
    }

    public fun write_owner_render_data(arg0: &mut DecomAdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        arg0.owner_render_data = arg1;
    }

    public fun write_render_data(arg0: &mut DecomAdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x9ce03dbe8c4033b0c634e33250ccc6031d08f5aeb870d86e48958d7ec4089016::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        arg0.render_data = arg1;
    }

    // decompiled from Move bytecode v6
}

