module 0x5cda0cbbbf309ae32ee89a229ba063df4de442e6e864a3c6c9792386d354daf6::mynft {
    struct MYNFT has drop {
        dummy_field: bool,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MyNFT_Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        collection: 0x2::object::ID,
        url: 0x2::url::Url,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        receiver: address,
    }

    public entry fun delete_nft(arg0: MyNFT) {
        let MyNFT {
            id          : v0,
            name        : _,
            description : _,
            collection  : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT_Collection{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"do0x0ob_collection"),
            description : 0x1::string::utf8(b"This is a test collection"),
            url         : 0x2::url::new_unsafe(0x1::ascii::string(b"https://github.com/do0x0ob")),
        };
        let v1 = MintCap<MYNFT>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap<MYNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MyNFT_Collection>(v0);
    }

    public entry fun mint_nft(arg0: &MintCap<MYNFT>, arg1: &MyNFT_Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id          : 0x2::object::new(arg4),
            name        : arg2,
            description : arg3,
            collection  : 0x2::object::uid_to_inner(&arg1.id),
            url         : 0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/153002627?v=4")),
        };
        let v1 = MintEvent{
            nft_id   : 0x2::object::uid_to_inner(&v0.id),
            receiver : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<MyNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

