module 0xfdb10f1f945dabf92d38cce7a1fc6737e56465f229aa532f32a656a69859761::santa_mint_package {
    struct SantaNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct Admin has store {
        admin_address: address,
    }

    struct MintingControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        admin: Admin,
    }

    struct SANTA_MINT_PACKAGE has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: SantaNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SantaNft>(arg0, arg1);
    }

    public fun burn(arg0: SantaNft, arg1: &mut 0x2::tx_context::TxContext) {
        let SantaNft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SantaNft) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SantaNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SANTA_MINT_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Merry Christmas from coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CoinFever"));
        let v4 = 0x2::package::claim<SANTA_MINT_PACKAGE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SantaNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<SantaNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SantaNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Admin{admin_address: 0x2::tx_context::sender(arg1)};
        let v7 = MintingControl{
            id     : 0x2::object::new(arg1),
            paused : false,
            admin  : v6,
        };
        0x2::transfer::share_object<MintingControl>(v7);
    }

    fun is_admin(arg0: &MintingControl, arg1: address) : bool {
        arg0.admin.admin_address == arg1
    }

    public fun mint_to_address(arg0: &mut MintingControl, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 0);
        let v1 = SantaNft{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Santa Maniac"),
            description : 0x1::string::utf8(x"546865206a6f6c6c69657374204e465420746f206b69636b206f666620436f696e4665766572e28099732061697264726f7020736561736f6e212053616e7461e2809973206272696e67696e67206769667473e28094796f757220666972737420706f696e747320666f722074686520244541524e2061697264726f702e2053746172742074686520736561736f6e206f662077696e7320617420636f696e66657665722e6170702e204d65727279204368726973746d617320616e64206c6574207468652067616d657320626567696e21"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"QmbNs9eq9amzBmdiWPuDKR8ZLXredPsa3nYQ73AVANx6dh"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SantaNft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SantaNft>(v1, arg1);
    }

    public fun mint_to_sender(arg0: &mut MintingControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SantaNft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Santa Maniac"),
            description : 0x1::string::utf8(x"546865206a6f6c6c69657374204e465420746f206b69636b206f666620436f696e4665766572e28099732061697264726f7020736561736f6e212053616e7461e2809973206272696e67696e67206769667473e28094796f757220666972737420706f696e747320666f722074686520244541524e2061697264726f702e2053746172742074686520736561736f6e206f662077696e7320617420636f696e66657665722e6170702e204d65727279204368726973746d617320616e64206c6574207468652067616d657320626567696e21"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"QmbNs9eq9amzBmdiWPuDKR8ZLXredPsa3nYQ73AVANx6dh"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SantaNft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<SantaNft>(v1, v0);
    }

    public fun name(arg0: &SantaNft) : &0x1::string::String {
        &arg0.name
    }

    public fun pause(arg0: &mut MintingControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0);
        arg0.paused = true;
    }

    public fun unpause(arg0: &mut MintingControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

