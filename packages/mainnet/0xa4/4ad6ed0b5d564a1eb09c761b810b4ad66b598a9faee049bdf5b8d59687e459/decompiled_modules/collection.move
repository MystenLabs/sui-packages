module 0xa44ad6ed0b5d564a1eb09c761b810b4ad66b598a9faee049bdf5b8d59687e459::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct EyeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted: u64,
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id     : 0x2::object::new(arg1),
            minted : 0,
        };
        let v1 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v2 = 0x2::display::new<EyeNFT>(&v1, arg1);
        0x2::display::add<EyeNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EyeNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EyeNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<EyeNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EyeNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Collection>(v0);
    }

    public entry fun mint(arg0: &mut Collection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EyeNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Mystic Eye"),
            description : 0x1::string::utf8(b"A mystical eye that sees beyond reality"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"ipfs://QmQgn98dLkHve7YdW3cDk11J1zheq1sBt9QMuRuUg6b2BS"),
        };
        arg0.minted = arg0.minted + 1;
        0x2::transfer::transfer<EyeNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

