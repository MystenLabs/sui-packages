module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::merch {
    struct MERCH has drop {
        dummy_field: bool,
    }

    struct Merch has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct MintCapMerch has store, key {
        id: 0x2::object::UID,
        minting_limit: u64,
        minting_counter: u64,
    }

    struct MerchMinted has copy, drop {
        id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        created_by: address,
    }

    struct MintCapMerchCreated has copy, drop {
        id: 0x2::object::ID,
        authorizer: address,
        minting_limit: u64,
    }

    public fun authorize_address(arg0: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCapMerch{
            id              : 0x2::object::new(arg3),
            minting_limit   : arg1,
            minting_counter : 0,
        };
        let v1 = MintCapMerchCreated{
            id            : 0x2::object::id<MintCapMerch>(&v0),
            authorizer    : 0x2::tx_context::sender(arg3),
            minting_limit : arg1,
        };
        0x2::event::emit<MintCapMerchCreated>(v1);
        0x2::transfer::transfer<MintCapMerch>(v0, arg2);
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmSyCbY1yQ9QuDdmFcffBjNxk2cSYYdAALmXm9b2yLMez6/{type}/{game_id}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<Merch>(arg0, v0, v2, arg1);
        0x2::display::update_version<Merch>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Merch>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: MERCH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MERCH>(arg0, arg1);
    }

    public fun mint(arg0: &mut MintCapMerch, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = Merch{
            id      : 0x2::object::new(arg5),
            game_id : arg1,
            name    : arg2,
            type    : arg3,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = MerchMinted{
            id          : 0x2::object::id<Merch>(&v0),
            mint_cap_id : 0x2::object::id<MintCapMerch>(arg0),
            created_by  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MerchMinted>(v1);
        0x2::transfer::public_transfer<Merch>(v0, arg4);
    }

    public fun mint_ptb(arg0: &mut MintCapMerch, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Merch {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = Merch{
            id      : 0x2::object::new(arg4),
            game_id : arg1,
            name    : arg2,
            type    : arg3,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = MerchMinted{
            id          : 0x2::object::id<Merch>(&v0),
            mint_cap_id : 0x2::object::id<MintCapMerch>(arg0),
            created_by  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MerchMinted>(v1);
        v0
    }

    public(friend) fun uid_mut(arg0: &mut Merch) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun update_display_image(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Merch>) {
        assert!(0x2::display::is_authorized<Merch>(arg0), 1);
        0x2::display::edit<Merch>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Merch>(arg2);
    }

    // decompiled from Move bytecode v6
}

