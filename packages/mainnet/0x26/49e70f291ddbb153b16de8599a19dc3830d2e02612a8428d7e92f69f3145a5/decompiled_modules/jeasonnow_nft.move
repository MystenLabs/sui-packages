module 0x2649e70f291ddbb153b16de8599a19dc3830d2e02612a8428d7e92f69f3145a5::jeasonnow_nft {
    struct JEASONNOW_NFT has drop {
        dummy_field: bool,
    }

    struct JeasonnowNft has store, key {
        id: 0x2::object::UID,
        creator: address,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct JeasonnowNftMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: JeasonnowNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<JeasonnowNft>(arg0, arg1);
    }

    public entry fun burn(arg0: JeasonnowNft, arg1: &mut 0x2::tx_context::TxContext) {
        let JeasonnowNft {
            id          : v0,
            creator     : _,
            token_id    : _,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &JeasonnowNft) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &JeasonnowNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: JEASONNOW_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::package::claim<JEASONNOW_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<JeasonnowNft>(&v5, v1, v3, arg1);
        0x2::display::update_version<JeasonnowNft>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<JeasonnowNft>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<State>(v0);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut State, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        arg3.count = arg3.count + 1;
        let v1 = JeasonnowNft{
            id          : 0x2::object::new(arg4),
            creator     : v0,
            token_id    : arg3.count,
            name        : arg0,
            description : arg1,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = JeasonnowNftMinted{
            object_id : 0x2::object::id<JeasonnowNft>(&v1),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v1.name,
        };
        0x2::event::emit<JeasonnowNftMinted>(v2);
        0x2::transfer::transfer<JeasonnowNft>(v1, v0);
    }

    public fun name(arg0: &JeasonnowNft) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut JeasonnowNft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

