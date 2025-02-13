module 0x99b614d737ea15bb858b07560983857f82452837d0f14aa0dfa40f13f857ab6a::dynamic_nft {
    struct DYNAMIC_NFT has drop {
        dummy_field: bool,
    }

    struct DynamicNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        last_switch: u64,
        current_image: u8,
        url: 0x1::string::String,
    }

    struct NFTMintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
    }

    struct ImageSwitchEvent has copy, drop {
        nft_id: 0x2::object::ID,
        new_image: u8,
        timestamp: u64,
    }

    public fun can_switch(arg0: &DynamicNFT, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.last_switch + 10000
    }

    public fun get_current_image(arg0: &DynamicNFT) : u8 {
        arg0.current_image
    }

    public fun get_image_url(arg0: &DynamicNFT) : 0x1::string::String {
        arg0.url
    }

    fun init(arg0: DYNAMIC_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DYNAMIC_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<DynamicNFT>(&v0, arg1);
        0x2::display::add<DynamicNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DynamicNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DynamicNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<DynamicNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DynamicNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = DynamicNFT{
            id            : v1,
            name          : 0x1::string::utf8(b"Dynamic NFT"),
            description   : 0x1::string::utf8(b"An NFT that switches between two images every 10 seconds"),
            last_switch   : 0x2::clock::timestamp_ms(arg0),
            current_image : 0,
            url           : 0x1::string::utf8(b"https://storage.googleapis.com/nftimagebucket/tokens/0x69226261e908d24b0127ad890c467080fedd7090/TVRjeE5EUTNPRFU1T1E9PV8xODE4.png"),
        };
        let v3 = NFTMintedEvent{
            nft_id    : 0x2::object::uid_to_inner(&v1),
            recipient : v0,
        };
        0x2::event::emit<NFTMintedEvent>(v3);
        0x2::transfer::public_transfer<DynamicNFT>(v2, v0);
    }

    public entry fun switch_image(arg0: &mut DynamicNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_switch + 10000, 0);
        let v1 = if (arg0.current_image == 0) {
            1
        } else {
            0
        };
        arg0.current_image = v1;
        let v2 = if (arg0.current_image == 0) {
            0x1::string::utf8(b"https://storage.googleapis.com/nftimagebucket/tokens/0x69226261e908d24b0127ad890c467080fedd7090/TVRjeE5EUTNPRFU1T1E9PV8xODE4.png")
        } else {
            0x1::string::utf8(b"https://storage.googleapis.com/nftimagebucket/tokens/0x69226261e908d24b0127ad890c467080fedd7090/preview/TVRZNU5UQTVPVEEzTmc9PV80MQ==.png")
        };
        arg0.url = v2;
        arg0.last_switch = v0;
        let v3 = ImageSwitchEvent{
            nft_id    : 0x2::object::uid_to_inner(&arg0.id),
            new_image : arg0.current_image,
            timestamp : v0,
        };
        0x2::event::emit<ImageSwitchEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

