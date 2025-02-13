module 0x8fd17a5fe414eb862b9f5efb2f12f2ab148f1afb9da54a4337ee755efcd03fb3::dynamic_nft {
    struct DYNAMIC_NFT has drop {
        dummy_field: bool,
    }

    struct DynamicNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        last_switch: u64,
        current_image: u8,
    }

    struct ImageSwitchEvent has copy, drop {
        nft_id: 0x2::object::ID,
        new_image: u8,
        timestamp: u64,
    }

    public fun can_switch(arg0: &DynamicNFT, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.last_switch + 300000
    }

    public fun get_image_url(arg0: &DynamicNFT) : 0x1::string::String {
        if (arg0.current_image == 0) {
            0x1::string::utf8(b"https://cdn.discordapp.com/attachments/929825538527334456/1339410247676071946/PM112.png?ex=67ae9e80&is=67ad4d00&hm=74fccb24cad9a3a62085f05adff37b25a6dcc22eb78356fbcedba2bb6efd9369&")
        } else {
            0x1::string::utf8(b"https://cdn.discordapp.com/attachments/1295099562121494571/1332076854739210270/MagicEraser_250123_113934.png?ex=67ae4ebe&is=67acfd3e&hm=4531d4760cbfe1de8b6dd98b7ad9c74473b958b6a3c1da4e825ce011f0a41c1f&")
        }
    }

    fun init(arg0: DYNAMIC_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DYNAMIC_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<DynamicNFT>(&v0, arg1);
        0x2::display::add<DynamicNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<DynamicNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<DynamicNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<DynamicNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DynamicNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DynamicNFT{
            id            : 0x2::object::new(arg1),
            name          : 0x1::string::utf8(b"Dynamic NFT"),
            description   : 0x1::string::utf8(b"An NFT that switches between two images every 5 minutes"),
            last_switch   : 0x2::clock::timestamp_ms(arg0),
            current_image : 0,
        };
        0x2::transfer::transfer<DynamicNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun switch_image(arg0: &mut DynamicNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_switch + 300000, 0);
        let v1 = if (arg0.current_image == 0) {
            1
        } else {
            0
        };
        arg0.current_image = v1;
        arg0.last_switch = v0;
        let v2 = ImageSwitchEvent{
            nft_id    : 0x2::object::uid_to_inner(&arg0.id),
            new_image : arg0.current_image,
            timestamp : v0,
        };
        0x2::event::emit<ImageSwitchEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

