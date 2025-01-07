module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::cyberpills {
    struct CYBERPILLS has drop {
        dummy_field: bool,
    }

    struct Cyberpill has store, key {
        id: 0x2::object::UID,
        game_id: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct MintCapCyberpills has store, key {
        id: 0x2::object::UID,
        minting_limit: u64,
        minting_counter: u64,
    }

    struct CyberpillMinted has copy, drop {
        id: 0x2::object::ID,
        mint_cap_id: 0x2::object::ID,
        created_by: address,
    }

    struct MintCapCyberpillCreated has copy, drop {
        id: 0x2::object::ID,
        authorizer: address,
        minting_limit: u64,
    }

    public fun authorize_address(arg0: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCapCyberpills{
            id              : 0x2::object::new(arg3),
            minting_limit   : arg1,
            minting_counter : 0,
        };
        let v1 = MintCapCyberpillCreated{
            id            : 0x2::object::id<MintCapCyberpills>(&v0),
            authorizer    : 0x2::tx_context::sender(arg3),
            minting_limit : arg1,
        };
        0x2::event::emit<MintCapCyberpillCreated>(v1);
        0x2::transfer::transfer<MintCapCyberpills>(v0, arg2);
    }

    public fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"game_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{game_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cyberpill to mutate your Panzerdog with."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.panzerdogs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmZdcLXk1zvLAYCEsXBX8pZyimThWVGMscSnrBbbB154xd/{game_id}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<Cyberpill>(arg0, v0, v2, arg1);
        0x2::display::update_version<Cyberpill>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Cyberpill>>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: CYBERPILLS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CYBERPILLS>(arg0, arg1);
    }

    public fun mint(arg0: &mut MintCapCyberpills, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = Cyberpill{
            id      : 0x2::object::new(arg4),
            game_id : arg1,
            name    : arg2,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = CyberpillMinted{
            id          : 0x2::object::id<Cyberpill>(&v0),
            mint_cap_id : 0x2::object::id<MintCapCyberpills>(arg0),
            created_by  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CyberpillMinted>(v1);
        0x2::transfer::public_transfer<Cyberpill>(v0, arg3);
    }

    public fun mint_ptb(arg0: &mut MintCapCyberpills, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Cyberpill {
        assert!(arg0.minting_counter < arg0.minting_limit, 0);
        let v0 = Cyberpill{
            id      : 0x2::object::new(arg3),
            game_id : arg1,
            name    : arg2,
        };
        arg0.minting_counter = arg0.minting_counter + 1;
        let v1 = CyberpillMinted{
            id          : 0x2::object::id<Cyberpill>(&v0),
            mint_cap_id : 0x2::object::id<MintCapCyberpills>(arg0),
            created_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CyberpillMinted>(v1);
        v0
    }

    public(friend) fun uid_mut(arg0: &mut Cyberpill) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun update_display_image(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::display::Display<Cyberpill>) {
        assert!(0x2::display::is_authorized<Cyberpill>(arg0), 1);
        0x2::display::edit<Cyberpill>(arg2, 0x1::string::utf8(b"image_url"), arg1);
        0x2::display::update_version<Cyberpill>(arg2);
    }

    // decompiled from Move bytecode v6
}

