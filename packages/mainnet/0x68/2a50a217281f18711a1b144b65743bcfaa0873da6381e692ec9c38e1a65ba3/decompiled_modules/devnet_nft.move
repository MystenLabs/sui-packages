module 0x682a50a217281f18711a1b144b65743bcfaa0873da6381e692ec9c38e1a65ba3::devnet_nft {
    struct DEVNET_NFT has drop {
        dummy_field: bool,
    }

    struct DevNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
        maxCount: u64,
    }

    public fun description(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &DevNetNFT) : &0x2::url::Url {
        &arg0.img_url
    }

    fun init(arg0: DEVNET_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = Counter{
            id       : 0x2::object::new(arg1),
            count    : 0,
            maxCount : 2,
        };
        let v5 = 0x2::package::claim<DEVNET_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<DevNetNFT>(&v5, v0, v2, arg1);
        0x2::display::update_version<DevNetNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DevNetNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Counter>(v4);
    }

    public entry fun mint10(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.count <= arg0.maxCount, 0);
        let v0 = DevNetNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiDoge"),
            description : 0x1::string::utf8(b"NFT is our Non-Fungible Token, equivalent to an pass card, and having an NFT owns half of SuiDoge's tokens. In the later stage, attributes such as pledge and voting governance will be developed. In short, his value is infinite, we take in the very beginning to realize him, which shows that he is very important"),
            img_url     : 0x2::url::new_unsafe_from_bytes(b"https://suidoge.dog/sui/suidogenft.png"),
        };
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<DevNetNFT>(v0, v1);
        arg0.count = arg0.count + 1;
    }

    public fun name(arg0: &DevNetNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

