module 0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::items_credential {
    struct GameItemsCredential has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        num: u64,
    }

    struct ITEMS_CREDENTIAL has drop {
        dummy_field: bool,
    }

    public(friend) fun construct(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : GameItemsCredential {
        GameItemsCredential{
            id   : 0x2::object::new(arg2),
            name : arg0,
            num  : arg1,
        }
    }

    public(friend) fun destruct(arg0: GameItemsCredential) : (0x1::string::String, u64) {
        let GameItemsCredential {
            id   : v0,
            name : v1,
            num  : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    fun init(arg0: ITEMS_CREDENTIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Boat ticket to meta masrs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeibzoi4kzr4gg75zhso5jespxnwespyfyakemrwibqorjczkn23vpi.ipfs.nftstorage.link/NFT-CARD1.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metaGame"));
        let v4 = 0x2::package::claim<ITEMS_CREDENTIAL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GameItemsCredential>(&v4, v0, v2, arg1);
        0x2::display::update_version<GameItemsCredential>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GameItemsCredential>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

