module 0xc84e985891fa40469fbda2475566b75554ad761681bcc5ad695e95d86afc27b5::volo_galxe_campaign {
    struct VOLO_GALXE_CAMPAIGN has drop {
        dummy_field: bool,
    }

    struct Volo_Galxe_Campaign has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
        urls: vector<vector<u8>>,
    }

    public fun transfer(arg0: Volo_Galxe_Campaign, arg1: address) {
        0x2::transfer::transfer<Volo_Galxe_Campaign>(arg0, arg1);
    }

    public fun url(arg0: &Volo_Galxe_Campaign) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: Volo_Galxe_Campaign, arg1: &mut 0x2::tx_context::TxContext) {
        let Volo_Galxe_Campaign {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Volo_Galxe_Campaign) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: VOLO_GALXE_CAMPAIGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::package::claim<VOLO_GALXE_CAMPAIGN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Volo_Galxe_Campaign>(&v4, v0, v2, arg1);
        0x2::display::update_version<Volo_Galxe_Campaign>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Volo_Galxe_Campaign>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v6, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-10-20/redpvidvpfdn1vjm632q-8CLCZdZDrjGTe5dA7HEcZxQBuOQQ6U");
        0x1::vector::push_back<vector<u8>>(&mut v6, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-10-20/ewamxjprgdfaw67tik87-nZfNaHLbqwzHpUMrJU5c175QbDSRqR");
        0x1::vector::push_back<vector<u8>>(&mut v6, b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/uploads/2025-10-20/iquot9cpjhtq5tz4rblq-CgXxTnBBQnIvtLjRniZKGYfWrMzbxp");
        let v7 = MinterCap{
            id   : 0x2::object::new(arg1),
            urls : v6,
        };
        let v8 = 0;
        while (v8 < 3) {
            let v9 = 0x2::tx_context::sender(arg1);
            mint(&v7, v9, v8, arg1);
            v8 = v8 + 1;
        };
        0x2::transfer::public_transfer<MinterCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &MinterCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 3, 0);
        let v0 = Volo_Galxe_Campaign{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Volo Galxe Campaign NFT"),
            description : 0x1::string::utf8(b"3x different NFTs, Gold, Silver and Bronze for Volo Galxe Campaign"),
            url         : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg0.urls, arg2)),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<Volo_Galxe_Campaign>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<Volo_Galxe_Campaign>(v0, arg1);
    }

    public fun name(arg0: &Volo_Galxe_Campaign) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

