module 0x915627d54e237634379878786c9e68a98f51a27a5e020dc3f28b03c9af48e149::moruko_nft {
    struct MORUKO_NFT has drop {
        dummy_field: bool,
    }

    struct MorukoNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        recipient_name: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        object_id: address,
        recipient: address,
        recipient_name: 0x1::string::String,
    }

    public fun description(arg0: &MorukoNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &MorukoNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: MORUKO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MORUKO_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://moruko.ai"));
        let v5 = 0x2::display::new_with_fields<MorukoNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<MorukoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MorukoNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MorukoNFT{
            id             : 0x2::object::new(arg3),
            name           : 0x1::string::utf8(x"e381bee3819fe9818ae381b3e381bee38197e38288e38186efbc81"),
            description    : 0x1::string::utf8(x"6d6f72756b6fe3818be38289e381aee383a1e38383e382bbe383bce382b8e38082e38182e381aae3819fe381aee5a4a7e58887e381aae6809de38184e587bae38292e5b081e58db0e38197e381bee38197e3819fe38082"),
            image_url      : 0x2::url::new_unsafe_from_bytes(arg2),
            recipient_name : 0x1::string::utf8(arg1),
        };
        let v1 = MintEvent{
            object_id      : 0x2::object::uid_to_address(&v0.id),
            recipient      : arg0,
            recipient_name : v0.recipient_name,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::transfer<MorukoNFT>(v0, arg0);
    }

    public fun name(arg0: &MorukoNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun recipient_name(arg0: &MorukoNFT) : &0x1::string::String {
        &arg0.recipient_name
    }

    // decompiled from Move bytecode v7
}

