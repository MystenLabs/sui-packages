module 0x71889363daef4a48ed78b7dbda45ef1aad124eeaa63aa882a6ee2541162086d6::mermaid {
    struct MERMAID has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct MermaidMintedEvent has copy, drop {
        id: 0x2::object::ID,
        id_number: u64,
    }

    struct Mermaid has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        id_number: u64,
    }

    public fun get_description(arg0: &Mermaid) : 0x1::string::String {
        arg0.description
    }

    public fun get_name(arg0: &Mermaid) : 0x1::string::String {
        arg0.name
    }

    public fun get_url(arg0: &Mermaid) : 0x2::url::Url {
        arg0.image_url
    }

    fun init(arg0: MERMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{id_number}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}/{id_number}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<MERMAID>(arg0, arg1);
        0x71889363daef4a48ed78b7dbda45ef1aad124eeaa63aa882a6ee2541162086d6::collection::display(&v4, arg1);
        let v5 = 0x2::display::new_with_fields<Mermaid>(&v4, v0, v2, arg1);
        0x2::display::update_version<Mermaid>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<Mermaid>(&v4, arg1);
        let v8 = v7;
        let v9 = v6;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Mermaid>(&mut v9, &v8, 500, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Mermaid>(&mut v9, &v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Mermaid>(&mut v9, &v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Mermaid>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Mermaid>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Mermaid>>(v9);
        0x2::transfer::public_share_object<0x71889363daef4a48ed78b7dbda45ef1aad124eeaa63aa882a6ee2541162086d6::collection::Collection>(0x71889363daef4a48ed78b7dbda45ef1aad124eeaa63aa882a6ee2541162086d6::collection::new(arg1));
    }

    public(friend) fun mint_nft(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Mermaid {
        let v0 = Mermaid{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"AtlanSui Mermaid"),
            description : 0x1::string::utf8(b"AtlanSui NFT."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://bafybeieawbqes2l2ca6dhpz7mqmbztmno4k5o2fuwbqeufvp7rnku4jn3m.ipfs.nftstorage.link"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://atlansui.xyz/"),
            id_number   : arg0,
        };
        let v1 = MermaidMintedEvent{
            id        : 0x2::object::id<Mermaid>(&v0),
            id_number : arg0,
        };
        0x2::event::emit<MermaidMintedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

