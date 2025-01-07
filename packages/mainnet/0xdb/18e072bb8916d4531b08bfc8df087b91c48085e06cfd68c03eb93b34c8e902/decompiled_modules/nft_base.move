module 0xdb18e072bb8916d4531b08bfc8df087b91c48085e06cfd68c03eb93b34c8e902::nft_base {
    struct NftBase has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct NFT_BASE has drop {
        dummy_field: bool,
    }

    struct ShareObject has store, key {
        id: 0x2::object::UID,
        current_supply: u64,
        total_supply: u64,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    fun init(arg0: NFT_BASE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CryptoPunks launched as a fixed set of 10,000 items in mid-2017 and became one of the inspirations for the SUI NFT. They have been featured in places like The New York Times, Christie's of London, Art|Basel Miami, and The PBS NewsHour."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cryptopunks.app/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Crypto Punk"));
        let v4 = 0x2::package::claim<NFT_BASE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NftBase>(&v4, v0, v2, arg1);
        0x2::display::update_version<NftBase>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NftBase>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ShareObject{
            id             : 0x2::object::new(arg1),
            current_supply : 0,
            total_supply   : 9999,
        };
        0x2::transfer::share_object<ShareObject>(v6);
    }

    public entry fun mint(arg0: &mut ShareObject, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(@0x79808328ebf3da4312b32faad4da1f77f6fdea00d7c72f3b1dbf75e7d06b8853 == v0, 5);
        while (arg1 > 0) {
            let v1 = arg0.current_supply;
            assert!(v1 < 9999, 1);
            let v2 = 0x1::string::utf8(b"Crypto Punk #");
            let v3 = num_str(v1);
            0x1::string::append(&mut v2, v3);
            let v4 = 0x1::string::utf8(b"ipfs://QmNSUHb6A4x21yoAdhyYXLWBj1951bsyrGy36BuqkU66HW/");
            0x1::string::append(&mut v4, v3);
            let v5 = 0x1::string::utf8(b"ipfs://QmUwMt5dnAbKJicTo8qGmjmhRyyzjH8s7bFRU8mDyE3k7n/");
            0x1::string::append(&mut v5, v3);
            0x1::string::append(&mut v5, 0x1::string::utf8(b".png"));
            let v6 = NftBase{
                id        : 0x2::object::new(arg3),
                name      : v2,
                img_url   : v5,
                url       : v4,
                image_url : v5,
            };
            let v7 = MintNFTEvent{
                object_id : 0x2::object::uid_to_inner(&v6.id),
                creator   : v0,
                name      : v6.name,
            };
            0x2::event::emit<MintNFTEvent>(v7);
            0x2::transfer::public_transfer<NftBase>(v6, arg2);
            arg0.current_supply = arg0.current_supply + 1;
            arg1 = arg1 - 1;
        };
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

