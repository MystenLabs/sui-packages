module 0x64821b2e26d21bdde9fe266387721ddb4509dcf201363b6d2dc4ec13b0d26ac1::draw {
    struct Draw has store, key {
        id: 0x2::object::UID,
        owner: address,
        participants: vector<address>,
        enabled: bool,
    }

    struct DRAW has drop {
        dummy_field: bool,
    }

    struct Award_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    public fun add_participant(arg0: &mut Draw, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg0.participants, 0x2::tx_context::sender(arg1));
    }

    entry fun create_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::display::new_with_fields<Award_NFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<Award_NFT>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Award_NFT>>(v4, 0x2::tx_context::sender(arg1));
    }

    entry fun exec(arg0: &mut Draw, arg1: &0x2::random::Random, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg0.enabled == true, 1);
        let v0 = arg0.participants;
        let v1 = 0x2::random::new_generator(arg1, arg3);
        let v2 = *0x1::vector::borrow<address>(&v0, (0x2::random::generate_u64_in_range(&mut v1, 0, 0x1::vector::length<address>(&v0) - 1) as u64));
        0x2::dynamic_field::add<vector<u8>, address>(&mut arg0.id, b"winner", v2);
        mint_nft(b"Draw Award", b"Awarded NFT", *0x1::string::as_bytes(&arg2), v2, arg3);
        arg0.enabled = false;
    }

    fun init(arg0: DRAW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DRAW>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Award_NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
        };
        0x2::transfer::public_transfer<Award_NFT>(v0, arg3);
    }

    public fun new_draw(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Draw{
            id           : 0x2::object::new(arg1),
            owner        : 0x2::tx_context::sender(arg1),
            participants : arg0,
            enabled      : true,
        };
        0x2::transfer::share_object<Draw>(v0);
    }

    // decompiled from Move bytecode v6
}

